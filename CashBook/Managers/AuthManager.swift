//
//  AuthManager.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 5/6/25.
//


import Foundation
import FirebaseAuth
import FirebaseCore
import CryptoKit
import GoogleSignIn
import AuthenticationServices
import FirebaseFirestore


class AuthService: NSObject, ObservableObject, ASAuthorizationControllerDelegate  {
    
    @Published var signedIn:Bool = false
    
    // Unhashed nonce.
    var currentNonce: String?
    
    override init() {
        super.init()
        _ = Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.signedIn = true
                print("Auth state changed, is signed in")
            } else {
                self.signedIn = false
                print("Auth state changed, is signed out")
            }
        }
    }
    
    // MARK: - Password Account
    // Create, sign in, and sign out from password account functions...
    
    //MARK: - Apple sign in
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    // Single-sign-on with Apple
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
       
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // Initialize a Firebase credential.
//            let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                      idToken: idTokenString,
//                                                      rawNonce: nonce)
            
            let credential = OAuthProvider.credential( providerID: .apple, idToken: idTokenString, rawNonce: nonce, accessToken: appleIDCredential.authorizationCode?.base64EncodedString() )
            
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print(error?.localizedDescription ?? "")
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                print("Apple sign in!")
                
                // Allow proceed to next screen
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    let database = Firestore.firestore()
    
    private let authLinkErrors: [AuthErrorCode] = [
        .emailAlreadyInUse,
        .credentialAlreadyInUse,
        .providerAlreadyLinked,
    ]
    
    private init() {}
    
   
    // MARK: Fetch User Details from Firestore
    func fetchUser(userID: String) async throws -> Users? {
        let userRef = database.collection(FirebasePaths.users.rawValue).document(userID)
        
        do {
            let document = try await userRef.getDocument()
            if let data = document.data() {
                let user = try Firestore.Decoder().decode(Users.self, from: data)
                print("Fetched user details: \(user)")
                return user
            } else {
                print("No user details found for ID: \(userID)")
                return nil
            }
        } catch {
            print("Error fetching user details: \(error)")
            throw error
        }
    }
    
    
    
    // MARK: Sign in Anonymously
    func signInAnonymously() async throws -> AuthDataResult {
        do {
            let result = try await auth.signInAnonymously()
            print("Signed in anonymously:\(result.user.uid)")
            
            let guestUserName = "Guest-\(Int.random(in: 1000...9999))"
            
            
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = guestUserName
            try await changeRequest.commitChanges()
            
            try await saveUserToFireStore(user: result.user)
            return result
        } catch {
            print("Error signing in anonymously: \(error)")
            throw error
        }
    }
    
    
    private func authenticateUser(credentials: AuthCredential) async throws -> AuthDataResult? {
        if auth.currentUser != nil {
            return try await authLink(credentials: credentials)
        } else {
            return try await authSignIn(credentials: credentials)
        }
    }
    
    private func authLink(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            guard let user = auth.currentUser else {
                return nil
            }
            
            let result = try await user.link(with: credentials)
            await updateDisplayName(for: result.user)
            try await saveUserToFireStore(user: user,shouldUpdate: true)
            return result
        } catch {
            if let error = error as NSError? {
                if let code = AuthErrorCode.self(rawValue: error.code),
                   authLinkErrors.contains(code) {
                    return try await self.authSignIn(credentials: credentials)
                }
            }
            print("Firebase Auth Error: link(with:) failed, \(error)")
            throw error
        }
        
    }
    
    
    private func authSignIn(credentials: AuthCredential) async throws -> AuthDataResult {
        do {
            let result = try await auth.signIn(with: credentials)
            return result
        } catch {
            print("FirebaseAuthError: signIn(with:) failed: \(error)")
            throw error
        }
    }
    
    private func updateDisplayName(for user: User) async {
        
        if let currentDisplayName = user.displayName, !currentDisplayName.isEmpty,
           currentDisplayName.starts(with: "Guest-") == false{
            return // The user already has a name, so no need to override.
        }
        
        let displayName = user.providerData.first?.displayName
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        
        do {
            try await changeRequest.commitChanges()
            print("Display name updated to: \(displayName ?? "Unknown")")
        } catch {
            print("Failed to update display name: \(error)")
        }
    }
    
    // MARK: Google Sign In
    func signInWithGoogle(user: GIDGoogleUser) async throws -> AuthDataResult {
        guard let idToken = user.idToken?.tokenString else {
            throw NSError(
                domain: "AuthManager",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve Google ID Token"])
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        
        do {
            let result = try await authenticateUser(credentials: credential)
            
            print("Signed in with Google: \(result?.user.uid ?? "Unkown User")")
            
            if let user = result?.user {
                try await saveUserToFireStore(user: user)
            }
            
            guard let result = result else {
                throw NSError(
                    domain: "AuthManager",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Failed to authenticate user"]
                )
            }
            
            return result
            
        } catch {
            print("Google sign-in error: \(error)")
            throw error
        }
    }
    
    // MARK: -Save User to Firestore
    private func saveUserToFireStore(user: User, shouldUpdate: Bool = false) async throws {
        let userRef = database
            .collection(FirebasePaths.users.rawValue)
            .document(user.uid)
        
        
        let document = try await userRef.getDocument()
        
        if document.exists && !shouldUpdate {
            print("User already exists in Firestore: \(user.uid)")
            return
        }
        
        let users = Users(
            id: user.uid,
            userName: user.displayName ?? "",
            userEmail: user.email ?? ""
        )
        
        do {
            try userRef.setData(from: users)
            print("User saved to Firestore: \(user.uid)")
        } catch {
            print("Error saving user to Firestore: \(error)")
            throw error
        }
    }
    
    // MARK: - Sign out
    func signOut() throws {
        
        if let user = auth.currentUser {
            do {
                signOutFromProviders(user)
                try auth.signOut()
                print("User signed out")
            } catch {
                print("Error signing out: \(error)")
                throw error
            }
        }
    }
    
    private func signOutFromProviders( _ user: User) {
        let providers = user.providerData.map { $0.providerID }.joined(separator: ", ")
        
        if providers.contains("google.com") {
            GoogleSignInManager.shared.signOutFromGoogle()
            print("Signed out from Google")
        }
    }
}

