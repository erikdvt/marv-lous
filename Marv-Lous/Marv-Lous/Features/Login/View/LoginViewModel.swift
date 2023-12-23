//
//  LoginViewModel.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/01.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func showError(_ error: String)
    func navigateToLandingPage()
}

class LoginViewModel {
    private weak var delegate: LoginViewModelDelegate?
    
    init(delegate: LoginViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func attemptLogin(_ username: String?, _ password: String?) {
        if !username.hasValue && !password.hasValue {
            delegate?.showError("Please enter username and password.")
        } else if !username.hasValue {
            delegate?.showError("Username field is empty.")
        } else if !password.hasValue {
            delegate?.showError("Password field is empty.")
        } else if (username == "Admin" && password == "TestPass123") {
            delegate?.navigateToLandingPage()
        } else {
            delegate?.showError("Invalid username and/or password.")
        }
    }
}
