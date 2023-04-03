//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol Serializer {
    func decode<Entity>(ofType: Entity.Type, data: Data, completion: @escaping (Entity) -> Void) where Entity : Codable
}
