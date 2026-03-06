//
//  OrderTrackingView.swift
//

import SwiftUI
import MapKit

struct OrderTrackingView: View {
    
    var order: Order
    private let deliveryDuration: TimeInterval = 600
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orders: OrderManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var progress: Double = 0
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?
    
    @State private var showCancelAlert = false
    @State private var showRefundAlert = false
    
    @StateObject private var foodVM = SimilarFoodViewModel()
    
    // MARK: MAP
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    let restaurant = CLLocationCoordinate2D(latitude: 12.9718, longitude: 77.5930)
    let customer = CLLocationCoordinate2D(latitude: 12.9745, longitude: 77.6010)
    
    @State private var rider = CLLocationCoordinate2D(latitude: 12.9718, longitude: 77.5930)
    
    @State private var route: MKRoute?
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    // MAP
                    
                    MapView(
                        region: $region,
                        rider: rider,
                        restaurant: restaurant,
                        customer: customer,
                        route: route
                    )
                    .frame(height: 260)
                    .cornerRadius(20)
                    
                    
                    // ORDER SUMMARY
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Order Summary")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("\(order.items.count) Item(s)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        ForEach(order.items, id: \.id) { item in
                            
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("₹\(item.price, specifier: "%.0f")")
                            }
                            
                            Divider()
                        }
                        
                        HStack {
                            Text("Total")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("₹\(order.total, specifier: "%.0f")")
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    
                    
                    // STATUS
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Order #\(order.id.prefix(5))")
                            .font(.headline)
                        
                        Text(currentStatus)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.green)
                        
                        ProgressView(value: progress)
                            .tint(.green)
                        
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.orange)
                            
                            Text(timeString)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    
                    
                    // CANCEL
                    
                    if order.status == .preparing {
                        
                        Button {
                            showCancelAlert = true
                        } label: {
                            Text(progress > 0.6 ? "Cannot Cancel (Out for Delivery)" : "Cancel Order")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(progress > 0.6 ? Color.gray : AppColors.primary)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }
                        .disabled(progress > 0.6)
                    }
                    
                    
                    // TRACKING
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        TrackingRow(
                            title: "Order Confirmed",
                            subtitle: "Your order has been placed",
                            isCompleted: progress > 0.1
                        )
                        
                        TrackingRow(
                            title: "Preparing",
                            subtitle: "Restaurant is preparing food",
                            isCompleted: progress > 0.2
                        )
                        
                        TrackingRow(
                            title: "Out for Delivery",
                            subtitle: "Delivery partner picked up",
                            isCompleted: progress > 0.6
                        )
                        
                        TrackingRow(
                            title: "Delivered",
                            subtitle: "Order delivered successfully",
                            isCompleted: progress >= 1.0
                        )
                    }
                    .padding()
                    .background(AppColors.background)
                    .cornerRadius(16)
                    
                    
                    // SIMILAR FOOD
                    
                    Text("You may also like")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    if foodVM.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(foodVM.foods) { food in
                                SimilarFoodCard(food: food)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Track Order")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startTimer()
            calculateRoute()
            startMovement()
            foodVM.fetchSimilarFoods(for: order)
        }
        .onDisappear {
            timer?.invalidate()
        }
        .alert("Cancel Order?", isPresented: $showCancelAlert) {
            
            Button("Yes, Cancel", role: .destructive) {
                orders.cancelOrder(order)
                showRefundAlert = true
            }
            
            Button("No", role: .cancel) { }
            
        }
        .alert("Refund Processed 💸", isPresented: $showRefundAlert) {
            Button("OK") {
                dismiss()
            }
        }
    }
    
    
    // STATUS
    
    var currentStatus: String {
        if progress < 0.3 { return "Restaurant accepted 🍽️" }
        if progress < 0.6 { return "Food is being prepared 👨‍🍳" }
        if progress < 0.9 { return "Out for delivery 🚚" }
        return "Delivered 🎉"
    }
    
    
    func startTimer() {
        updateValues()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateValues()
        }
    }
    
    func updateValues() {
        let elapsed = Date().timeIntervalSince(order.createdAt)
        remainingTime = max(deliveryDuration - elapsed, 0)
        progress = min(elapsed / deliveryDuration, 1.0)
        if progress >= 1 {
        timer?.invalidate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        dismiss()
        }
        }
    }
    
    var timeString: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "Arriving in %02d:%02d", minutes, seconds)
    }
    
    
    func calculateRoute() {
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: restaurant))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: customer))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            
            if let route = response?.routes.first {
                self.route = route
            }
        }
    }
    
    func startMovement() {
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            
            if progress >= 1 {
                timer.invalidate()
            }
            
            guard let polyline = route?.polyline else { return }
            
            let coords = polyline.coordinates()
            
           
            if progress < 0.6 {
                rider = restaurant
                region.center = restaurant
                return
            }
            
            let deliveryProgress = (progress - 0.6) / 0.4
            
            let index = Int(deliveryProgress * Double(coords.count - 1))
            
            if index < coords.count {
                rider = coords[index]
                region.center = rider
            }
        }
    }
}

////////////////////////////////////////////////////////////
/// MAP VIEW
////////////////////////////////////////////////////////////

struct MapView: UIViewRepresentable {
    
    @Binding var region: MKCoordinateRegion
    
    var rider: CLLocationCoordinate2D
    var restaurant: CLLocationCoordinate2D
    var customer: CLLocationCoordinate2D
    
    var route: MKRoute?
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()
        map.delegate = context.coordinator
        
        return map
    }
    
    func updateUIView(_ map: MKMapView, context: Context) {
        
        map.setRegion(region, animated: true)
        
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
        
       
        
        let riderAnnotation = MKPointAnnotation()
        riderAnnotation.coordinate = rider
        riderAnnotation.title = "rider"
        
    
        
        let restaurantAnnotation = MKPointAnnotation()
        restaurantAnnotation.coordinate = restaurant
        restaurantAnnotation.title = "restaurant"
        
        let customerAnnotation = MKPointAnnotation()
        customerAnnotation.coordinate = customer
        customerAnnotation.title = "customer"
        
        map.addAnnotations([riderAnnotation, restaurantAnnotation, customerAnnotation])
        
        if let route = route {
            map.addOverlay(route.polyline)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let identifier = "custom"
            
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            guard let title = annotation.title ?? "" else { return view }
            
            if title == "rider" {
                view?.image = UIImage(systemName: "bicycle")
            }
            
            if title == "restaurant" {
                view?.image = UIImage(systemName: "fork.knife.circle.fill")
            }
            
            if title == "customer" {
                view?.image = UIImage(systemName: "house.circle.fill")
            }
            
            return view
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            if let polyline = overlay as? MKPolyline {
                
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.systemBlue
                renderer.lineWidth = 6
                
                return renderer
            }
            
            return MKOverlayRenderer()
        }
    }
}

////////////////////////////////////////////////////////////
/// POLYLINE HELPER
////////////////////////////////////////////////////////////

extension MKPolyline {
    
    func coordinates() -> [CLLocationCoordinate2D] {
        
        var coords = [CLLocationCoordinate2D](
            repeating: kCLLocationCoordinate2DInvalid,
            count: pointCount
        )
        
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        
        return coords
    }
}

////////////////////////////////////////////////////////////
/// TRACKING ROW
////////////////////////////////////////////////////////////

struct TrackingRow: View {
    
    var title: String
    var subtitle: String
    var isCompleted: Bool
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            VStack {
                Circle()
                    .fill(isCompleted ? Color.green : Color.gray.opacity(0.4))
                    .frame(width: 18, height: 18)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

////////////////////////////////////////////////////////////
/// SIMILAR FOOD CARD
////////////////////////////////////////////////////////////

struct SimilarFoodCard: View {
    
    let food: FoodItems
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            AsyncImage(url: URL(string: food.image)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            
            Text(food.name)
                .font(.headline)
                .lineLimit(2)
            
            Text("₹\(food.price, specifier: "%.0f")")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppColors.primary)
            
            Button {
                cart.add(food)
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(AppColors.primary)
                    .cornerRadius(20)
            }
        }
        .frame(width: 160, height: 220)
        .background(AppColors.background)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}
