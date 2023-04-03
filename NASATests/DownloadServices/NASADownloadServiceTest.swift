//
//  Created by Sachin, Bhardwaj
//

import XCTest
@testable import NASA

internal class NASADownloadServiceTest: XCTestCase {
    private var sut: NASADownloadService!
    
    override func setUp() {
        sut = NASADownloadService()
    }
    
    func testRunDownload() {
        XCTAssertNoThrow(sut.runDownload(date: Date().addingTimeInterval(-1 * 60 * 60 * 24), completion: { data in }))
    }
}
