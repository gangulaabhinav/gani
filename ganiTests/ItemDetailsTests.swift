import XCTest
@testable import gani

final class ItemDetailsTests: XCTestCase {
    private let item = ItemDetails(
        name: "Festival Ganesh idol",
        price: 1499,
        imageName: "FestivalIdol"
    )

    func testItemStoresDetails() {
        XCTAssertEqual(item.name, "Festival Ganesh idol")
        XCTAssertEqual(item.price, Decimal(1499))
        XCTAssertEqual(item.imageName, "FestivalIdol")
    }

    func testPriceUsesIndianRupees() {
        XCTAssertEqual(item.formattedPrice, "₹1,499.00")
    }
}
