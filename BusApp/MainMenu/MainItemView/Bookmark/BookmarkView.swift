//
//  BookmarkView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//

import SwiftUI

struct BookmarkView: View {
	@State var showStationAndRoute: Bool = true
	@State var showStation: Bool = true
	@State var showRoute: Bool = true
	
	
	let stationAndRoute: BookmarkType = .stationAndRoute
	let station: BookmarkType = .statioin
	let route: BookmarkType = .route
	
	var body: some View {
		VStack{
			HStack{
				ShowTypeButton(toggle: $showStationAndRoute, bookmarkType: stationAndRoute.rawValue)
				Spacer()
				ShowTypeButton(toggle: $showStation, bookmarkType: station.rawValue)
				Spacer()
				ShowTypeButton(toggle: $showRoute, bookmarkType: route.rawValue)
			}
			.padding(.horizontal, 20)
			.padding(.top, 10)
			.padding(.bottom, 10)
			
			HStack{
				Text(stationAndRoute.rawValue)
				Spacer()
			}
			.padding(5)
			.background(Color(red: 201/255, green: 201/255, blue: 201/255))
			if (showStationAndRoute) {
				StationAndRouteListView()
			}
			
			HStack{
				Text(station.rawValue)
				Spacer()
			}
			.padding(5)
			.background(Color(red: 201/255, green: 201/255, blue: 201/255))
			
			if (showStation){
				StationListView()
			}
			
			HStack{
				Text(route.rawValue)
				Spacer()
			}
			.padding(5)
			.background(Color(red: 201/255, green: 201/255, blue: 201/255))
			
			if (showRoute){
				RouteListView()
			}
			
			Spacer()
		}
		.navigationBarTitle("즐겨찾기", displayMode: .inline)
	}
}

struct BookmarkView_Previews: PreviewProvider {
	static var previews: some View {
		BookmarkView()
	}
}
