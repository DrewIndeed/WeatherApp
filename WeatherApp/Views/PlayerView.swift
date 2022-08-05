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
//  PlayerView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 02/08/2022.
//

import SwiftUI
import AVFoundation

struct PlayerView: UIViewRepresentable {
    private let videoName: String
    private let player: AVQueuePlayer
    
    init(videoName: String, player: AVQueuePlayer) {
        self.videoName = videoName
        self.player = player
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) { }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(videoName: videoName, player: player)
    }
}
