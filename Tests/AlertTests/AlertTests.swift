import XCTest
@testable import Alert

final class AlertTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Alert().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
