import Foundation
import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instace: AnyObject,
                             file: StaticString = #filePath,
                             line: UInt = #line) {
        addTeardownBlock { [weak instace] in
            XCTAssertNil(instace, "Instance should have been deallocated. Potential memory leak.",
                         file: file,
                         line: line)
        }
    }
}
