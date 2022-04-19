//
//  DetailsViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/12.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var comicTitle: UILabel!
    
    var singleComic: Comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        comicTitle.text = singleComic?.title!
        
    }
}
