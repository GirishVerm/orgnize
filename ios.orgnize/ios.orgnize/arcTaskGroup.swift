//
//  arcTaskGroup.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-24.
//


import SwiftUI
import Combine
import Foundation




class ArcTaskGroup: ObservableObject{
    var id: UInt32
    var heading: String
    @Published var tasks:  [String]
    
    var position1: CGPoint
    var position2: CGPoint
    
    var startDegree: Double
    var endDegree: Double
    
    var startTime: Time?
    var endTime: Time?
    
    
    init(heading: String, id: UInt32){
        
        self.id = id
        self.heading = heading
        
        self.position1 = CGPoint(x:100, y:0)
        self.position2 = CGPoint(x:100, y:0)
        
        self.startDegree = 0.0
        self.endDegree = 0.0
        
        self.startTime = Time(hours: 0, minutes: 0)
        self.endTime = Time(hours: 0, minutes: 0)
        
        self.tasks = []
        
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
