//
//  RouteDetailView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct RouteDetailView: View {
	var routeInfo: RouteInfo
    var body: some View {
		Text(routeInfo.routeId)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailView(routeInfo: routeLists[0])
    }
}
