//
//  ItemView.swift
//  gani
//
//  Created by Abhinav Gangula on 10/25/26.
//

import SwiftUI

struct ItemView: View {
    let item: ItemDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .accessibilityLabel("Illustration of a Ganesh idol on a festival pedestal")
                .accessibilityIdentifier("listingImage")
            Text(item.name)
                .font(.title2.bold())
            Text(item.formattedPrice)
                .font(.title3)
        }
        .padding()
        .frame(maxWidth: 600)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ItemView(item: ItemDetails(
        name: "Festival Ganesh idol",
        price: 1499,
        imageName: "FestivalIdol"
    )
    )
}
