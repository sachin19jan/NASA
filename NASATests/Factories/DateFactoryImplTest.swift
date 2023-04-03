//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class DateFactoryImplTest: XCTestCase {
    private var sut: DateFactoryImpl!
    
    override func setUp() {
        sut = DateFactoryImpl()
    }
    
    func testCreateDate() {
        XCTAssertNoThrow(sut.create(year: 2019, month: 05, day: 05))
    }
}
