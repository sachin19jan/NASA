//
//  Created by Sachin, Bhardwaj
//

import Foundation

internal class URLComponentsProviderImpl : URLComponentsProvider {
    private var validator: URLComponentsValidator!
    
    init() {
        validator = URLComponentsValidatorImpl()
    }
    
    internal func get() -> URLComponents {
        let urlCompoments = URLComponents(string: "https://api.nasa.gov/planetary/apod")
        return validator.validate(urlCompoments)
    }
}
