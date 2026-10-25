//
//  PrimaryButtonStyle.swift
//  gani
//
//  Created by Abhinav Gangula on 10/25/26.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    Button("Primary Button") {
        
    }
        .buttonStyle(PrimaryButtonStyle())
}
