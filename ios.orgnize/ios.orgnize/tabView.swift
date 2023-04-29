//
//  tabView.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-24.
//


import Foundation
import SwiftUI
import Combine

struct tabView: View{
    var body: some View {
        
        
        
        TabView {
            
            ZStack{
                
                VStack{
                    
                    ongoingClock()
                        .background(Color.clear)
                    taskList()
                        .background(Color.clear)
                    
                }
                
            }
            .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Ongoing Tasks")
                
            }
            
            VStack{
                editClock()
                    .background(Color.clear)
                editTasks()
                    .background(Color.clear)
            }
            .tabItem {
                Image(systemName: "plus.app.fill")
                Text("Edit Tasks")
            }
 
        }
        
    }
}
