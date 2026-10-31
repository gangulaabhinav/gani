import Foundation
import SwiftUI

struct ItemDetails {
    let name: String
    let price: Decimal
    let images: [String]
//    let imageName: String

    var formattedPrice: String {
        price.formatted(.currency(code: "INR").locale(Locale(identifier: "en_IN")))
    }
}
