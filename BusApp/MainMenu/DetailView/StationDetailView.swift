//
//  StationDetailView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct StationDetailView: View {
	var stationInfo: StationInfo
    var body: some View {
		Text(stationInfo.stationId)
    }
}

struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
		StationDetailView(stationInfo: stationLists[0])
    }
}
