//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class URLFactoryImplTest: XCTestCase {
    private var sut: URLFactoryImpl!
    
    override func setUp() {
        sut = URLFactoryImpl()
    }
    
    func testCreateRequestUrlItems() {
        XCTAssertNoThrow(sut.createRequest(date: Date()))
    }
    
    func testCreateRequestLink() {
        let link = "http://abc.pl"
        XCTAssertNoThrow(sut.createRequest(link: link))
    }
}
