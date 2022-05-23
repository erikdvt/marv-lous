//
//  FavouritesRepository.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/05/08.
//

import Foundation
import UIKit
import CoreData

typealias FavouriteComicResult = (Result<[SingleComicDetailsData], CustomError>) -> Void

protocol FavouritesRepositoryType {
    func saveFavourite(comic: FormattedComic)
    func fetchFavourites(completion: @escaping(FavouriteComicResult))
}

class FavouritesRepository: FavouritesRepositoryType {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var favComics: [SingleComicDetailsData]? = []
    
    func saveFavourite(comic: FormattedComic) {
        guard let safeContext = self.context else { return }
        let newFav = SingleComicDetailsData(context: safeContext)
        newFav.title = comic.title
        newFav.issue = comic.issue
        newFav.pages = comic.pages
        newFav.variant = comic.thumbnailLink
        newFav.price = comic.price
        newFav.comicDescription = comic.description
        newFav.releaseDate = comic.releaseDate
        newFav.copyright = comic.copyright
        newFav.thumbnailLink = comic.thumbnailLink
        
        do {
            try safeContext.save()
        } catch {
            
        }
    }
    
    func fetchFavourites(completion: @escaping(FavouriteComicResult)) {
        do {
            self.favComics = try context?.fetch(SingleComicDetailsData.fetchRequest())
            DispatchQueue.main.async {
                guard let safeWeatherLocations = self.favComics else {return}
                completion(.success(safeWeatherLocations))
            }
        } catch {
            DispatchQueue.main.async { completion(.failure(.internalError)) }
        }
    }
}
