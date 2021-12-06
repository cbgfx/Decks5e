import Foundation
import CoreData

@objc(Deck)
public class Deck: NSManagedObject, Codable {
	enum CodingKeys: String, CodingKey{
		case deckName
		case cards
	}
	// MARK: - Decodable
	
	required public convenience init(from decoder: Decoder) throws {
		guard let contextUserInfoKey = CodingUserInfoKey.context,
		let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
		let entity = NSEntityDescription.entity(forEntityName: DBManager.EntityNames.deck.rawValue, in: managedObjectContext) else {
				fatalError("Failed to decode Campaign")
		}
			
		self.init(entity: entity, insertInto: managedObjectContext)
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		do {
			self.deckName = try container.decode(String.self, forKey: .deckName)
		//	self.cards = NSSet(array: try container.decode([Card].self, forKey: .cards))
			
		} catch let errror as NSError {
			print("Decoding Deck error: ", errror)
		}
	}
	
	
	public func encode(to encoder: Encoder) throws {
		
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(deckName, forKey: .deckName)
//		if let cardArray = self.cards?.allObjects as? [Card] {
//			try container.encode(cardArray, forKey: .cards)
//		}

	}
	
}

// MARK: - Campaign

extension Deck {
	
	class func initialize(deckName: String = "", cards: [Card]? = nil) -> Deck {
		
		let context = DBManager.getCoreDataContext()
		let desc = NSEntityDescription.entity(forEntityName: DBManager.EntityNames.deck.rawValue, in: context!)
		let managedObject = NSManagedObject(entity: desc!, insertInto: context) as! Deck
		
		managedObject.setValue(deckName, forKey: CodingKeys.deckName.rawValue)
		
		if let cardArray = cards {
			managedObject.setValue(NSSet(array: cardArray), forKey: CodingKeys.cards.rawValue)
		}
		
		return managedObject
	}
	
}
