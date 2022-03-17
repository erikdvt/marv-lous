//
//  ViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import UIKit

class ViewController: UIViewController {
    
    // Creates an array of users that we can reference the data
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calls the function that will execute get users api call
        getUsers()
    }
    
    // Function that will handle the logic for requesting the api call
    func getUsers() {
        
        // Asks the url session to make a call to our custom function
        URLSession.shared.makeRequest(url: Constants.usersURL, model: [User].self) { result in
            
            // Swift the state of the result
            switch result {
            case .success(let userArray):
                print(userArray.description)
            case .failure(let error):
                print(error)
            }
        }
    }
}
