import Foundation
import CoreData

@objc(SeedCheck)
public class SeedCheck: NSManagedObject, Codable {
	enum CodingKeys: String, CodingKey{
		case isSeeded
	}
	// MARK: - Decodable
	
	required public convenience init(from decoder: Decoder) throws {
		guard let contextUserInfoKey = CodingUserInfoKey.context,
		let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
		let entity = NSEntityDescription.entity(forEntityName: DBManager.EntityNames.seed.rawValue, in: managedObjectContext) else {
				fatalError("Failed to decode Seed")
		}
			
		self.init(entity: entity, insertInto: managedObjectContext)
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		do {
			self.isSeeded = try container.decode(Bool.self, forKey: .isSeeded)
			
		} catch let errror as NSError {
			print("Decoding Seed error: ", errror)
		}
	}
	
	
	public func encode(to encoder: Encoder) throws {
		
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(isSeeded, forKey: .isSeeded)

	}
	
}

// MARK: - Campaign

extension SeedCheck {
	
	class func initialize(isSeeded: Bool = false) -> SeedCheck {
		
		let context = DBManager.getCoreDataContext()
		let desc = NSEntityDescription.entity(forEntityName: DBManager.EntityNames.seed.rawValue, in: context!)
		let managedObject = NSManagedObject(entity: desc!, insertInto: context) as! SeedCheck
		
		managedObject.setValue(isSeeded, forKey: CodingKeys.isSeeded.rawValue)
		
		
		return managedObject
	}
	
}
