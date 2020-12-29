//
//  MainGeometryReaderView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/26.
//

import SwiftUI

struct MainViewLayout: View {
	var body: some View {
		GeometryReader{ geometry in
			HStack{
				Spacer()
				VStack{
					Spacer()
					NavigationLink(destination: BookmarkView()) {
						MainRowView(mainText: "즐겨찾기", iconName: "star", geometry_parent_width:geometry.size.width * 0.75)
					}
					NavigationLink(destination: MapSearchView()){
						MainRowView(mainText: "지도에서 검색", iconName: "map", geometry_parent_width:geometry.size.width * 0.75)
					}
					NavigationLink(destination: KeywordSearchView()){
						MainRowView(mainText: "키워드 검색", iconName: "magnifyingglass", geometry_parent_width:geometry.size.width * 0.75)
					}
					Spacer()
						.frame(height:geometry.size.height * 0.4)
				}
				Spacer()
			}
		}
	}
}

struct MainViewLayout_Previews: PreviewProvider {
	static var previews: some View {
		MainViewLayout()
	}
}
