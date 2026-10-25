import XCTest

final class GaniUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchShowsListing() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.images["listingImage"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts["Discover festival idols from your community."].exists)
        XCTAssertTrue(app.staticTexts["Festival Ganesh idol"].exists)
        XCTAssertTrue(app.staticTexts["₹1,499.00"].exists)
        XCTAssertTrue(app.buttons["Buy"].isHittable)
    }

    @MainActor
    func testPlaceholderBuyLeavesListingVisible() {
        let app = XCUIApplication()
        app.launch()

        let buyButton = app.buttons["Buy"]
        XCTAssertTrue(buyButton.waitForExistence(timeout: 10))
        XCTAssertTrue(buyButton.isHittable)
        buyButton.tap()

        XCTAssertEqual(app.alerts.count, 0)
        XCTAssertTrue(app.images["listingImage"].exists)
        XCTAssertTrue(app.staticTexts["Festival Ganesh idol"].exists)
        XCTAssertTrue(buyButton.isHittable)
    }
}
