import XCTest
@testable import SimpleConstraints

final class SimpleConstraintsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SimpleConstraints().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
