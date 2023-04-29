//
//  ios_orgnizeApp.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-24.
//

import SwiftUI

@main
struct ios_orgnizeApp: App {
    
    let groupObj = arcTaskGroupList()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                
                tabView()
                    .environmentObject(groupObj)
                
            }
            
            
        }
    }
}
