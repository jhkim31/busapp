//
//  StationDetailSheet.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/01.
//

import SwiftUI

struct StationDetailSheet: View {
	var item:MyAnnotation
    var body: some View {
		NavigationLink(destination: RouteDetailView(routeInfo: routeLists[0]) ){
			Text(item.stationName)
		}
        
    }
}

//struct StationDetailSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        StationDetailSheet(item: MyAnnotation())
//    }
//}
