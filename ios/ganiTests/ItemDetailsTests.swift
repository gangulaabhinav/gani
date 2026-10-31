import XCTest
@testable import gani

final class ItemDetailsTests: XCTestCase {
    private let item = ItemDetails(
        name: "Festival Ganesh idol",
        price: 1499,
        images: [
            "GaneshIdolFront",
            "GaneshIdolLeftAngle",
            "GaneshIdolRightAngle",
            "GaneshIdolLeftSide",
            "GaneshIdolRightSide"
        ]
    )

    func testItemStoresDetails() {
        XCTAssertEqual(item.name, "Festival Ganesh idol")
        XCTAssertEqual(item.price, Decimal(1499))
        XCTAssertEqual(item.images, [
            "GaneshIdolFront",
            "GaneshIdolLeftAngle",
            "GaneshIdolRightAngle",
            "GaneshIdolLeftSide",
            "GaneshIdolRightSide"
        ])
    }

    func testPriceUsesIndianRupees() {
        XCTAssertEqual(item.formattedPrice, "₹1,499.00")
    }
}
