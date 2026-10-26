import XCTest

final class GaniUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testFreshInstallationShowsNoSelectedLocation() {
        let app = XCUIApplication()
        app.launch()

        let locationButton = locationPickerButton(in: app)
        XCTAssertEqual(locationButton.label, "None")
        XCTAssertTrue(locationButton.isHittable)
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

        let restoredLocationButton = locationPickerButton(in: app)
        XCTAssertEqual(restoredLocationButton.label, "Hyderabad")
        XCTAssertTrue(restoredLocationButton.isHittable)
        XCTAssertFalse(app.buttons["None"].exists)

        selectLocation("None", in: app)

        app.terminate()
        app.launch()

        XCTAssertEqual(locationPickerButton(in: app).label, "None")
        XCTAssertFalse(app.buttons["Hyderabad"].exists)
    }

    @MainActor
    private func selectLocation(_ location: String, in app: XCUIApplication) {
        let locationButton = locationPickerButton(in: app)
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

    @MainActor
    private func locationPickerButton(in app: XCUIApplication) -> XCUIElement {
        let buttons = app.buttons.matching(
            identifier: AccessibilityIdentifier.locationPickerButton.rawValue
        )
        XCTAssertTrue(buttons.firstMatch.waitForExistence(timeout: 10))
        XCTAssertEqual(buttons.count, 1)
        return buttons.element
    }
}
