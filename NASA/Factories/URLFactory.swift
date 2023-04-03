//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol URLFactory {
    func createRequest(date: Date) -> URL
    func createRequest(link: String) -> URL
}
