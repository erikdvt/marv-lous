//
//  FavouritesViewModel.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/05/08.
//

import Foundation

protocol FavouritesViewModelDelegate: AnyObject {
    func reloadView()
    func showError(_ error: String)
}

class FavouritesViewModel {
    private var favComics: [Comic] = []
    private weak var delegate: FavouritesViewModelDelegate?
    private var repository: FavouritesRepositoryType
    
    init(delegate: FavouritesViewModelDelegate?, repository: FavouritesRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    public func displayFavComics() {
        
    }
    
    public var comicCount: Int {
        return favComics.count
    }
    
    public func saveComic(newComic: Comic?) {
        guard let safeComic = newComic else { return }
        
    }
}
