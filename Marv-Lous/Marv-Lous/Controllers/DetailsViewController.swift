//
//  DetailsViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/12.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var comicThumbnail: UIImageView!
    @IBOutlet private weak var comicTitle: UILabel!
    @IBOutlet private weak var comicIssue: UILabel!
    @IBOutlet private weak var comicPages: UILabel!
    @IBOutlet private weak var comicVariant: UILabel!
    @IBOutlet private weak var comicPrice: UIButton!
    @IBOutlet private weak var comicDescription: UILabel!
    @IBOutlet private weak var comicReleaseDate: UILabel!
    @IBOutlet private weak var comicCopyright: UILabel!
    
    @IBAction private func buyButtonPressed(_ sender: UIButton) {
        print("Buy button pressed")
    }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        print("Add button pressed")
    }
    
    var singleComic: Comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        setComicDetails()
    }
    
    func setComicDetails() {
        
        if let thumbnailPath = singleComic?.thumbnail?.path {
            let thumbnailExtension = singleComic?.thumbnail?.extension ?? "strings"
            let comicThumbnailURL = thumbnailPath.buildImageURL(quality: "detail", imageExtension: thumbnailExtension).convertToHttps
            comicThumbnail.loadImageFromURL(imageURL: comicThumbnailURL)
        }
        
        comicTitle.text = singleComic?.title
        //comicIssue.text = singleComic?.issueNumber
        //comicPages.text = singleComic?.pageCount
        comicVariant.text = singleComic?.variantDescription
        comicPrice.setTitle("$5.00", for: .normal)
        comicDescription.text = singleComic?.description
        //comicReleaseDate.text = singleComic?.dates[0].date
        comicCopyright.text = "Copyright Marvel"
        }
}
