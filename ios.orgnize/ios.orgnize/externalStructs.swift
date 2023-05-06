//
//  externalStructs.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-25.
//

import SwiftUI
import Combine
extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
}

struct Arc: Shape {
  let startAngle: Angle
  let endAngle: Angle
  let clockwise: Bool

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let radius = max(rect.size.width, rect.size.height) / 2
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: clockwise)
    return path
  }
}

class arcTaskGroupList: ObservableObject{
    
    @Published var mainGroup: [ArcTaskGroup] = []
    
    @Published var focusGroup: UInt32 = UInt32(0)
    
    @Published var ongoingGroup: UInt32 = UInt32(0)
    

    
    


    
}

struct Time: Codable{
    var hours: Int
    var minutes: Int
}


