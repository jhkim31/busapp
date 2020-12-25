//
//  MainGeometryReaderView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/26.
//

import SwiftUI

struct MainGeometryReaderView: View {
	var body: some View {
		GeometryReader{ geometry in
			HStack{
				Spacer()
				VStack{
					Spacer()
					
					//---------------------------------------------------------------------------------
					NavigationLink(destination: BookmarkView()){
						ZStack{
							Rectangle()
							HStack{
								Text("즐겨찾기")
									.fontWeight(.bold)
								Spacer()
								Image(systemName: "star")
							}
							.padding(.horizontal, 50)
							.foregroundColor(.white)
						}
					}
					.frame(width: geometry.size.width * 0.75, height: 70)
					.cornerRadius(10)
					.foregroundColor(Color(red: 136/255, green: 2/255, blue: 224/255))
					.padding(5)
					.shadow(radius:6)
					//---------------------------------------------------------------------------------
					
					//---------------------------------------------------------------------------------
					NavigationLink(destination: MapSearchView()){
						ZStack{
							Rectangle()
							HStack{
								Text("지도에서 검색")
									.fontWeight(.bold)
								Spacer()
								Image(systemName: "map")
							}
							.padding(.horizontal, 50)
							.foregroundColor(.white)
						}
					}
					.frame(width: geometry.size.width * 0.75, height: 70)
					.cornerRadius(10)
					.foregroundColor(Color(red: 136/255, green: 2/255, blue: 224/255))
					.padding(5)
					.shadow(radius:6)
					//---------------------------------------------------------------------------------
					
					//---------------------------------------------------------------------------------
					NavigationLink(destination: KeywordSearchView()){
						ZStack{
							Rectangle()
							HStack{
								Text("키워드 검색")
									.fontWeight(.bold)
								Spacer()
								Image(systemName: "magnifyingglass")
							}
							.padding(.horizontal, 50)
							.foregroundColor(.white)
							
						}
					}
					.frame(width: geometry.size.width * 0.75, height: 70)
					.cornerRadius(10)
					.foregroundColor(Color(red: 136/255, green: 2/255, blue: 224/255))
					.padding(5)
					.shadow(radius:6)
					//---------------------------------------------------------------------------------
					
					Spacer()
				}
				.font(.title)
				
				
				Spacer()
			}
		}
	}
}

struct MainGeometryReaderView_Previews: PreviewProvider {
	static var previews: some View {
		MainGeometryReaderView()
	}
}
