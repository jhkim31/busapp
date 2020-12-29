//
//  StationAndRouteDetailView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct StationAndRouteDetailView: View {
	var stationAndRoute: StationAndRouteInfo
    var body: some View {
		VStack{
			Text(stationAndRoute.routeId)
			Text(stationAndRoute.stationId)
		}
        
    }
}

struct StationAndRouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StationAndRouteDetailView(stationAndRoute: stationAndRouteLists[0])
    }
}
