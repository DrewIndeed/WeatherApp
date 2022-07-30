//
//  Extensions.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 30/07/2022.
//

import Foundation
import SwiftUI

extension WeatherResponseModel.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

extension Double {
    func roundDouble(pointnum: Int) -> String {
        return String(format: "%.\(pointnum)f", self)
    }
}

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
