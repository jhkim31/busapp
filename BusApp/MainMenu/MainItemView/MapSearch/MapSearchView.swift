//
//  MapSearchView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//
import SwiftUI
import MapKit

struct MapSearchView: View {
	@State private var userTackingMode = MapUserTrackingMode.follow				//지도의 트레킹 모드
	@State private var region = MKCoordinateRegion()							//지도의 위도 경도 줌 정도
	@ObservedObject var locationManager = LocationManager()						//사용자의 현재 위치 위한 클래스
	@ObservedObject var annotationClass = GetAnnotationData()					//어노테이션을 관리하는 클래스
	var getStationInfo_popup = GetStationInfo()
	@State var selectedStationId: String = ""
	@State var selectedMobileNo: String = ""
	@State private var popupToggle:Bool = false											//시트 토글 변수
	var userLatitude: Double { locationManager.lastLocation?.coordinate.latitude ?? 0 }		//유저의 현재 위도
	var userLongitude: Double { locationManager.lastLocation?.coordinate.longitude ?? 0	}	//유저의 현재 경도
	
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
							popupToggle = true
							selectedMobileNo = item.mobileNo
							selectedStationId = item.stationId
							withAnimation {
								setRegion(item.coordinate, zoom: 0.0025 > region.span.latitudeDelta ? region.span.latitudeDelta : 0.0025)
							}
						}) {
							Image(systemName: "largecircle.fill.circle")
								.font(.system(size: 25))
								.foregroundColor(item.districtCd == "2" ? Color(red: 136/255, green: 2/255, blue: 224/255) : Color.red)
						}
					}
				}
				.onAppear {
					if popupToggle {
						setRegion(CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude), zoom: 0.007)
					} else {
						setRegion(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude), zoom: 0.007)
					}
				}
				.ignoresSafeArea(edges: .bottom)
				//	-------------------------------------------------------------------Map View
				HStack {				//현재 위치로 이동 Button
					Spacer()
					VStack{
						Button(action: {
							withAnimation{
								setRegion(CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude), zoom: 0.005)
							}
						}){
							Image(systemName: "scope")
								.font(.system(size: 25))
								.padding(8)
						}
						Spacer()
					}
				}
				VStack{				//현재 위치에서 검색 Button
					Spacer()
					Button(action: {
						reloadAnnotation()
						withAnimation {
							setRegion(CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude), zoom: 0.015)
						}
					}) {
						Text("현재 위치에서 검색")
							.padding(6)
							.background(Color(red: 20/255, green: 20/255, blue: 20/255, opacity: 0.1))
							.cornerRadius(20)
							.foregroundColor(Color(red: 20/255, green: 20/255, blue: 20/255, opacity: 0.6))
					}
					.padding(.bottom, 20)
				}
				if ($popupToggle.wrappedValue){
					StationInfoPopupView(
						getStationInfo_popup: getStationInfo_popup,
						stationId: selectedStationId,
						mobileNo: selectedMobileNo,
						popup: $popupToggle)
					//					StationDetailView(mobileNo: selectedMobileNo, stationId: selectedStationId)
				}
			}
		}
		.navigationBarTitle("지도에서 찾기", displayMode: .inline)
	}
	
	
	
	
	private func setRegion(_ coordinate: CLLocationCoordinate2D, zoom: Double) {
		print(zoom)
		region = MKCoordinateRegion(
			center: coordinate,
			span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
		)
	}
	private func reloadAnnotation() {
		annotationClass.myAnnotation.removeAll()
		print(region.center.latitude)
		print(region.center.longitude)
		annotationClass.getDataFromServer(latitude: String(region.center.latitude), longitude: String(region.center.longitude))
	}
}

struct MapSearchView_Previews: PreviewProvider {
	static var previews: some View {
		MapSearchView()
	}
}
