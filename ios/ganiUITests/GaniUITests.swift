import XCTest

final class GaniUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testFreshInstallationShowsNoSelectedLocation() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.buttons["None"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["None"].isHittable)
        XCTAssertFalse(app.buttons["Hyderabad"].exists)
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

    @MainActor
    func testSelectedLocationPersistsAfterRelaunchAndCanBeCleared() {
        let app = XCUIApplication()
        app.launch()

        selectLocation("None", in: app)
        selectLocation("Hyderabad", in: app)

        app.terminate()
        app.launch()

        XCTAssertTrue(app.buttons["Hyderabad"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["Hyderabad"].isHittable)
        XCTAssertFalse(app.buttons["None"].exists)

        selectLocation("None", in: app)

        app.terminate()
        app.launch()

        XCTAssertTrue(app.buttons["None"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.buttons["Hyderabad"].exists)
    }

    @MainActor
    private func selectLocation(_ location: String, in app: XCUIApplication) {
        let locationButton = app.buttons.matching(
            NSPredicate(
                format: "label IN %@",
                ["None", "Hyderabad", "Bengaluru", "Mumbai", "Kolkata", "Chennai"]
            )
        ).firstMatch
        XCTAssertTrue(locationButton.waitForExistence(timeout: 10))
        if locationButton.label == location {
            return
        }

        locationButton.tap()
        let option = app.buttons[location]
        XCTAssertTrue(option.waitForExistence(timeout: 5))
        option.tap()

        let sheetDismissed = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: app.buttons[location == "Mumbai" ? "Chennai" : "Mumbai"]
        )
        wait(for: [sheetDismissed], timeout: 5)
        XCTAssertEqual(locationButton.label, location)
    }
}
