//
//  LoginPageViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/01.
//

import Foundation
import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private lazy var loginPageViewModel = LoginPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    @IBAction private func loginButtonPressed(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        loginPageViewModel.attemptLogin(username, password)
    }
    
    func setupTextFields() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - Text Field Delegate Methods
extension LoginPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginPageViewController: LoginPageViewModelDelegate {
    func showError(_ error: String) {
        usernameTextField.text = ""
        passwordTextField.text = ""
        self.showAlert(title: "Login unsuccesful",
                       message: error,
                       button: "Retry")
    }
    
    func navigateToLandingPage() {
        self.performSegue(withIdentifier: "goToLandingPage", sender: self)
    }
}
