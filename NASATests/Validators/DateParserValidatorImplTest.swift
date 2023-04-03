//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class DateParserValidatorImplTest: XCTestCase {
    private var sut: DateParserValidatorImpl!
    
    override func setUp() {
        sut = DateParserValidatorImpl()
    }
    
    func testValidDateInString() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let dateInString = formatter.string(from: date)
        XCTAssertNoThrow(sut.validate(dateInString))
    }
}
