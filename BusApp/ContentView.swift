//
//  ContentView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StationDetailView(stationId: "234001177", mobileNo: "38553")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
