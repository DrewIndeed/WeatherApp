//
//  CustomProgressView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView("Loading...", value: 0, total: 100)
            .progressViewStyle(
                CircularProgressViewStyle(
                    tint: Color(hue: 0.94, saturation: 0.826, brightness: 0.991)
                )
            )
            .frame(width: .infinity, height: .infinity)
            .foregroundColor(Color(hue: 0.94, saturation: 0.826, brightness: 0.991))
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
