/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Nguyen Truong An
  ID: 3820098
  Last modified: 05/08/2022
  Acknowledgement:
    + https://www.hackingwithswift.com/
    + https://openweathermap.org/
    + https://stackoverflow.com/
    + https://peterfriese.dev/
    + https://www.tutorialspoint.com/
    + https://www.github.com/
*/

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
