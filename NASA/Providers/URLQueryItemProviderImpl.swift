//
//  Created by Sachin, Bhardwaj
//

import Foundation

internal class URLQueryItemProviderImpl : URLQueryItemProvider {
    private var dateParser: DateParser!
    private let API_KEY = "t3OZMp8RugOcdSvExl56fbn13BP1ZxJo7BGlchzm"
    private let PARAMETER_NAME = "api_key"
    
    init() {
        dateParser = DateParserImpl()
    }
    
    internal func getAuthenticationItem() -> URLQueryItem {
        return URLQueryItem(name: PARAMETER_NAME, value: API_KEY)
    }
    
    internal func get(date: Date) -> URLQueryItem {
        return URLQueryItem(name: "date", value: dateParser.parseToString(date: date))
    }
}
