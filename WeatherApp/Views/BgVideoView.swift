//
//  BgVideoView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 02/08/2022.
//

import SwiftUI
import AVFoundation

public struct BgVideoView: View {
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

struct BgVideoView_Previews: PreviewProvider {
    static var previews: some View {
        BgVideoView(videoName: "weather_video")
    }
}
