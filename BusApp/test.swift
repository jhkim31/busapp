//
//  test.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/11.
//

import SwiftUI

struct test: View {
	var a: Bool = true
	var body: some View {
		VStack{
			VStack{
				HStack{
					Text("hi")
						.frame(height:30)
						.padding(.leading, 50)
					Spacer()
				}
				.frame(height:30)
				.overlay(
					ZStack{
						HStack{
							Rectangle()
								.frame(width:2)
								.padding(.leading, 8)
							Image(systemName: "triangle.fill")
								.font(.system(size:6))
								.foregroundColor(.blue)
								.offset(x:12.85)
								.rotationEffect(.degrees(180))
							Spacer()
						}
						Rectangle()
							.padding(.leading, 20)
							.frame(height:1)
							.offset(y:15)
							.foregroundColor(.gray)
					}
					
				)
			}
			VStack{
				HStack{
					
					Text("hello")
						.frame(height:30)
						.padding(.leading, 50)
					Spacer()
				}
				.frame(height:30)
				.overlay(
					ZStack{
						HStack{
							Rectangle()
								.frame(width:2)
								.padding(.leading, 8)
							Image(systemName: "triangle.fill")
								.font(.system(size:6))
								.foregroundColor(.blue)
								.offset(x:12.85)
								.rotationEffect(.degrees(180))
							if ( a ) {
								Image(systemName: "square.fill")
									.foregroundColor(.red)
									.offset(x: -19, y: 18)
							}
							Spacer()
						}
						Rectangle()
							.padding(.leading, 20)
							.frame(height:1)
							.offset(y:15)
							.foregroundColor(.gray)
						
					}
				)
			}
		}
	}
}

struct test_Previews: PreviewProvider {
	static var previews: some View {
		test()
	}
}
