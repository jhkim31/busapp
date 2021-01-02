//
//  RouteListView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct RouteListView: View {
    var body: some View {
		VStack{
			NavigationLink(destination:RouteDetailView(routeId: "234000042")){
				Text("2-1")
			}
		}
    }
}

struct RouteListView_Previews: PreviewProvider {
    static var previews: some View {
        RouteListView()
    }
}
