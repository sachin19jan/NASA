//
//  Created by Sachin, Bhardwaj
//

import Foundation
import UIKit

final class NasaStorage: Codable {
    internal var deatils: String
    internal var name: String
    
    init(deatils: String, name: String) {
        self.deatils = deatils
        self.name = name
    }
}
