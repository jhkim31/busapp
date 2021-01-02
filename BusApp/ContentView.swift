//
//  ContentView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StationDetailView( mobileNo: "38553", stationId: "234001177")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
