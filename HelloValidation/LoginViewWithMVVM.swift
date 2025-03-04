//
//  LoginViewWithMVVM.swift
//  HelloValidation
//
//  Created by Weerawut Chaiyasomboon on 04/03/2568.
//

import SwiftUI

//MARK: - Error
enum LoginError: Error, LocalizedError {
    case emailEmpty
    case emailNotValid
    case passowrdEmpty
    
    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email is empty"
        case .emailNotValid:
            return "Email is not valid"
        case .passowrdEmpty:
            return "Password is empty"
        }
    }
}

//MARK: - ViewModel
struct LoginState {
    var email: String = ""
    var password: String = ""
    var emailError: LoginError?
    var passwordError: LoginError?
    
    mutating func clearErrors() {
        emailError = nil
        passwordError = nil
    }
    
    mutating func isValid() -> Bool {
        clearErrors()
        
        if email.isEmpty {
            emailError = .emailEmpty
        } else if !email.isEmailValid {
            emailError = .emailNotValid
        }
        
        if password.isEmpty {
            passwordError = .passowrdEmpty
        }
        
        return emailError == nil && passwordError == nil
    }
}

//MARK: - View
struct LoginViewWithMVVM: View {
    @State private var loginState = LoginState()
    
    var body: some View {
        Text("Login with MVVM")
        Form {
            TextField("Email", text: $loginState.email)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    let _ = loginState.isValid()
                }
            if let emailError = loginState.emailError {
                Text(emailError.localizedDescription)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            SecureField("Password", text: $loginState.password)
                .onSubmit {
                    let _ = loginState.isValid()
                }
            if let passwordError = loginState.passwordError {
                Text(passwordError.localizedDescription)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            Button("Login") {
                if loginState.isValid() {
                    
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    LoginViewWithMVVM()
}
