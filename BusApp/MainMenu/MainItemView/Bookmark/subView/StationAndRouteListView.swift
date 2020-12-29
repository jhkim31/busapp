//
//  StationAndRouteListView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct StationAndRouteListView: View {
	var body: some View {
		VStack{
			ForEach(stationAndRouteLists) { stationAndRoute in
				NavigationLink(destination: StationAndRouteDetailView(stationAndRoute: stationAndRoute)){
					HStack{
						VStack(alignment: .leading){
							Text(stationAndRoute.stationName)
								.foregroundColor(.black)
							Text(stationAndRoute.routeName)
						}
						Spacer()
					}
					.padding(.bottom, 4)
				}
			}
		}
	}
}

struct StationAndRouteListView_Previews: PreviewProvider {
	static var previews: some View {
		StationAndRouteListView()
	}
}
