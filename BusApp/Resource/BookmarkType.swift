//
//  BookmarkType.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import Foundation

enum BookmarkType :String, CaseIterable{
	case stationAndRoute = "노선 + 정류장"
	case statioin = "정류장"
	case route = "노선"
}

