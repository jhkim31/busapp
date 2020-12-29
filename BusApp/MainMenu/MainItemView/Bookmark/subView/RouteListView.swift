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
			ForEach(routeLists) { route in
				NavigationLink(destination: RouteDetailView(routeInfo: route)){
					HStack{
						Text(route.routeName)
							.foregroundColor(.black)
							.padding(5)
						Spacer()
					}
				}
			}
		}
    }
}

struct RouteListView_Previews: PreviewProvider {
    static var previews: some View {
        RouteListView()
    }
}
