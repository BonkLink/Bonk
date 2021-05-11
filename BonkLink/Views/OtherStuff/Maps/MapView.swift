//
//  MapView.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/28/21.
//

import SwiftUI
import RealmSwift
import MapKit

struct MapView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let location: CLLocationCoordinate2D
    let annotationItems: [MyAnnotationItem]
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude),
        span: MKCoordinateSpan(latitudeDelta: MapDefaults.zoomedOut, longitudeDelta: MapDefaults.zoomedOut))
    
    private enum MapDefaults {
        static let latitude = 51.507222
        static let longitude = -0.1275
        static let zoomedOut = 2.0
        static let zoomedIn = 0.01
    }
    
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: true,
            annotationItems: annotationItems) { item in
            MapPin(coordinate: item.coordinate)
        }
        .animation(.easeIn)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            BackButton(label: "Dismiss").foregroundColor(.black)
        })
        .onAppear(perform: setupLocation)
    }
    
    func setupLocation() {
        region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: MapDefaults.zoomedIn, longitudeDelta: MapDefaults.zoomedIn))
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
