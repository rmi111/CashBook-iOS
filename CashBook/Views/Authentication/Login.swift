//
//  Login.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 5/7/25.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift
import GoogleSignIn


struct SignUpView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isSigningIn: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                    .frame(height: geometry.size.height * 0.3)
                
                // App Icon
                Image(systemName: "dollarsign.circle.fill") // Replace with your app icon
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 16)

                // Description Text
                Text("Welcome to Budgetify")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                Text("Track your spending. Grow your savings.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                Spacer()
                
                // Sign In Buttons
                VStack(spacing: 12) {
                    SignInWithAppleButton()
                    
                    SignInWithGoogleButton()
                        .onTapGesture {
                            Task {
                                isSigningIn = true
                                await authViewModel.signInWithGoogle()
                                dismiss()
                                isSigningIn = false
                            }
                        }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct SignInWithAppleButton: View {
    var body: some View {
        HStack {
            Image(systemName: "applelogo")
            Text("Sign in with Apple")
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct SignInWithGoogleButton: View {
    var body: some View {
        HStack {
            Image("google-icon") // Add your Google icon asset to Assets
                .resizable()
                .frame(width: 20, height: 20)
            Text("Sign in with Google")
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .foregroundColor(.black)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(10)
    }
}


struct LoginView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isSigningIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()
                
                Text(UIStrings.appName.localizedKey)
                    //.foregroundStyle(Color(.bbWhite))
                    //.font(.poppinsFontBold)
                    .padding()
                
                Spacer()
                
                
                //MARK: GOOGLE SIGN IN
                if isSigningIn {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                       // .padding().background(Color(.bbGreenDark))
                } else {
                    
                    GoogleSignInButton {
                        Task {
                            isSigningIn = true
                            await authViewModel
                                .signInWithGoogle()
                            dismiss()
                            isSigningIn = false
                        }
                        
                    }
                    .frame(width: 280, height: 45, alignment: .center)
                    .disabled(authViewModel.isLoading)
                    
                }
                
                // MARK: Anonymous
                if(authViewModel.authState == .signedOut){
                    Button {
                        Task {
                            isSigningIn = true
                            await authViewModel.signInAnonymously()
                            dismiss()
                            isSigningIn = false
                        }
                    } label: {
                        Text(UIStrings.skip.localizedKey)
                            .font(.body.bold())
                            .frame(width: 280, height: 45, alignment: .center)
                           // .foregroundStyle(.bbWhite)
                         //   .font(.poppinsFontRegular)
                    }
                    .disabled(authViewModel.isLoading)
                }
                
                
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(Color(.bbGreenDark))
            
        }
    }
}
