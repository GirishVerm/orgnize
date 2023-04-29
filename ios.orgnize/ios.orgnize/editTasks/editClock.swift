//
//  ongoingClock.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-24.
//

import Foundation
import SwiftUI


struct editClock: View{
    
    
    @EnvironmentObject var groupObj: arcTaskGroupList
    
    var dragDiameter: CGFloat = 200
    
    @State var position1: CGPoint = CGPoint(x: 100, y: 0)
    @State var position2: CGPoint = CGPoint(x: 100, y: 0)
    
    @State private var startDegree = 0.0
    @State private var endDegree = 0.0
    
    @State private var angle: Double = 0
    
    @State private var typeTime: String = ""
    @State private var time: String = ""
    
    func getTime(position: CGPoint) -> String{
        
        var someDegree = asin((position.x - 100)/(dragDiameter/2))
        someDegree = someDegree *  (180/(.pi)) - 90
        
        if -round(position.y - 100) < 0 {
            someDegree = abs(someDegree)
        }
        
        if someDegree + 90 < 0 {
            //print("start:", startDegree, "end:", (360-abs(endDegree)) + 90)
            //print("time:", round((12*((360 - abs(endDegree)) + 90))/360) == 0.0 ? 12.0 : (12*((360 - abs(endDegree)) + 90))/360)
            
            let time = ((12*((360 - abs(someDegree)) + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            
            //startTime = String(Int(hour)) + ":" + String(Int(minutes))

            return String(Int(hour)) + ":" + String(Int(minutes))


            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(someDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            //startTime = String(Int(hour)) + ":" + String(Int(minutes))
            
            
            return String(Int(hour)) + ":" + String(Int(minutes))
       

      
        }
        
    }

    
    func updateArc(position1: CGPoint, position2: CGPoint){
        
        var startTime = Time(hours: 0, minutes: 0)
        var endTime = Time(hours: 0, minutes: 0)
        
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

            print("starttime:" + String(Int(hour)) + ":" + String(Int(minutes)))
            startTime.hours = Int(hour)
            startTime.minutes = Int(minutes)

            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(startDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            //startTime = String(Int(hour)) + ":" + String(Int(minutes))
            
            
            print("startTime:" + String(Int(hour)) + ":" + String(Int(minutes)))
            startTime.hours = Int(hour)
            startTime.minutes = Int(minutes)

      
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

            print("EndTime:" + String(Int(hour)) + ":" + String(Int(minutes)))
            endTime.hours = Int(hour)
            endTime.minutes = Int(minutes)

            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(endDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            //endTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("EndTime:" + String(Int(hour)) + ":" + String(Int(minutes)))
            endTime.hours = Int(hour)
            endTime.minutes = Int(minutes)
      
        }
        
        // End Degree Operations End
        
        
        if let i = groupObj.mainGroup.firstIndex(where: { $0.id == groupObj.focusGroup }) {
            
            
            
            groupObj.mainGroup[i].startDegree = startDegree
            groupObj.mainGroup[i].endDegree = endDegree
            
            groupObj.mainGroup[i].position1 = position1
            groupObj.mainGroup[i].position2 = position2
            
            groupObj.mainGroup[i].startTime = startTime
            groupObj.mainGroup[i].endTime = endTime
            
            
            
            
            
        }
        
        
        
    }
    
    
        
    func updateAngle() {
        let calendar = Calendar.current
        let date = Date()
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)

        // Convert the current time to seconds since midnight
        let secondsSinceMidnight = Double(hour * 3600 + minute * 60 + second)

        // Calculate the angle based on 12-hour clock (43200 seconds in a 12-hour cycle)
        angle = (secondsSinceMidnight / 43200.0) * 360.0 - 90.0
        
        
        
    }

    
    
    var body: some View{
        
        
        
        
        NavigationView{
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 25).fill(.background)
                
                Circle()
                    .frame(width: dragDiameter + 40, height: dragDiameter + 40)
                    .foregroundColor(.blue)
                
                Circle()
                    .frame(width: dragDiameter, height: dragDiameter)
                    .foregroundColor(.white.opacity(0.3))
                    .overlay(
                        
                        VStack(alignment: .center){
                            
                            Text(typeTime)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.headline)
                                .fontWeight(Font.Weight.bold)
                            
                            Text(time)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(Font.Weight.bold)
                        }
                        
                        
                        
                    )
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
                                    .onEnded(){value in
                                        time = ""
                                        typeTime = ""
                                    }
                                    .onChanged(){value in
                                        
                                        if(!groupObj.mainGroup.isEmpty){
                                            
                                            typeTime = "Start"
                                            
                                            
                                            let currentLocation = value.location
                                            let center = CGPoint(x: dragDiameter/2, y: dragDiameter/2)
                                            let distance = center.distance(to:currentLocation)
                                            print("boundary boundary")
                                            let k = (dragDiameter / 2) / distance
                                            let newLocationX = (currentLocation.x - center.x) * k+center.x
                                            let newLocationY = (currentLocation.y - center.y) * k+center.y
                                            
                                            position1 = CGPoint(x: newLocationX, y: newLocationY)
                                            
                                            time = getTime(position:CGPoint(x: newLocationX, y: newLocationY))
                                            
                                            updateArc(position1: position1, position2: position2)
                                            //_ = CGPoint(x: newLocationX, y: newLocationY)
                                            //arcTaskGroup[$0].position1 = newPosition1
                                            //focus = true
                                            //arcTaskGroup.append(arcTaskGroup[index])
                                            //arcTaskGroup.remove(at: index)
                                            //ArcIndex = index
                                            //updateArc(position1: CGPoint(x: newLocationX, y: newLocationY), position2: arcTaskGroup[index].position2, index: index)
                                            
                                        }
                                        
                                        
                                        
                                    })
                            
                            
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("light_blue"))
                                .position(x: position2.x, y: position2.y)
                                .gesture(DragGesture()
                                    .onEnded(){value in
                                        time = ""
                                        typeTime = ""
                                    }
                                    .onChanged(){value in
                                        
                                        if(!groupObj.mainGroup.isEmpty){
                                            
                                            typeTime = "End"
                                            
                                            let currentLocation = value.location
                                            let center = CGPoint(x: dragDiameter/2, y: dragDiameter/2)
                                            let distance = center.distance(to:currentLocation)
                                            print("boundary boundary")
                                            let k = (dragDiameter / 2) / distance
                                            let newLocationX = (currentLocation.x - center.x) * k+center.x
                                            let newLocationY = (currentLocation.y - center.y) * k+center.y
                                            
                                            time = getTime(position:CGPoint(x: newLocationX, y: newLocationY))
                                            
                                            position2 = CGPoint(x: newLocationX, y: newLocationY)
                                            updateArc(position1: position1, position2: position2)
                                            //_ = CGPoint(x: newLocationX, y: newLocationY)
                                            //arcTaskGroup[$0].position1 = newPosition1
                                            //focus = true
                                            //arcTaskGroup.append(arcTaskGroup[index])
                                            //arcTaskGroup.remove(at: index)
                                            //ArcIndex = index
                                            //updateArc(position1: CGPoint(x: newLocationX, y: newLocationY), position2: arcTaskGroup[index].position2, index: index)
                                        }
                                        
                                        
                                        
                                    })
                            
                            
                            /*
                            Arc(startAngle: .degrees(-1 + angle),  endAngle: .degrees(1 + angle), clockwise: false)
                                .stroke(.white, lineWidth: 50)
                                .frame(width: dragDiameter, height: dragDiameter)
                                .onAppear {
                                    updateAngle()
                                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                        updateAngle()
                                        
                                    }
                                    
                                }
                            */
                            
                        }
                        
                        
                    )
                
                
                
                    
                
                    
                
            }
            .onChange(of: groupObj.focusGroup, perform: { newValue in
                if let i = groupObj.mainGroup.firstIndex(where: { $0.id == groupObj.focusGroup }) {
                    
                    startDegree = groupObj.mainGroup[i].startDegree
                    endDegree = groupObj.mainGroup[i].endDegree
                    
                    position1 = groupObj.mainGroup[i].position1
                    position2 = groupObj.mainGroup[i].position2
                    
                    
                    
                    
                }
            })
            .navigationBarTitle("Edit Tasks")
                .frame(width: dragDiameter + 40, height: dragDiameter + 40)
            
        }
        
    }
}
