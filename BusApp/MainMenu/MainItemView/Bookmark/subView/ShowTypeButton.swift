//
//  ShowTypeButton.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct ShowTypeButton: View {
	@Binding var toggle:Bool
	var bookmarkType: String
    var body: some View {
		HStack{
			Text(bookmarkType)
				.font(.title2)
				.fontWeight(.bold)
			
		}
		.padding(10)
		.foregroundColor(toggle ? .white : Color(red: 136/255, green: 2/255, blue: 224/255))
		.background(toggle ? Color(red: 136/255, green: 2/255, blue: 224/255) : Color.white)
		.cornerRadius(10)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color(red: 136/255, green: 2/255, blue: 224/255), lineWidth:3)
		)
		.onTapGesture {
			withAnimation(.easeInOut(duration: 0)) {
				toggle.toggle()
			}
		}
    }
}

struct ShowTypeButton_Previews: PreviewProvider {
    static var previews: some View {
		ShowTypeButton(toggle: .constant(true), bookmarkType: "정류장")
    }
}
