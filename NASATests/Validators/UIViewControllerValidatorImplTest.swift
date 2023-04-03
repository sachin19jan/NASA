//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class UIViewControllerValidatorImplTest: XCTestCase {
    private var sut: UIViewControllerValidatorImpl!
    
    override func setUp() {
        sut = UIViewControllerValidatorImpl()
    }
    
    func testValidUIViewController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PictureOfTheDayFirstPage")
        XCTAssertNoThrow(sut.validate(viewController))
    }
}
