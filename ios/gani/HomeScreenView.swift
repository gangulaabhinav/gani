//
//  HomeScreenView.swift
//  gani
//
//  Created by Abhinav Gangula on 10/25/26.
//

import SwiftUI

struct HomeScreenView: View {
    @AppStorage(AppStorageKey.selectedLocation.rawValue) private var selectedLocation = Location.None
    let sampleItem = ItemDetails(
        name: "Festival Ganesh idol",
        price: 1499,
        images: ["GaneshIdolFront"]
    )

    var body: some View {
        VStack(alignment: .leading) {
            LocationPickerView(selectedLocation: $selectedLocation)
                .padding(.bottom)
            Text("Discover festival idols from your community.")
                .foregroundStyle(.secondary)
            ItemView(item: sampleItem)
            Button("Buy") {
                
            }
                .buttonStyle(PrimaryButtonStyle())
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeScreenView()
}
