//
//  SingleComicDetailsData+CoreDataProperties.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/05/22.
//
//

import Foundation
import CoreData


extension SingleComicDetailsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleComicDetailsData> {
        return NSFetchRequest<SingleComicDetailsData>(entityName: "SingleComicDetailsData")
    }

    @NSManaged public var title: String?
    @NSManaged public var issue: String?
    @NSManaged public var variant: String?
    @NSManaged public var pages: String?
    @NSManaged public var price: String?
    @NSManaged public var copyright: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var comicDescription: String?
    @NSManaged public var thumbnailLink: String?

}

extension SingleComicDetailsData : Identifiable {

}
