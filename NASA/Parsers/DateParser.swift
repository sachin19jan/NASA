//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol DateParser {
    func parseToString(date: Date) -> String
    func parseToString(date: Date, format: String) -> String
}
