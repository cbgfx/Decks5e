//
//  SeedCheck+CoreDataProperties.swift
//  Decks5e
//
//  Created by Guest on 2021-12-06.
//
//

import Foundation
import CoreData


extension SeedCheck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeedCheck> {
        return NSFetchRequest<SeedCheck>(entityName: "SeedCheck")
    }

    @NSManaged public var isSeeded: Bool

}

extension SeedCheck : Identifiable {

}
