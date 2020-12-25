//
//  MainView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/25.
//

import SwiftUI

struct MainView: View {
	@State private var showConfig = false
	var body: some View {
		NavigationView{
			MainGeometryReaderView()
			.toolbar{
				Button(action: {showConfig.toggle()}) {
					Image(systemName: "gearshape")
				}
			}
			.sheet(isPresented: $showConfig){
				Config()
			}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}

