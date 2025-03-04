//
//  LoginView.swift
//  HelloValidation
//
//  Created by Weerawut Chaiyasomboon on 04/03/2568.
//

import SwiftUI

struct LoginFormError {
    var emailError: String = ""
    var passwordError: String = ""
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginFormError = LoginFormError()
    
    private func clearForm() {
        loginFormError = LoginFormError()
    }
    
    private func isFormValid() -> Bool {
        clearForm()
        
        if email.isEmpty {
            loginFormError.emailError = "Email is required"
        } else if !email.isEmailValid {
            loginFormError.emailError = "Email is not correct format"
        }
        
        if password.isEmpty {
            loginFormError.passwordError = "Password is required"
        }
        
        return loginFormError.emailError.isEmpty && loginFormError.passwordError.isEmpty
    }
    
    var body: some View {
        Text("Login Version 01")
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    let _ = isFormValid()
                }
            if !loginFormError.emailError.isEmpty {
                Text(loginFormError.emailError)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            SecureField("Password", text: $password)
                .onSubmit {
                    let _ = isFormValid()
                }
            if !loginFormError.passwordError.isEmpty {
                Text(loginFormError.passwordError)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            Button("Login") {
                if isFormValid() {
                    print("Form submit")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    LoginView()
}
