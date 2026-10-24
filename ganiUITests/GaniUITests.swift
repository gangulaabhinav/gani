import XCTest

final class GaniUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchShowsListing() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["gani"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.images["listingImage"].exists)
        XCTAssertTrue(app.staticTexts["Festival Ganesh idol"].exists)
        XCTAssertTrue(app.buttons["buyButton"].exists)
    }

    @MainActor
    func testBuyShowsDemoNoticeAndCanBeDismissed() {
        let app = XCUIApplication()
        app.launch()

        let buyButton = app.buttons["buyButton"]
        XCTAssertTrue(buyButton.waitForExistence(timeout: 10))
        if !buyButton.isHittable {
            app.swipeUp()
        }
        buyButton.tap()

        let notice = app.alerts["Thanks for your interest!"]
        XCTAssertTrue(notice.waitForExistence(timeout: 5))
        XCTAssertTrue(notice.staticTexts[
            "This is a sample app. No order has been placed and no payment has been taken."
        ].exists)
        notice.buttons["OK"].tap()
        XCTAssertFalse(notice.exists)
        XCTAssertTrue(buyButton.isHittable)
    }
}
