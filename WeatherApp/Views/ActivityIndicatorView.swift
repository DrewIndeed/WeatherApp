//
//  ActivityIndicatorView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: View {
    @State private var isAnimating: Bool = false
    let colors: [Color] = [.pink, .yellow, .green, .cyan, .orange].reversed()
    var divideValue: Double
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<colors.count, id: \.self) { index in
                Group {
                    Circle()
                    // can change the size by changing the divideValue
                        .frame(width: geometry.size.width / divideValue,
                               height: geometry.size.height / divideValue)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .foregroundColor(colors[index])
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                
                // can change the size by changing the divideValue
                .animation(
                    Animation
                        .timingCurve(0.5, 0.15 + Double(index) / divideValue, 0.25, 1, duration: 2)
                        .repeatForever(autoreverses: false),
                    value: self.isAnimating
                )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    /*
     Method to change the scale of the circle shapes
     */
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ?
                1 - CGFloat(Float(index)) / 5
                : 0.2 + CGFloat(index) / 5)
    }
    
    /*
     Method to calculate custom Y offset
     */
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
    
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(divideValue: 5.0)
    }
}
