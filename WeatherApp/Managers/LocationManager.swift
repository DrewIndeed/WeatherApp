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
//  LocationManager.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D? // remember to be Optional
    @Published var isLoading = false // loading state for fetching data
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    /*
     Method to request location from device
     */
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    /*
     Method to track if location has been fetched
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    /*
     Method to track if location authorization has been updated
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // request again if location update process got delayed or ignored
        if (location == nil) {
            manager.requestLocation()
        }
    }
    
    /*
     Method to track if there has been an error fetching weather data
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[ERROR GETTING LOCATION]:", error)
    }
}
