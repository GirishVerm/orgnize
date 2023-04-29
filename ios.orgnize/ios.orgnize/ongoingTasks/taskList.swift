//
//  editTasks.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-26.
//

import Foundation
import SwiftUI

struct taskList: View {
    
    
    

    @EnvironmentObject var groupObj: arcTaskGroupList
    
    
        
    @State private var presentAlert = false
    @State private var heading: String = ""
    

    var body: some View {
        
        NavigationView{
            VStack{
        
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                    
                        .fill(.background)
                    
                    
                    if (groupObj.mainGroup.isEmpty || groupObj.ongoingGroup == UInt32(0)){
                        
                        Text("No Tasks").foregroundColor(.gray)
                        
                    }else{
                        
                        List{
                            
                            ForEach(0..<groupObj.mainGroup.count, id: \.self){groupIndex in
                                
                                Section(header: Text(groupObj.mainGroup[groupIndex].heading)
                                    .font((groupObj.mainGroup[groupIndex].id == groupObj.ongoingGroup) ?
                                        .headline : .body)){
                                    
                                    ForEach(0..<groupObj.mainGroup[groupIndex].tasks.count, id: \.self){taskIndex in
                                        
                                        TextField(
                                            "Enter Task",
                                            text: $groupObj.mainGroup[groupIndex].tasks[taskIndex]
                                        )
                                        
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
}
