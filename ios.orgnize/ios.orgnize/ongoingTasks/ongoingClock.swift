//
//  ongoingClock.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-24.
//

import Foundation
import SwiftUI


struct ongoingClock: View{
    
    
    @EnvironmentObject var groupObj: arcTaskGroupList
    
    
    var dragDiameter: CGFloat = 200
    
    @State var position1: CGPoint = CGPoint(x: 100, y: 0)
    @State var position2: CGPoint = CGPoint(x: 100, y: 0)
    
    @State private var startDegree = 0.0
    @State private var endDegree = 0.0
    
    @State private var angle: Double = 0

    
    
    func updateArc(position1: CGPoint, position2: CGPoint){
        
        
        startDegree = asin((position1.x - 100)/(dragDiameter/2))
        startDegree = startDegree *  (180/(.pi)) - 90
        
        if -round(position1.y - 100) < 0 {
            startDegree = abs(startDegree)
        }
        
        if startDegree + 90 < 0 {
            //print("start:", startDegree, "end:", (360-abs(endDegree)) + 90)
            //print("time:", round((12*((360 - abs(endDegree)) + 90))/360) == 0.0 ? 12.0 : (12*((360 - abs(endDegree)) + 90))/360)
            
            let time = ((12*((360 - abs(startDegree)) + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            
            //startTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("Time:", Int(hour),":", Int(minutes))

            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(startDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            //startTime = String(Int(hour)) + ":" + String(Int(minutes))
            print("Time:", Int(hour),":", Int(minutes))
      
        }
        
        
        // --  Start Degree Operations End
        
        
        
        // -- End Degree Operations Begin
        endDegree = asin((position2.x - 100)/(dragDiameter/2))
        endDegree = endDegree *  (180/(.pi)) - 90
        
        if -round(position2.y - 100) < 0{
            endDegree = abs(endDegree)
        }
        
        
        if endDegree + 90 < 0 {
            //print("start:", startDegree, "end:", (360-abs(endDegree)) + 90)
            //print("time:", round((12*((360 - abs(endDegree)) + 90))/360) == 0.0 ? 12.0 : (12*((360 - abs(endDegree)) + 90))/360)
            
            let time = ((12*((360 - abs(endDegree)) + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            //endTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("Time:", Int(hour),":", Int(minutes))

            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(endDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            //endTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("Time:", Int(hour),":", Int(minutes))
      
        }
        
        // End Degree Operations End
        
        
        
        
    }
    
    
        
    func updateAngle() {
        
        var timeToCheck = Time(hours: 0, minutes: 0)
        let calendar = Calendar.current
        let date = Date()
        var hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)

        // Convert the current time to seconds since midnight
        let secondsSinceMidnight = Double(hour * 3600 + minute * 60 + second)

        // Calculate the angle based on 12-hour clock (43200 seconds in a 12-hour cycle)
        angle = (secondsSinceMidnight / 43200.0) * 360.0 - 90.0
        
        
        if(hour >= 12){
            hour = hour - 12
            timeToCheck.hours = hour
            timeToCheck.minutes = minute

        }else{
            timeToCheck.hours = hour
            timeToCheck.minutes = minute

        }
        
        
        for group in groupObj.mainGroup{
            
            if(group.isTimeInRange(time: timeToCheck)){
                
                
                groupObj.ongoingGroup = group.id
                
                startDegree = group.startDegree
                endDegree = group.endDegree
                
                position1 = group.position1
                position2 = group.position2
                
            }else{
                
                groupObj.ongoingGroup = UInt32(0)
                
                startDegree = 0.0
                endDegree = 0.0
                
                position1 = CGPoint(x: 100, y: 0)
                position2 = CGPoint(x: 100, y: 0)
                
                
            }
        }


        
        
        
        
        
        

    }

    
    
    var body: some View{
        
        
        
        
        NavigationView{
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.clear)
                
                Circle()
                    .frame(width: dragDiameter + 40, height: dragDiameter + 40)
                    .foregroundColor(.blue)
                
                Circle()
                    .frame(width: dragDiameter, height: dragDiameter)
                
                /*
                    .background(
                        Image("tiger")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    )
                 
                 */
                    .foregroundColor(.white.opacity(0.3))
                    .overlay(
                        
                        Group{
                            
                            
                            
                            Arc(
                                startAngle: .degrees(startDegree),
                                endAngle: .degrees(endDegree), clockwise: false)
                            .stroke(Color("light_blue"), lineWidth: 25)
                            .frame(width: dragDiameter, height: dragDiameter)
                            
                            /*
                             .onTapGesture(perform: {
                               
                                
                            })
                            */
                            
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("light_blue"))
                                .position(x: position1.x, y: position1.y)
                                .gesture(DragGesture()
                                    .onChanged(){value in
                                        let currentLocation = value.location
                                        let center = CGPoint(x: dragDiameter/2, y: dragDiameter/2)
                                        let distance = center.distance(to:currentLocation)
                                        print("boundary boundary")
                                        let k = (dragDiameter / 2) / distance
                                        let newLocationX = (currentLocation.x - center.x) * k+center.x
                                        let newLocationY = (currentLocation.y - center.y) * k+center.y
                                        
                                        position1 = CGPoint(x: newLocationX, y: newLocationY)
                                        updateArc(position1: position1, position2: position2)
                                        //_ = CGPoint(x: newLocationX, y: newLocationY)
                                        //arcTaskGroup[$0].position1 = newPosition1
                                        //focus = true
                                        //arcTaskGroup.append(arcTaskGroup[index])
                                        //arcTaskGroup.remove(at: index)
                                        //ArcIndex = index
                                        //updateArc(position1: CGPoint(x: newLocationX, y: newLocationY), position2: arcTaskGroup[index].position2, index: index)
                                        
                                    })
                            
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("light_blue"))
                                .position(x: position2.x, y: position2.y)
                                .gesture(DragGesture()
                                    .onChanged(){value in
                                        let currentLocation = value.location
                                        let center = CGPoint(x: dragDiameter/2, y: dragDiameter/2)
                                        let distance = center.distance(to:currentLocation)
                                        print("boundary boundary")
                                        let k = (dragDiameter / 2) / distance
                                        let newLocationX = (currentLocation.x - center.x) * k+center.x
                                        let newLocationY = (currentLocation.y - center.y) * k+center.y
                                        
                                        position2 = CGPoint(x: newLocationX, y: newLocationY)
                                        updateArc(position1: position1, position2: position2)
                                        //_ = CGPoint(x: newLocationX, y: newLocationY)
                                        //arcTaskGroup[$0].position1 = newPosition1
                                        //focus = true
                                        //arcTaskGroup.append(arcTaskGroup[index])
                                        //arcTaskGroup.remove(at: index)
                                        //ArcIndex = index
                                        //updateArc(position1: CGPoint(x: newLocationX, y: newLocationY), position2: arcTaskGroup[index].position2, index: index)
                                        
                                    })
                            
                            Arc(startAngle: .degrees(-1 + angle),  endAngle: .degrees(1 + angle), clockwise: false)
                                .stroke(.white, lineWidth: 50)
                                .frame(width: dragDiameter, height: dragDiameter)
                                .onAppear {
                                    updateAngle()
                                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                        updateAngle()
                                        
                                    }
                                    
                                }
                            
                            
                            
                        }
                        
                        
                    )
                
                
                
                    
                
                    
                
            }
            .navigationBarTitle("Ongoing Tasks")
                .frame(width: dragDiameter + 40, height: dragDiameter + 40)
            
        }
        
    }
}
