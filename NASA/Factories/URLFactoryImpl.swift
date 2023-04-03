//
//  Created by Sachin, Bhardwaj
//

import Foundation
 
internal class URLFactoryImpl : URLFactory {
    private var urlComponentsProvider: URLComponentsProvider!
    private var urlQueryItemProvider: URLQueryItemProvider!
    private var urlValidator: URLValidator!
    
    init() {
        urlComponentsProvider = URLComponentsProviderImpl()
        urlQueryItemProvider = URLQueryItemProviderImpl()
        urlValidator = URLValidatorImpl()
    }
    
    internal func createRequest(date: Date) -> URL {
        var request = urlComponentsProvider.get()
        request.queryItems = [
            urlQueryItemProvider.getAuthenticationItem(),
            urlQueryItemProvider.get(date: date)
        ]
        return urlValidator.validate(request.url)
    }
    
    internal func createRequest(link: String) -> URL {
        let url = URL(string: link)
        return urlValidator.validate(url)
    }
}
