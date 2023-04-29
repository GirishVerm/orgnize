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

struct Time {
    var hours: Int
    var minutes: Int
}

class CustomObject {
    var startTime: Time?
    var endTime: Time?

    init(startTime: String, endTime: String) {
        self.startTime = parseTime(timeString: startTime)
        self.endTime = parseTime(timeString: endTime)
    }

    private func parseTime(timeString: String) -> Time? {
        let components = timeString.split(separator: ":")
        guard components.count == 2,
              let hours = Int(components[0]),
              let minutes = Int(components[1]) else {
            return nil
        }
        return Time(hours: hours, minutes: minutes)
    }

    func isTimeInRange(time: Time) -> Bool {
        guard let startTime = startTime, let endTime = endTime else { return false }
        if startTime.hours < endTime.hours || (startTime.hours == endTime.hours && startTime.minutes <= endTime.minutes) {
            return (time.hours > startTime.hours || (time.hours == startTime.hours && time.minutes >= startTime.minutes)) &&
                   (time.hours < endTime.hours || (time.hours == endTime.hours && time.minutes <= endTime.minutes))
        } else { // Range wraps around midnight
            return (time.hours > startTime.hours || (time.hours == startTime.hours && time.minutes >= startTime.minutes)) ||
                   (time.hours < endTime.hours || (time.hours == endTime.hours && time.minutes <= endTime.minutes))
        }
    }
}




