//
//  GoogleSignInManager.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 5/6/25.
//



import Foundation
import GoogleSignIn
import FirebaseCore

class GoogleSignInManager {
    static let shared = GoogleSignInManager()
    typealias GoogleAuthResult = (GIDGoogleUser?, Error?) -> Void
    
    private init() {}
    
    @MainActor
    func signInWithGoogle() async throws -> GIDGoogleUser? {
        guard let clientID = FirebaseApp.app()?.options.clientID else {  return try await googleSignInFlow() }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

      
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            do {
                try await GIDSignIn.sharedInstance.restorePreviousSignIn()
                return try await GIDSignIn.sharedInstance.currentUser?.refreshTokensIfNeeded()
                
                
            } catch {
                return try await googleSignInFlow()
            }
        } else {
            return try await googleSignInFlow()
        }
    }
    
    
    @MainActor
    private func googleSignInFlow() async throws -> GIDGoogleUser? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        
        guard let rootViewController = windowScene.windows.first?.rootViewController else {
            return nil
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        return result.user
    }
    
    func signOutFromGoogle() {
        GIDSignIn.sharedInstance.signOut()
    }
    
}
