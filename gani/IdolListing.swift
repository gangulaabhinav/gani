import Foundation

struct IdolListing {
    let name: String
    let price: Decimal
    let imageName: String

    var formattedPrice: String {
        price.formatted(.currency(code: "INR").locale(Locale(identifier: "en_IN")))
    }

    static let sample = IdolListing(
        name: "Festival Ganesh idol",
        price: 1499,
        imageName: "FestivalIdol"
    )
}
