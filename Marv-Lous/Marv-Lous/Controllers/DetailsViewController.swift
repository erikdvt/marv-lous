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
    
    private lazy var viewModel = DetailsViewModel(delegate: self)
    
    @IBAction private func buyButtonPressed(_ sender: UIButton) {
        guard let buyLink = URL(string: "https://www.google.com") else { return }
        UIApplication.shared.open(buyLink, options: [:], completionHandler: nil)
    }
    
    @IBAction private func addButtonPressed(_ sender: UIButton) {
        print("Add button pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        showComicDetails()
    }
    
    func setComicDetails(comic: Comic?, copyright: String?) {
        viewModel.setComicInfo(comic, copyright)
    }
    
    private func showComicDetails() {
        let comicData = viewModel.formatComicData()
        
        comicTitle.text = comicData.title
        comicIssue.text = comicData.issue
        comicPages.text = comicData.pages
        comicVariant.text = comicData.variant
        comicDescription.text = comicData.description
        comicCopyright.text = comicData.copyright
        comicPrice.setTitle(comicData.price, for: .normal)
        if let thumbnailURL = comicData.thumbnailLink {
            comicThumbnail.loadImageFromURL(imageURL: thumbnailURL)
        }
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func showError(_ error: String) {
        print(error)
    }
    
    func likeComic() {
        print("Comic Liked")
    }
}
