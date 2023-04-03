//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class URLValidatorImplTest: XCTestCase {
    private var sut: URLValidatorImpl!
    
    override func setUp() {
        sut = URLValidatorImpl()
    }
    
    func testValidURL() {
        let url = URL(string: "http://abc.pl")
        XCTAssertNoThrow(sut.validate(url))
    }
}
