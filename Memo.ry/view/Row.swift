//
//  Row.swift
//  Remember.Me
//
//  Created by Dakota-Cheyenne Brown on 3/9/20.
//  Copyright © 2020 Dakota-Cheyenne Brown. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation
import CoreData

struct Row: View {
    var context: NSManagedObjectContext
    var mainMemory: Memory
    var formatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Group {
                HStack {
                    Text(self.mainMemory.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image(systemName: (self.mainMemory.isDone) ? "checkmark" : "square")
                        .padding()
                }
                HStack(alignment: .center, spacing: 3){
                    Spacer()
                    Text((self.mainMemory.isDone) ? "Completed: " + self.mainMemory.createdAt : "Added: " + self.mainMemory.createdAt)
                        .foregroundColor(.white)
                        .italic()
                        .padding(.all, 4)
                }.padding(.bottom, 5)
            }.padding(.all, 4)
        }.blur(radius: self.mainMemory.isDone ? 1 : 0)
        .opacity((self.mainMemory.isDone) ? 0.3 : 1.0 )
        .background((self.mainMemory.isDone) ? Color.gray : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .animation(.spring())
            .offset(x: self.mainMemory.isDone ? -100: 0)
            .onTapGesture {
                self.mainMemory.isDone.toggle()
                self.formatter.dateStyle = .short
                self.formatter.timeStyle = .medium
                self.mainMemory.createdAt = self.formatter.string(from: Date())
                do {
                    try self.context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
        }
    }
}
