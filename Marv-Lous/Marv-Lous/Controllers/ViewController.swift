//
//  ViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import UIKit

class ViewController: UIViewController {
    
    private var comics: ComicDataWrapper?
    private var httpHeaders: [String:String] = ["limit": "2",
                                                "title": "deadpool"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getComics()
        
    }
    
    func getComics() {
        
        let timeStamp = Date().timeIntervalSince1970
        
        let hashedString = "\(timeStamp)\(Constants.privateAPIKey)\(Constants.publicAPIKey)"
        
        let urlString = String(format: "https://gateway.marvel.com:443/v1/public/comics?apikey=%@&ts=%@&hash=%@",
                         Constants.publicAPIKey,
                         String(timeStamp),
                         hashedString.md5)
        
        let url = URL(string: urlString)
        
        URLSession.shared.makeRequest(url: url, model: ComicDataWrapper.self, headers: httpHeaders) { [weak self] result in
            
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
