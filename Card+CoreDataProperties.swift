//
//  Card+CoreDataProperties.swift
//  Decks5e
//
//  Created by Guest on 2021-12-05.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var drawn: Bool
    @NSManaged public var deckName: Deck?

}
