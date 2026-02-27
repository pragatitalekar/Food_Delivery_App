import SwiftUI
import Combine

struct SplashView: View {

    var onGetStarted: () -> Void   // callback

    var body: some View {

        ZStack {

            AppColors.primary
                .ignoresSafeArea()

            VStack {

                Spacer()

                VStack(alignment: .leading, spacing: 20) {

                    ZStack {
                        Circle()
                            .fill(AppColors.white)
                            .frame(width: 64, height: 64)

                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }

                    Text("Food for\nEveryone")
                        .font(.system(size: 65, weight: .heavy, design: .rounded))
                        .kerning(-2)
                        .foregroundColor(AppColors.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)

                Spacer()

                ZStack {
                    Image("characterback")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 260)
                        .rotationEffect(.degrees(8.57))
                        .offset(x: 100, y: 40)

                    Image("characterfront")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 340)
                        .rotationEffect(.degrees(-3.1))
                        .offset(x: -82)

                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.clear, location: 0.0),
                            .init(color: AppColors.primary.opacity(0.4), location: 0.35),
                            .init(color: AppColors.primary, location: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 420)
                    .offset(y: 70)
                }

                Spacer()

                Button {
                    onGetStarted()   // ✅ notify root
                } label: {
                    Text("Get started")
                        .foregroundColor(AppColors.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.white.opacity(0.95))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 40)

                Spacer()
            }
        }
    }
}
