//
//  StatioinListView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct StationListView: View {
	
	var body: some View {
		VStack{
			ForEach(stationLists) { station in
				NavigationLink(destination: StationDetailView(stationInfo: station)){
					HStack{
						Text(station.stationName)
							.foregroundColor(.black)
							.padding(5)
						Spacer()
					}
				}
			}
		}
	}
}

struct StationListView_Previews: PreviewProvider {
	static var previews: some View {
		StationListView()
	}
}
