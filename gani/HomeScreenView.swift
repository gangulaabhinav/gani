//
//  HomeScreenView.swift
//  gani
//
//  Created by Abhinav Gangula on 10/25/26.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack {
            ItemView()
            Button("Buy") {
                
            }
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

#Preview {
    HomeScreenView()
}
