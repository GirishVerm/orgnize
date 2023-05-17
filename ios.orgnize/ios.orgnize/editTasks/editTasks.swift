//
//  editTasks.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-26.
//

import Foundation
import SwiftUI

struct editTasks: View {
    
    
    

    @EnvironmentObject var groupObj: arcTaskGroupList
    
    
        
    @State private var presentAlert = false
    @State private var heading: String = ""
    
    func getTime(position: CGPoint) -> String{
        
        var someDegree = asin((position.x - 100)/(CGFloat(200)/2))
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
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                Button("Add Task Arc +"){
                    
                    presentAlert = true
                    heading = ""

                    print(groupObj.mainGroup)
                    


                    
                    
                    
                    
                    
                }
                .alert("New Task Arc", isPresented: $presentAlert, actions: {
                            TextField("Heading", text: $heading)
                            
                            
                            Button("Cancel", action: {})
                            Button("Done", role: .cancel ,action: {
                                
                                
                                let num = arc4random()
                                groupObj.mainGroup.insert(ArcTaskGroup(heading: heading, id: num), at: 0)
                                groupObj.focusGroup = num
                                
                                
                                
                                
                            })
                    
                        }, message: {
                            Text("Name this Task ARc")
                        })
                .padding()
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                    
                        .fill(.red)
                    
                    List{
                        
                        ForEach(0..<groupObj.mainGroup.count, id: \.self){groupIndex in
                            
                            
                            Section(header: Text(groupObj.mainGroup[groupIndex].heading + " : " + getTime(position: groupObj.mainGroup[groupIndex].position1) + " - " + getTime(position: groupObj.mainGroup[groupIndex].position2))
                                .font((groupObj.mainGroup[groupIndex].id == groupObj.focusGroup) ?
                                    .headline : .body)){
                                
                                ForEach(0..<groupObj.mainGroup[groupIndex].tasks.count, id: \.self){taskIndex in
                                    
                                    
                                    
                                    TextField(
                                        "Enter Task",
                                        text: Binding(
                                            get: { groupObj.mainGroup[groupIndex].tasks[taskIndex] },
                                            set: { groupObj.mainGroup[groupIndex].tasks[taskIndex] = $0 }
                                        )
                                        
                                    )
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive, action: {
                                            groupObj.mainGroup[groupIndex].tasks.remove(at: taskIndex)
                                            
                                        }) {
                                          Label("Delete", systemImage: "trash")
                                        }
                                      }
                                    
                                    
                                    
                                    
                                }
                                        
                                Text("Add Task +")
                                    .foregroundColor(.gray)
                                    .onTapGesture{
                                        
                                        let updatedGroup = groupObj.mainGroup[groupIndex]
                                        updatedGroup.tasks.append("")
                                        groupObj.mainGroup[groupIndex] = updatedGroup
                                        
                                        groupObj.focusGroup = groupObj.mainGroup[groupIndex].id
                                        
                                        
                                }
                                        
                                        Text("Delete Task Group")
                                            .foregroundColor(.red)
                                            .onTapGesture{
                                                
                                                groupObj.mainGroup.remove(at: groupIndex)
                                                
                                                
                                        }

                                        
                                                               
                            }
                                    
                            .onTapGesture{
                                groupObj.focusGroup = groupObj.mainGroup[groupIndex].id
                                print(groupObj.focusGroup)
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .background(.background)
                    .scrollContentBackground(.hidden)
                    
                }
                
            }
            
        }
        
        
    }
}
