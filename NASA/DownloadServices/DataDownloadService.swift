//
//  Created by Sachin, Bhardwaj
//

import Foundation

protocol DataDownloadService {
    func runDownload(date: Date, completion: @escaping (Data) -> Void)
}
