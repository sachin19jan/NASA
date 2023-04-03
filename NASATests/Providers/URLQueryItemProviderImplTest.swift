//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class URLQueryItemProviderImplTest: XCTestCase {
    private var sut: URLQueryItemProviderImpl!
    
    override func setUp() {
        sut = URLQueryItemProviderImpl()
    }
    
    func testGetAuthenticationItem() {
        XCTAssertNoThrow(sut.getAuthenticationItem())
    }
    
    func testProperQueryItems() {
        XCTAssertNoThrow(sut.get(date: Date()))
    }
}
