//
//  ContentView.swift
//  Orgnize
//
//  Created by Girish Verma on 2023-02-17.
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


struct ContentView: View {
    
    @State private var position = CGPoint(x: 100, y: 100)
    @State private var initPosition1 = CGPoint(x:100, y:0)
    @State private var initPosition2 = CGPoint(x:100, y:0)
    
    @State private var startDegree = 0.0
    @State private var endDegree = 0.0
    
    @State private var startTime = ""
    @State private var endTime = ""
    
    
    
    private var dragDiametr: CGFloat = 200.0
    
    private var circumference = 2*(Double.pi)*100
    
    func updateArc(){
        
        //(round(initPosition1.x - 100),-round(initPosition1.y - 100))
        
        //print(asin(round(initPosition1.x - 100)/(dragDiametr/2)) *  (180/(.pi)) - 90)
        
        startDegree = asin((initPosition1.x - 100)/(dragDiametr/2))
        startDegree = startDegree *  (180/(.pi)) - 90
        
        if -round(initPosition1.y - 100) < 0{
            startDegree = abs(startDegree)
        }
        
        
        
        endDegree = asin((initPosition2.x - 100)/(dragDiametr/2))
        endDegree = endDegree *  (180/(.pi)) - 90
        
        if -round(initPosition2.y - 100) < 0{
            endDegree = abs(endDegree)
        }
        
        
        if endDegree + 90 < 0 {
            //print("start:", startDegree, "end:", (360-abs(endDegree)) + 90)
            //print("time:", round((12*((360 - abs(endDegree)) + 90))/360) == 0.0 ? 12.0 : (12*((360 - abs(endDegree)) + 90))/360)
            
            let time = ((12*((360 - abs(endDegree)) + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            endTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("Time:", Int(hour),":", Int(minutes))

            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(endDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            endTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("Time:", Int(hour),":", Int(minutes))
      
        }
        
        
        if startDegree + 90 < 0 {
            //print("start:", startDegree, "end:", (360-abs(endDegree)) + 90)
            //print("time:", round((12*((360 - abs(endDegree)) + 90))/360) == 0.0 ? 12.0 : (12*((360 - abs(endDegree)) + 90))/360)
            
            let time = ((12*((360 - abs(startDegree)) + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            startTime = String(Int(hour)) + ":" + String(Int(minutes))

            print("Time:", Int(hour),":", Int(minutes))

            
        }else{
            //print("start:", startDegree, "end:", endDegree + 90)
            //print("time:",  round((12*(endDegree + 90))/360) == 0.0 ? 12 : (12*(endDegree + 90))/360)
            
            let time = ((12*(startDegree + 90))/360)
            let hour = floor(time)
            let minutes = floor((time - hour) * 60)
            
            startTime = String(Int(hour)) + ":" + String(Int(minutes))
            print("Time:", Int(hour),":", Int(minutes))
      
        }
     
        
        

        
    }
    
    
    //x=r.cose(theta)
    //y=r.sin(theta)
    
    //use circumference with percentage of circumference.
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack{
                
                Text("Start Time:"+startTime)
                Text("End Time:"+endTime)
                
                Circle()
                    .frame(width: dragDiametr + 20, height: dragDiametr + 20)
                    .foregroundColor(Color.white)
                    .padding(20)
                    .overlay(
                        
                        Group{
                            Circle()
                                .frame(width: dragDiametr, height: dragDiametr)
                                .foregroundColor(Color.white)
                                .padding(20)
                                .overlay(
                                    
                                    Group {
                                        // -- 12 O' Clock
                                        Text("12")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:(dragDiametr/2) + 20,y:0)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 1 O' Clock
                                        Text("1")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:(dragDiametr/2) + (dragDiametr/6) + 40,y: (dragDiametr/6) - 20)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 2 O' Clock
                                        Text("2")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:(dragDiametr/2) + (dragDiametr/6) + (dragDiametr/6) + 60,y: (dragDiametr/6) + (dragDiametr/6) - 10)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 3 O' Clock
                                        Text("3")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:dragDiametr + 40,y:dragDiametr/2 + 20)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 4 O' Clock
                                        Text("4")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:(dragDiametr/2) + (dragDiametr/6) + (dragDiametr/6) + 60,y: (dragDiametr/2) + (dragDiametr/6) + 50)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 5 O' Clock
                                        Text("5")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:(dragDiametr/2) + (dragDiametr/6) + 50,y: (dragDiametr/2) + (dragDiametr/6) + (dragDiametr/6) + 60)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 6 O' Clock
                                        Text("6")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:dragDiametr/2 + 20,y:dragDiametr + 40)
                                            .foregroundColor(Color.gray)
                                        
                                        // -- 9 O' Clock
                                        Text("9")
                                            .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                            .position(x:0,y:dragDiametr/2 + 20)
                                            .foregroundColor(Color.gray)
                                        
                                    }
                                )
                          
                                .overlay(
                                    
                                    Group {
                                    
                                    Arc(
                                        startAngle: .degrees(startDegree),
                                        endAngle: .degrees(endDegree), clockwise: false)
                                      .stroke(Color.blue, lineWidth: 20)
                                      .frame(width: dragDiametr, height: dragDiametr)
                                 
                                   
                                    Circle()
                                        .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                        .foregroundColor(Color.red)
                                        .position(x: initPosition1.x + 20, y: initPosition1.y + 20)
                                        .gesture(DragGesture()
                                            .onChanged(){value in
                                                let currentLocation = value.location
                                                let center = CGPoint(x: self.dragDiametr/2, y: self.dragDiametr/2)
                                                let distance = center.distance(to:currentLocation)
                                                print("boundary boundary")
                                                let k = (self.dragDiametr / 2) / distance
                                                let newLocationX = (currentLocation.x - center.x) * k+center.x
                                                let newLocationY = (currentLocation.y - center.y) * k+center.y
                                                self.initPosition1 = CGPoint(x: newLocationX, y: newLocationY)
                                                updateArc()
                                                
                                            }
                                        
                                        )
                                    Circle()
                                        .frame(width: dragDiametr / 10, height: dragDiametr / 10)
                                        .foregroundColor(Color.cyan)
                                        .position(x: initPosition2.x + 20, y: initPosition2.y + 20)
                                        .gesture(DragGesture()
                                            .onChanged(){value in
                                                let currentLocation = value.location
                                                let center = CGPoint(x: self.dragDiametr/2, y: self.dragDiametr/2)
                                                let distance = center.distance(to:currentLocation)
                                                print("boundary boundary")
                                                let k = (self.dragDiametr / 2) / distance
                                                let newLocationX = (currentLocation.x - center.x) * k+center.x
                                                let newLocationY = (currentLocation.y - center.y) * k+center.y
                                                self.initPosition2 = CGPoint(x: newLocationX, y: newLocationY)
                                                updateArc()
                                                
                                            }
                                        
                                        )
                                    
                                })
                                .overlay(
                                    Circle()
                                        .frame(width:dragDiametr - 20, height: dragDiametr - 20)
                                        .foregroundColor(Color.blue)
                                )
                            
                        }
                    
                    )
                
                
            }
            
            
        
        }
        
        .padding()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
