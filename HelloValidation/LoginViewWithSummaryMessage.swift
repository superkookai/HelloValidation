//
//  LoginViewWithSummaryMessage.swift
//  HelloValidation
//
//  Created by Weerawut Chaiyasomboon on 04/03/2568.
//

import SwiftUI

enum LoginErrorS: Error, LocalizedError, Identifiable {
    case emailEmpty
    case emailNotValid
    case passowrdEmpty
    
    var id: Int {
        hashValue
    }
    
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

struct LoginViewWithSummaryMessage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errors: [LoginErrorS] = []
    
    private func isFormValid() -> Bool {
        errors.removeAll()
        
        if email.isEmpty {
            errors.append(.emailEmpty)
        } else if !email.isEmailValid {
            errors.append(.emailNotValid)
        }
        
        if password.isEmpty {
            errors.append(.passowrdEmpty)
        }
        
        return errors.isEmpty
    }
    
    var body: some View {
        Text("Login With Message Summary")
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    let _ = isFormValid()
                }
            
            SecureField("Password", text: $password)
                .onSubmit {
                    let _ = isFormValid()
                }
            
            Button("Login") {
                if isFormValid() {
                    print("Form submit")
                }
            }
            .frame(maxWidth: .infinity)
            
            ValidationSummaryView(errors: errors)
        }
    }
}

#Preview {
    LoginViewWithSummaryMessage()
}

struct ValidationSummaryView: View {
    let errors: [LoginErrorS]
    
    var body: some View {
        ForEach(errors) { error in
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}
