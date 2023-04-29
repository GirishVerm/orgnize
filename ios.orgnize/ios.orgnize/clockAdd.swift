//
//  clockAdd.swift
//  ios.orgnize
//
//  Created by Girish Verma on 2023-04-24.
//

import Foundation
import SwiftUI

struct addClock: View{
    var body: some View{
        
        NavigationView{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red)
                Text("Hello")
            }.navigationBarTitle("Edit Tasks")
        }
        
    }
}
