//
//  DeliveryLocation.swift
//  Food_Delivery_App
//
//  Created by rentamac on 3/4/26.
//

import MapKit

struct DeliveryLocation: Identifiable {
let id = UUID()
let coordinate: CLLocationCoordinate2D
let type: LocationType
}

enum LocationType {
case restaurant
case rider
case customer
}
