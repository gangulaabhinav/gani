import SwiftUI

struct ContentView: View {
    private let listing = IdolListing.sample
    @State private var showingPurchaseNotice = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Celebrate locally")
                        .font(.title.bold())
                    Text("Discover festival idols from your community.")
                        .foregroundStyle(.secondary)

                    Image(listing.imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .accessibilityLabel("Illustration of a Ganesh idol on a festival pedestal")
                        .accessibilityIdentifier("listingImage")

                    Text(listing.name)
                        .font(.title2.bold())
                    Text(listing.formattedPrice)
                        .font(.title3)
                    Text("A little inspiration for your next celebration.")
                        .foregroundStyle(.secondary)

                    Button {
                        showingPurchaseNotice = true
                    } label: {
                        Text("Buy")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .accessibilityIdentifier("buyButton")
                }
                .padding()
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("gani")
            .alert("Thanks for your interest!", isPresented: $showingPurchaseNotice) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("This is a sample app. No order has been placed and no payment has been taken.")
            }
        }
    }
}

#Preview {
    ContentView()
}
