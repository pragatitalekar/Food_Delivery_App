import SwiftUI

struct NoInternetView: View {

    var onRetry: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "wifi.slash")
                .font(.system(size: 64, weight: .light))
                .foregroundColor(.secondary)

            Text("No internet Connection")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("Your internet connection is currently\nnot available please check or try again.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()

            Button {
                onRetry?()
            } label: {
                Text("Try again")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryOrange)
                    .foregroundColor(.white)
                    .cornerRadius(28)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {

    NoInternetView {
        print("Retry tapped")
    }


}

#Preview {

    NoInternetView()
        .preferredColorScheme(.dark)

}

