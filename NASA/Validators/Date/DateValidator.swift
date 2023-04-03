//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol DateValidator {
    func validate(dateComponents: DateComponents, calendar: Calendar) -> DateComponents
    func validate(_ date: Date?) -> Date
}
