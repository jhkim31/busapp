//
//  aa.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//
//
/**리스트 안쓰는 이유
1. 리스트 사용하고, 리스트 위에 Objcet 추가시, 리스트 선택 후 다시 돌아오면
리스트가 계속 선택되어있는 현상 있음, 버그인지 아닌지..

2. 리스트 사용시 개별선택하기 힘듬
*/


import SwiftUI

struct aa: View {
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
			Spacer()
		}
		.navigationBarTitle("즐겨찾기", displayMode: .inline)
	}
}

struct aa_Previews: PreviewProvider {
	static var previews: some View {
		aa()
	}
}
