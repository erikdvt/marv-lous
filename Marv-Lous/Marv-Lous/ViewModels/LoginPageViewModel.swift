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
        
        if username.isEmpty && password.isEmpty {
            self.delegate?.showError("Please enter username and password.")
        } else if username.isEmpty {
            self.delegate?.showError("Username field is empty.")
        } else if password.isEmpty {
            self.delegate?.showError("Password field is empty.")
        } else if (username == "Admin" && password == "TestPass123") {
            self.delegate?.navigateToLandingPage()
        } else {
            self.delegate?.showError("Invalid username and/or password.")
        }
    }
}
