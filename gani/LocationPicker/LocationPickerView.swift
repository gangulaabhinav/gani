//
//  LocationPickerView.swift
//  gani
//
//  Created by Abhinav Gangula on 10/26/26.
//

import SwiftUI
import MapKit

struct LocationPickerView: View {
    @State var isPresented = false
    @Binding var selectedLocation: Location
    
    var body: some View {
        HStack {
            Text("Location:")
            Button(selectedLocation.rawValue) {
                isPresented = true
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack {
                ForEach(Location.allCases, id: \.self) { location in
                    Button(location.rawValue) {
                        selectedLocation = location
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    LocationPickerView(selectedLocation: .constant(.Hyderabad))
}
