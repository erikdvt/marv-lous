//
//  FavouritesRepository.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/05/08.
//

import Foundation
import UIKit
import CoreData

typealias FavouriteLocationResult = (Result<ComicsModel, CustomError>) -> Void

protocol FavouriteWeatherForecastsRepositoryType {
    func saveFavourite(coordinates: Coord, cityName: String)
    func fetchFavourites(completion: @escaping(FavouriteLocationResult))
}

class FavouriteWeatherForecastsRepository: FavouriteWeatherForecastsRepositoryType {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var favLocations: [FavLocation]? = []
    
    func saveFavourite(coordinates: Coord, cityName: String) {
        
        
        
        guard let safeContext = self.context else { return }
        let newFav = FavLocation(context: safeContext)
        newFav.city = cityName
        newFav.lat = coordinates.lat
        newFav.lon = coordinates.lon
        do {
            try safeContext.save()
        } catch {
            
        }
    }
    
    func fetchFavourites(completion: @escaping(FavouriteLocationResult)) {
        do {
            self.favLocations = try context?.fetch(FavLocation.fetchRequest())
            DispatchQueue.main.async {
                guard let safeWeatherLocations = self.favLocations else {return}
                completion(.success(safeWeatherLocations))
            }
        } catch {
            DispatchQueue.main.async { completion(.failure(.internalError)) }
        }
    }
    
    func saveLastCurrent(data: FormattedCurrent) {
        guard let safeContext = self.context else { return }
        let newCur = CurrentWeatherItem(context: safeContext)
        newCur.maxTemp = data.maxTemp
        newCur.minTemp = data.minTemp
        newCur.currentTemp = data.currentTemp
        newCur.city = data.city
        newCur.conditionRaw = data.condition.rawValue
        newCur.today = Date()
        
        do {
            try safeContext.save()
        } catch {
            
        }
    }
    
    func fetchLastCurrent(completion: @escaping(LastCurrentResult)) {
        do {
            let request = CurrentWeatherItem.fetchRequest() as NSFetchRequest<CurrentWeatherItem>
            request.sortDescriptors = [NSSortDescriptor(key: "today", ascending: false)]
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            self.currentWeatherIt = try context?.fetch(request)
            DispatchQueue.main.async {
                guard let safeLastCurrent = self.currentWeatherIt else {return}
                completion(.success(safeLastCurrent))
            }
        } catch {
            DispatchQueue.main.async { completion(.failure(.internalError)) }
        }

    }
    
    func saveLastForecast(data: FormattedForecast) {
        guard let safeContext = self.context else { return }
        let newFor = WeatherForecastsItem(context: safeContext)
        
        newFor.today = data.today
        newFor.t1 = data.weather[0].temp
        newFor.c1 = data.weather[0].condition.rawValue
        newFor.t2 = data.weather[1].temp
        newFor.c2 = data.weather[1].condition.rawValue
        newFor.t3 = data.weather[2].temp
        newFor.c3 = data.weather[2].condition.rawValue
        newFor.t4 = data.weather[3].temp
        newFor.c4 = data.weather[3].condition.rawValue
        newFor.t5 = data.weather[4].temp
        newFor.c5 = data.weather[4].condition.rawValue

        do {
            try safeContext.save()
        } catch {
            
        }
    }
    
    func fetchLastForecast(completion: @escaping(LastForecastResult)) {
        do {
            let request = WeatherForecastsItem.fetchRequest() as NSFetchRequest<WeatherForecastsItem>
            request.sortDescriptors = [NSSortDescriptor(key: "today", ascending: false)]
            request.fetchLimit = 1
            request.returnsObjectsAsFaults = false
            
            self.weatherForecastIt = try context?.fetch(request)
            DispatchQueue.main.async {
                guard let safeLastForecast = self.weatherForecastIt else {return}
                completion(.success(safeLastForecast))
            }
        } catch {
            DispatchQueue.main.async { completion(.failure(.internalError)) }
        }
    }
}
