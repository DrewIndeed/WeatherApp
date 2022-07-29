//
//  ActivityIndicatorView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import SwiftUI

import Foundation
import SwiftUI

struct ActivityIndicatorView: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        // you can change the size by changing the numebr 8
                        .frame(width: geometry.size.width / 10, height: geometry.size.height / 10)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                
                // you can change the size by changing the numebr 8
                    .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 10, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
    
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
