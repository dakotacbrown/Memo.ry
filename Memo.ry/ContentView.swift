//
//  ContentView.swift
//  Remember.Me
//
//  Created by Dakota-Cheyenne Brown on 3/9/20.
//  Copyright © 2020 Dakota-Cheyenne Brown. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Memory.getAllMemories()) var memories: FetchedResults<Memory>
    
    
    @State var newMemory: String = ""
    @State var timeAgo: String = ""
    var formatter = DateFormatter()
    var isChanged: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 5){
                    Image(systemName: "plus.circle")
                        .padding(.leading)
                    Group{
                        TextField("What do you need to remember?", text: self.$newMemory, onEditingChanged: {
                            (isChanged) in
                        }) {
                            let memory = Memory(context: self.managedObjectContext)
                            memory.title = self.newMemory
                            self.formatter.dateStyle = .short
                            self.formatter.timeStyle = .medium
                            self.timeAgo = self.formatter.string(from: Date())
                            memory.createdAt = self.timeAgo
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                let nserror = error as NSError
                                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")

                            }
                            self.newMemory = ""
                        }.padding(.all, 12)
                            .keyboardType(.webSearch)
                    }.background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 5)
                        .padding(.trailing, 8)
                }
                List { ForEach(self.memories) { item in
                    Row(memoryItem: item.title, timeAgo: item.createdAt)
                }.onDelete { indexSet in
                    let deleteItem = self.memories[indexSet.first!]
                    self.managedObjectContext.delete(deleteItem)
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                    }
                }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }.navigationBarTitle("Memo.ry")
                .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
