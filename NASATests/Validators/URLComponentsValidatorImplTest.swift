//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class URLComponentsValidatorImplTest: XCTestCase {
    private var sut: URLComponentsValidatorImpl!
    
    override func setUp() {
        sut = URLComponentsValidatorImpl()
    }
    
    func testValidURLComponents() {
        let valid = URLComponents(string: "http://abc.pl")
        let result = sut.validate(valid)
        XCTAssertNoThrow(result)
    }
}
