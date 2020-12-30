//
//  ViewB.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct ViewB: View {
	@ObservedObject var a = MakeMapAnnotation()
    var body: some View {
		Button(action: {
			a.getHttpRequest(url: "http://localhost:5000/getNearlyStationList?latitude=37.41992949999999&longitude=127.28047942999996")
		}) {
			Text("hi")
		}
    }
}

struct ViewB_Previews: PreviewProvider {
    static var previews: some View {
        ViewB()
    }
}
