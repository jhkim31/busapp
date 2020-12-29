//
//  MapSearchView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
	@State private var userTackingMode: MapUserTrackingMode = .follow
	@State private var region = MKCoordinateRegion()
	@ObservedObject var locationManager = LocationManager()

	var userLatitude: Double { locationManager.lastLocation?.coordinate.latitude ?? 0 }
	var userLongitude: Double { locationManager.lastLocation?.coordinate.longitude ?? 0	}
	
	var userLatitudeToString: String { String(format: "%.5f", userLatitude) }
	var userLongitudeToString: String { String(format: "%.5f", userLongitude) }
	
	
	var body: some View {
		VStack{
			Text("My coordinate")
			HStack{
				Text(userLatitudeToString)
				Text(userLongitudeToString)
			}
			Text("center coordinate")
			HStack{
				Text(String(format: "%.5f", region.center.latitude))
				Text(String(format: "%.5f", region.center.longitude))
			}
			ZStack{
				Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTackingMode)
					.onAppear {
						setUserRegion(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude))
					}
					.ignoresSafeArea(edges: .bottom)
					
				
				HStack {
					Spacer()
					VStack{
						Button(action: {
							withAnimation{
								setUserRegion(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude))
							}
						}){
							Image(systemName: "scope")
//								.foregroundColor(userLatitudeToString == String(format: "%.5f", region.center.latitude) ? Color.blue : Color.gray)
								.font(.system(size: 25))
								.padding(5)
						}
						Spacer()
					}
				}
				VStack{
					Spacer()
					Button(action: {
						
					}) {
						Text("현재 위치에서 검색")
							.padding(6)
							.background(Color(red: 20/255, green: 20/255, blue: 20/255, opacity: 0.1))
							.cornerRadius(20)
							.foregroundColor(Color(red: 20/255, green: 20/255, blue: 20/255, opacity: 0.6))
							
					}
					.padding(.bottom, 20)
				}
			}
		}
		.navigationBarTitle("지도에서 찾기", displayMode: .inline)
	}
	private func setUserRegion(_ coordinate: CLLocationCoordinate2D) {
		region = MKCoordinateRegion(
			center: coordinate,
			span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
		)
	}
}

struct MapSearchView_Previews: PreviewProvider {
	static var previews: some View {
		MapSearchView()
	}
}
