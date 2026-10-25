//
//  ItemView.swift
//  gani
//
//  Created by Abhinav Gangula on 10/25/26.
//

import SwiftUI

struct ItemView: View {
    let sampleItem = ItemDetails(
        name: "Festival Ganesh idol",
        price: 1499,
        imageName: "FestivalIdol"
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Discover festival idols from your community.")
                .foregroundStyle(.secondary)
            Image(sampleItem.imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .accessibilityLabel("Illustration of a Ganesh idol on a festival pedestal")
                .accessibilityIdentifier("listingImage")
            Text(sampleItem.name)
                .font(.title2.bold())
            Text(sampleItem.formattedPrice)
                .font(.title3)
        }
        .padding()
        .frame(maxWidth: 600)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ItemView()
}
