//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol EntityValidator {
    func validate<Entity>(_ entity: Entity?) -> Entity where Entity : Codable
}
