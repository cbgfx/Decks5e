//
//  NPCModel+CoreDataClass.swift
//  npc-manager
//
//  Created by Elie El Khoury on 4/22/20.
//  Copyright © 2020 DMTools. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject, Codable {
	

	enum CodingKeys: String, CodingKey {
		//Attributes
		case title
		case detail
		case drawn
		case pic
		case deckName
	}
	
	required public convenience init(from decoder: Decoder) throws {
		guard let contextUserInfoKey = CodingUserInfoKey.context,
		let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
		let entity = NSEntityDescription.entity(forEntityName: DBManager.EntityNames.card.rawValue, in: managedObjectContext) else {
				fatalError("Failed to decode Card")
		}
			
		self.init(entity: entity, insertInto: managedObjectContext)
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		do {
			self.title = try container.decode(String.self, forKey: .title)
			self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
			self.drawn = try container.decode(Bool.self, forKey: .drawn)
			self.pic = try container.decode(Data.self, forKey: .pic)

			self.deckName = try container.decode(String.self, forKey: .deckName)

			
		} catch let errror as NSError {
			print("Decoding Card error: ", errror)
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		//Attributes
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(title, forKey: .title)
		try container.encode(detail, forKey: .detail)
		try container.encode(drawn, forKey: .drawn)
		try container.encode(pic, forKey: .pic)
		
		try container.encode(deckName, forKey: .deckName)

	}
}

// MARK: - NPC

extension Card {

	class func initialize(pic: Data? = nil, title: String = "", detail: String = "", drawn: Bool = false, deckName: String) -> Card {

		let context = DBManager.getCoreDataContext()

		// Create the Entity Description
		let desc = NSEntityDescription.entity(forEntityName: DBManager.EntityNames.card.rawValue, in: context!)

		let managedObject = NSManagedObject(entity: desc!, insertInto: context) as! Card
		
		managedObject.setValue(title, forKey: "title")
		managedObject.setValue(detail, forKey: "detail")
		managedObject.setValue(drawn, forKey: "drawn")
		managedObject.setValue(pic, forKey: "pic")
		managedObject.setValue(deckName, forKey: "deckName")


		return managedObject
	}
	
	
}
