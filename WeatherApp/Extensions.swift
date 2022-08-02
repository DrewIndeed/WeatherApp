//
//  Extensions.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 30/07/2022.
//

import Foundation
import SwiftUI

// Extension to provide alternatives for reponse key's names with "_"
extension WeatherResponseModel.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

// Extension to format Double when printing
extension Double {
    func roundDouble(pointnum: Int) -> String {
        return String(format: "%.\(pointnum)f", self)
    }
    
    func convertDate(formate: String) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        //localization language
        dateFormatter.locale = NSLocale(localeIdentifier: "(your localization language)" ) as Locale
        
        //Specify your format that you want let
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: date);
    }
}

// Extension for adding rounded corners to specific corners of a View
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCorner(
                radius: radius,
                corners: corners)
        )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        return Path(path.cgPath)
    }
}

// Extension to return icons name according to string weather conditions
extension String {
    func checkIconName() -> String {
        let iconsMap: [String: String] = [
            "Clear": "sun.max.fill",
            "Clouds": "cloud.sun.fill",
            "Thunderstorm": "cloud.bolt.rain.fill",
            "Rain": "cloud.heavyrain.fill",
            "Snow": "snowflake",
            "Drizzle": "cloud.rain.fill"
        ]
        
        for (key, value) in iconsMap {
            if (key == self) {
                return value
            }
        }
        
        return "aqi.medium";
    }
    
    func checkCityTrailing() -> String {
        if (self.lowercased().contains("city")) {
            return self;
        }
        return self + " City"
    }
}
