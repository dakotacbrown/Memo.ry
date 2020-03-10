//
//  Row.swift
//  Remember.Me
//
//  Created by Dakota-Cheyenne Brown on 3/9/20.
//  Copyright © 2020 Dakota-Cheyenne Brown. All rights reserved.
//

import SwiftUI

struct Row: View {
    @State var memoryItem: String = ""
    @State var timeAgo: String = ""
    @State var isDone: Bool = false
    var formatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Group {
                HStack {
                    Text(memoryItem)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image(systemName: (self.isDone) ? "checkmark" : "square")
                        .padding()
                }
                HStack(alignment: .center, spacing: 3){
                    Spacer()
                    Text((self.isDone) ? "Completed: " + self.timeAgo : "Added: " + self.timeAgo)
                        .foregroundColor(.white)
                        .italic()
                        .padding(.all, 4)
                }.padding(.bottom, 5)
            }.padding(.all, 4)
        }.opacity((self.isDone) ? 0.3 : 1.0 )
        .background((self.isDone) ? Color.gray : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .onTapGesture {
                self.isDone.toggle()
                self.formatter.dateStyle = .short
                self.formatter.timeStyle = .medium
                self.timeAgo = self.formatter.string(from: Date())
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row()
    }
}
