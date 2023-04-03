//
//  Created by Sachin, Bhardwaj
//

import UIKit

protocol ImageDownloadService {
    func runDownload(link: String, completion: @escaping (UIImage?) -> Void)
}
