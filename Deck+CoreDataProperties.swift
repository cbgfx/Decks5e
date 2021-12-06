//
//  Deck+CoreDataProperties.swift
//  Decks5e
//
//  Created by Guest on 2021-12-06.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var deckName: String?
    @NSManaged public var cards: Card?

}

extension Deck : Identifiable {

}
