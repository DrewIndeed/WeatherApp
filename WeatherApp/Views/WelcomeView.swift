//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import SwiftUI

// for the Location Button
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        // Content starts
        VStack {
            // textual content
            VStack (spacing: 20) {
                Text("Welcome to the Weather App")
                    .bold()
                    .font(.system(size: 40))
                    .foregroundColor(Color(hue: 0.951, saturation: 0.636, brightness: 0.999))
                
                Text("Let's choose where you want to know about the weather, even your current area by clicking 'Share Current Location'!")
                    .font(.subheadline)
                    .padding()
            }
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .padding()
            
            // get location permission -> if yes, get location coordinates
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .frame(width: 250, height: 60)
            .background(Color(red: 0.0, green: 0.47843137254901963, blue: 1.0))
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            
            // go to cities list button
            Button(action: {
                // Jump to Australia cities list here
            }, label: {
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "sun.max.fill")
                        .padding(.leading, 10)
                        .foregroundColor(.yellow)
                    
                    Text("Get Australia Cities")
                        .font(.system(size: 19))
                        .foregroundColor(.yellow)
                        .padding(.all, 10)
                }
            })
            .background(
                RoundedRectangle(cornerRadius: 30.0)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.yellow)
                    .frame(width: 250, height: 57)
            )
            .frame(width: 250, height: 70)
            .padding(.top, 15)
        }
        // Content ends
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
