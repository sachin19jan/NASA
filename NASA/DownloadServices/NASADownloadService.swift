//
//  Created by Sachin, Bhardwaj
//

import Foundation

internal class NASADownloadService : DataDownloadService {
    private var urlFactory: URLFactory!
    private var urlSessionValidator: URLSessionValidator!
    
    init() {
        urlFactory = URLFactoryImpl()
        urlSessionValidator = URLSessionValidatorImpl()
    }
    
    internal func runDownload(date: Date, completion: @escaping (Data) -> Void) {
        let requestURL = getRequestURL(date: date)

        DispatchQueue.global(qos: .userInteractive).async {
            _ = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                self.urlSessionValidator.validate(error: error)
                _ = self.urlSessionValidator.validate(urlReponse: response)
                let data = self.urlSessionValidator.validate(data: data)
                DispatchQueue.main.async {
                    completion(data)
                }
            }.resume()
        }
    }
    
    private func getRequestURL(date: Date) -> URL {
        return urlFactory.createRequest(date: date)
    }
}
