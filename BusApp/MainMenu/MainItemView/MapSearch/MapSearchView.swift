//
//  MapSearchView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
	@State private var userTackingMode = MapUserTrackingMode.follow
	@State private var region = MKCoordinateRegion()
	@ObservedObject var locationManager = LocationManager()
	var userLatitude: Double { locationManager.lastLocation?.coordinate.latitude ?? 0 }
	var userLongitude: Double { locationManager.lastLocation?.coordinate.longitude ?? 0	}
	@ObservedObject var annotationClass = MakeMapAnnotation()
	@State var beforeSelect:Int = 0;
	
	var body: some View {
		VStack{
//			Text("My coordinate")
//			HStack{
//				Text(String(format: "%.5f", userLatitude))
//				Text(String(format: "%.5f", userLongitude))
//			}
//			Text("center coordinate")
//			HStack{
//				Text(String(format: "%.5f", region.center.latitude))
//				Text(String(format: "%.5f", region.center.longitude))
//			}
			ZStack{
				Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTackingMode, annotationItems: annotationClass.myAnnotation){ item in
					MapAnnotation(coordinate: item.coordinate){
						Button(action: {
							
							let i:Int = annotationClass.myAnnotation.firstIndex(of: item) ?? 999
							if i < annotationClass.myAnnotation.count {
								annotationClass.myAnnotation[beforeSelect].showStationName = false
								annotationClass.myAnnotation[i].showStationName.toggle()
								beforeSelect = i
							}
							withAnimation {
								setRegion(item.coordinate, zoom: 0.0025, removeAll: false)
							}
						}) {
							VStack{
								Text(item.showStationName ? item.stationName : "")
									.fontWeight(.bold)
									.frame(width: 200)
									.foregroundColor(.black)
								Image(systemName: "circle.fill")
									.font(.system(size: 20))
									.foregroundColor(.blue)
							}
						}
					}
				}
				.onAppear {
					setRegion(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude), zoom: 0.007, removeAll : true)
				}
				.ignoresSafeArea(edges: .bottom)
				
				
				HStack {
					Spacer()
					VStack{
						Button(action: {
							withAnimation{
								setRegion(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude), zoom: 0.005, removeAll: true)
							}
						}){
							Image(systemName: "scope")
								.font(.system(size: 25))
								.padding(5)
						}
						Spacer()
					}
				}
				VStack{
					Spacer()
					Button(action: {
						reloadAnnotation()
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
	private func setRegion(_ coordinate: CLLocationCoordinate2D, zoom: Double, removeAll: Bool) {
		print(zoom)
		if removeAll { annotationClass.myAnnotation.removeAll() }
		region = MKCoordinateRegion(
			center: coordinate,
			span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
		)
	}
	private func reloadAnnotation() {
		annotationClass.myAnnotation.removeAll()
		print(region.center.latitude)
		print(region.center.longitude)
		annotationClass.addAnnotation(latitude: String(region.center.latitude), longitude: String(region.center.longitude))
	}
	
	
	
}

struct MapSearchView_Previews: PreviewProvider {
	static var previews: some View {
		MapSearchView()
	}
}
