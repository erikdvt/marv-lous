//
//  LandingPageViewModel.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/29.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func showError(_ error: String)
}

class LandingPageViewModel {
    
    private var comicList: ComicsModel?
    private weak var delegate: ViewModelDelegate?
    private var repository: SearchComicRepositoryType

    init(delegate: ViewModelDelegate?,
         repository: SearchComicRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    var comicCount: Int {
        return comicList?.data.results.count ?? 0
    }
    
    func comic(atIndex: Int) -> Comic? {
        return comicList?.data.results[atIndex] ?? nil
    }
    
    func copyrightLabel() -> String? {
        return comicList?.copyright ?? ""
    }
    
    func fetchComicList() {
        repository.fetchSearchResults(completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comicList):
                    self?.comicList = comicList
                    self?.delegate?.reloadView()
                case .failure(let error):
                    self?.delegate?.showError(error.rawValue)
                }
            }
        })
    }

}
