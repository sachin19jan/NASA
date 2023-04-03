//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol URLQueryItemProvider {
    func getAuthenticationItem() -> URLQueryItem
    func get(date: Date) -> URLQueryItem
}
