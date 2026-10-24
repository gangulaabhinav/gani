import XCTest
@testable import gani

final class IdolListingTests: XCTestCase {
    func testSampleListing() {
        let listing = IdolListing.sample

        XCTAssertEqual(listing.name, "Festival Ganesh idol")
        XCTAssertEqual(listing.price, Decimal(1499))
        XCTAssertEqual(listing.imageName, "FestivalIdol")
    }

    func testPriceUsesIndianRupees() {
        XCTAssertEqual(IdolListing.sample.formattedPrice, "₹1,499.00")
    }
}
