//
//  ViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import UIKit

class ViewController: UIViewController {
    
    // Creates an array of users that we can reference the data
    private var comics: ComicDataWrapper?
    private var httpHeaders: [String:String] = ["limit": "2",
                                                "title": "deadpool"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calls the function that will execute get users api call
        getComics()
        
    }
    
    // Function that will handle the logic for requesting the api call
    func getComics() {
        
        // Generate timestamp for api call
        let timeStamp = Date().timeIntervalSince1970
        
        // Generate hashed string for api call
        let hashedString = "\(timeStamp)\(Constants.privateAPIKey)\(Constants.publicAPIKey)"
        
        // Build unique URL for request
        let urlString = String(format: "https://gateway.marvel.com:443/v1/public/characters?apikey=%@&ts=%@&hash=%@",
                         Constants.publicAPIKey,
                         String(timeStamp),
                         hashedString.md5)
        // Covert string to URL
        let url = URL(string: urlString)
        
        // Asks the url session to make a call to our custom function
        URLSession.shared.makeRequest(url: url, model: ComicDataWrapper.self, headers: httpHeaders) { [weak self] result in
            
            // Swift the state of the result
            switch result {
            case .success(let comicsArray):
                self?.comics = comicsArray
                print(comicsArray.data!.results!.description)
            case .failure(let error):
                print(error)
            }
        }
    }
}
