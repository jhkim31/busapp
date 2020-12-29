//
//  ViewA.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct ViewA: View {
	var body: some View {
		NavigationView{
			VStack{
				Text("hi")
				List {
					NavigationLink(destination: ViewB()){
						Text("hi")
					}
					NavigationLink(destination: ViewB()){
						Text("hi")
					}
					NavigationLink(destination: ViewB()){
						Text("hi")
					}
				}
			}
			.toolbar {
				
			}
		}
	}
}

struct ViewA_Previews: PreviewProvider {
	static var previews: some View {
		ViewA()
	}
}
