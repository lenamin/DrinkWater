//
//  Alert.swift
//  DrinkWater
//
//  Created by Lena on 2022/07/10.
//

import Foundation

struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    let isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String {
        let meridiemForamtter = DateFormatter()
        meridiemForamtter.dateFormat = "a"
        meridiemForamtter.locale = Locale(identifier: "ko")
        return meridiemForamtter.string(from: date)
    }
}
