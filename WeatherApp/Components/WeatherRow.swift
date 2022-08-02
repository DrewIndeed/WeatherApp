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
        HStack(spacing: 15) {
            // Icon for status attribute
            Image(systemName: logo)
                .font(.title3)
                .foregroundColor(.pink)
                .frame(width: 20, height: 20)
                .padding()
                .background(.white)
                .cornerRadius(40)
            
            // Readable contents for status attribute
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .font(.title3)
            }
        }
        // Status block ends
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "0.00 m/s")
    }
}
