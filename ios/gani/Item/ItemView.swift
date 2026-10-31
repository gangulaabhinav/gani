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
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(item.images, id: \.self) { imageName in
                        getImageView(imageName: imageName)
                            .containerRelativeFrame(.horizontal)
                            .accessibilityIdentifier(
                                imageName == item.images.first
                                    ? "listingImage"
                                    : "listingImage-\(imageName)"
                            )
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(item.images, id: \.self) { imageName in
                        getImageView(imageName: imageName)
                            .frame(width: 100, height: 100)
                            .accessibilityIdentifier("thumbnailImage-\(imageName)")
                    }
                }
            }
            Text(item.name)
                .font(.title2.bold())
            Text(item.formattedPrice)
                .font(.title3)
        }
    }

    private func getImageView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .accessibilityLabel("Image of an item")
    }
}

#Preview {
    ItemView(item: ItemDetails(
        name: "Festival Ganesh idol",
        price: 1499,
        images: ["GaneshIdolFront", "GaneshIdolLeftAngle", "GaneshIdolRightAngle", "GaneshIdolLeftSide", "GaneshIdolRightSide"]
    )
    )
}
