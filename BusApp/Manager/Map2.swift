//
//  Map2.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/29.
//

import SwiftUI
import MapKit
improt Combine

struct Map2: View {
	@ObservedObject private var locationManager = LocationManager2()
	@State private var region = MKCoor
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Map2_Previews: PreviewProvider {
    static var previews: some View {
        Map2()
    }
}
