//
//  ViewController.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import Foundation
import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var comicsTableView: UITableView!
    
    private lazy var viewModel = LandingPageViewModel(delegate: self,
                                                      repository: SearchComicRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover"
        setupTableView()
        viewModel.fetchComicList()
    }
    
    func setupTableView() {
        self.comicsTableView.delegate = self
        self.comicsTableView.dataSource = self
    }
}

// MARK: - TableView Delagate

extension LandingPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comicCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let comicsDataCell = tableView.dequeueReusableCell(withIdentifier: "ComicCell") as? ComicTableViewCell else { return UITableViewCell()}
        guard let comic = viewModel.comic(atIndex: indexPath.row) else { return UITableViewCell() }
        comicsDataCell.populateWith(comic: comic)
        comicsDataCell.setNeedsLayout()
        
        return comicsDataCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailView", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            guard let comicIndex = comicsTableView.indexPathForSelectedRow?.row else { return }
            destination.setComicDetails(comic: viewModel.comic(atIndex: comicIndex), copyright: viewModel.copyrightLabel())
        }
    }
}

// MARK: - ViewModel Delagate

extension LandingPageViewController: ViewModelDelegate {
    func reloadView() {
        comicsTableView.reloadData()
    }
    
    func showError(_ error: String) {
        print(error)
    }
}
