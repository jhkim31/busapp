//
//  MainRowView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct MainRowView: View {
	var mainText: String
	var iconName:String
	var geometry_parent_width:CGFloat		//parent의 width * 0.75
    var body: some View {
		ZStack{
			Rectangle()
			HStack{
				Text(mainText)
					.fontWeight(.bold)
				Spacer()
				Image(systemName: iconName)
			}
			.padding(.horizontal, 50)
			.foregroundColor(.white)
		}
		.frame(width: geometry_parent_width, height: 70)
		.cornerRadius(10)
		.foregroundColor(Color(red: 136/255, green: 2/255, blue: 224/255))
		.padding(5)
		.shadow(radius:6)
		.font(.title)
    }
}

struct MainRowView_Previews: PreviewProvider {
    static var previews: some View {
        MainRowView(mainText: "즐겨찾기", iconName: "star", geometry_parent_width:200)
    }
}
