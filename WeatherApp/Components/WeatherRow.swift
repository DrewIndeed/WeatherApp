//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 30/07/2022.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        // Status block starts
        HStack(spacing: 20) {
            // Icon for status attribute
            Image(systemName: logo)
                .font(.title2)
                .foregroundColor(.pink)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 0.76, saturation: 0.032, brightness: 0.879, opacity: 0.3))
                .cornerRadius(50)
            
            // Readable contents for status attribute
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title3)
            }
        }
        // Status block ends
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
