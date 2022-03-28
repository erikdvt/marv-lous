//
//  ViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import Foundation
import UIKit

class LandingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var comicsTableView: UITableView!
    
    private var comics: ComicDataWrapper?
    private var httpHeaders: [String:String] = ["limit": "2",
                                                "title": "deadpool"]
    
    override func viewDidLoad() {
        getComics()
        super.viewDidLoad()
        self.comicsTableView.delegate = self
        self.comicsTableView.dataSource = self
        
    }
    
    func getComics() {
        
        let timeStamp = Date().timeIntervalSince1970
        
        let hashedString = "\(timeStamp)\(Constants.privateAPIKey)\(Constants.publicAPIKey)"
        
        let urlString = String(format: "https://gateway.marvel.com:443/v1/public/comics?apikey=%@&ts=%@&hash=%@&limit=10",
                         Constants.publicAPIKey,
                         String(timeStamp),
                         hashedString.md5)
        
        let url = URL(string: urlString)
        
        URLSession.shared.makeRequest(url: url, model: ComicDataWrapper.self, headers: httpHeaders) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let comicsArray):
                    self?.comics = comicsArray
                    self?.comicsTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comicsCount = comics?.data.results.count else { return 0 }
        return comicsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let comicsDataCell = tableView.dequeueReusableCell(withIdentifier: "ComicCell") as? ComicTableViewCell else { return UITableViewCell()}
        comicsDataCell.index = indexPath.row
        comicsDataCell.comics = comics
        comicsDataCell.setNeedsLayout()
        return comicsDataCell
    }
}
