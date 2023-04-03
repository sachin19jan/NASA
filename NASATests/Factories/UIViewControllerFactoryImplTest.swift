//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class UIViewControllerFactoryImplTest: XCTestCase {
    private var sut: UIViewControllerFactoryImpl!
    
    override func setUp() {
        sut = UIViewControllerFactoryImpl()
    }
    
    func testCreateUIViewController() {
        XCTAssertNoThrow(sut.create(name: "PictureOfTheDayFirstPage"))
    }
}
