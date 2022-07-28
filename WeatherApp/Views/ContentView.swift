//
//  ContentView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import SwiftUI

struct ContentView: View {
    /* using StateObject to notify the View everytime
     the @Publish variables in Location Manager are updated */
    @StateObject var locationManager = LocationManager()
    
    @State var backgroundColor: Color = Color(hue: 0.656, saturation: 0.932, brightness: 0.475)
    
    var body: some View {
        ZStack {
            // background
            backgroundColor.ignoresSafeArea(.all)
            
            // content
            WelcomeView()
                .environmentObject(locationManager)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
