//
//  LoginPageViewModel.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/01.
//

import Foundation

protocol LoginPageViewModelDelegate: AnyObject {
    func showError(_ error: String)
    func navigateToLandingPage()
}

class LoginPageViewModel {
    private weak var delegate: LoginPageViewModelDelegate?
    private var username = ""
    private var password = ""
    
    init(delegate: LoginPageViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func attemptLogin(_ username: String, _ password: String) {
        self.username = username
        self.password = password
        
        switch credentialsInput() {
        case .correct:
            self.delegate?.navigateToLandingPage()
        case .incorrect:
            return
        }
    }
    
    func credentialsInput() -> CredentialsInputStatus {
        if username.isEmpty && password.isEmpty {
            self.delegate?.showError("Please enter username and password.")
            return .incorrect
        } else if username.isEmpty {
            self.delegate?.showError("Username field is empty.")
            return .incorrect
        } else if password.isEmpty {
            self.delegate?.showError("Password field is empty.")
            return .incorrect
        } else if (username == "Admin" && password == "TestPass123") {
            return .correct
        } else {
            self.delegate?.showError("Invalid username and/or password.")
            return .incorrect
        }
    }
}

extension LoginPageViewModel {
    enum CredentialsInputStatus {
        case correct
        case incorrect
    }
}
