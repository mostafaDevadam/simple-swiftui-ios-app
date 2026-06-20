//
//  ProfileView.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    
    @StateObject private var vm = UsersViewModel()
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("profile \(self.id)")
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Profile")
                .font(.title)
            
            
            if let user = vm.user {
                VStack{
                    //
                    VStack(alignment: .leading){
                        Text("Info")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack{
                            Text("Name:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.name)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("phone:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.phone)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("email:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.email)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("website:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.website)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                    
                    //
                    VStack(alignment: .leading){
                        Text("Address")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(user.address.street)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.address.city)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(user.address.suite)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.address.zipcode)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.address.geo.lat + " - " + user.address.geo.lng)
                            .font(.body)
                            .foregroundColor(.secondary)
                       // display Map
                        //SimpleMapView()
                        NavigationLink(destination: SimpleUserMapView(user: user)) {
                            Text("View Location on Map")
                        }

                        /*NavigationLink(destination: UserMapView(addressString: user.address.fullAddressString)) {
                                        HStack {
                                            Image(systemName: "map")
                                            Text("Display Map Card")
                                        }
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                    }
                                    .padding(.horizontal)*/
                       
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                    
                    //
                    //
                    VStack(alignment: .leading){
                        Text("Company")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(user.company.name)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.company.bs)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.company.catchPhrase)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                    
                    Spacer()
                }
            } else {
                ProgressView("Loading User...")
            }
            
            
            
            
        }
        .padding()
        .onAppear{
            vm.fetchUser(id: self.id)
        }
        
        
    }
}




struct SimpleUserMapView: View {
    // 1. Pass the user object straight into the view instance
    let user: User
    
    // 2. Initialize your region state variable
    @State private var region: MKCoordinateRegion
    @State private var pins: [MyCustomPin] = []

    init(user: User) {
        self.user = user
        
        // 3. Extract the coordinates safely using our computed properties
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: user.address.geo.latitudeCoordinate,
            longitude: user.address.geo.longitudeCoordinate
        )
        
        // 4. Assign the state backing coordinates immediately during startup
        _region = State(initialValue: MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0) // Large zoom since some points are in oceans
        ))
        
        _pins = State(initialValue: [MyCustomPin(coordinate: centerCoordinate)])
    }

    var body: some View {
        // 5. Render standard map with an automated structural layout pin marker
        Map(coordinateRegion: $region, annotationItems: pins) { pin in
            MapMarker(coordinate: pin.coordinate, tint: .blue)
        }
        .navigationTitle(user.name)
    }
}

// Minimal placeholder data pinpoint item structure
struct MyCustomPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}



struct SimpleMapView: View {
    // 1. Definiere den Startpunkt (Breitengrad, Längengrad und Zoom-Faktor)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954), // Beispiel: Berlin
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Zoom-Stufe
    )

    var body: some View {
        // 2. Die Map-Komponente an das State-Binding übergeben
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
            .cornerRadius(15)
            .padding()
    }
}


//

struct UserMapView: View {
    let addressString: String
    
    // Steuert den sichtbaren Bereich der Karte (Standard-Koordinaten)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // Speichert den gesetzten Pin auf der Karte
    @State private var mapPins: [MapPin] = []
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Searching for Address...")
            } else {
                // SwiftUI Map-Komponente (verfügbar ab iOS 14)
                Map(coordinateRegion: $region, annotationItems: mapPins) { pin in
                    MapAnnotation(coordinate: pin.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .background(Color.white.clipShape(Circle()))
                        }
                }
                .cornerRadius(15)
                .padding()
            }
        }
        .navigationTitle("User Location")
        .onAppear {
            convertAddressToCoordinates()
        }
    }
    
    // Wandelt den Text-String in echte Koordinaten um
    private func convertAddressToCoordinates() {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            if let coordinate = placemarks?.first?.location?.coordinate {
                DispatchQueue.main.async {
                    // 1. Karte auf die gefundenen Koordinaten ausrichten
                    self.region.center = coordinate
                    
                    // 2. Einen Pin an dieser Stelle platzieren
                    self.mapPins = [MapPin(coordinate: coordinate)]
                    
                    self.isLoading = false
                }
            } else {
                print("Geocoding Fehler: \(error?.localizedDescription ?? "Unbekannt")")
                self.isLoading = false
            }
        }
    }
}

// Hilfs-Struktur für den Karten-Pin
struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}







struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(id: 1)
    }
}
