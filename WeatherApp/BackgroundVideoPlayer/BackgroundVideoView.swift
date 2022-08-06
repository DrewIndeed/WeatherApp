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
//  BgVideoView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 02/08/2022.
//

import SwiftUI
import AVFoundation

public struct BackgroundVideoView: View {
    @State private var player = AVQueuePlayer()
    private let videoName: String
    
    public init(videoName: String) {
        self.videoName = videoName
    }
    
    public var body: some View {
        GeometryReader(content: { geo in
            PlayerView(videoName: videoName, player: player)
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height)
                .onAppear {
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    player.pause()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    player.play()
                }
        })
        .ignoresSafeArea()
    }
}

struct BackgroundVideoView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundVideoView(videoName: "Clear")
    }
}
