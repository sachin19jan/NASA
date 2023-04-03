//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class URLComponentsProviderImplTest: XCTestCase {
    private var sut: URLComponentsProviderImpl!
    
    override func setUp() {
        sut = URLComponentsProviderImpl()
    }
    
    func testValidProvide() {
        XCTAssertNoThrow(sut.get())
    }
}
