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
    private var comicList: ComicsModel?
    private weak var delegate: FavouritesViewModelDelegate?
    private var repository: FavouritesRepositoryType
    
    
}
