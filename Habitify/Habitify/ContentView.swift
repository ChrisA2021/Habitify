//
//  ContentView.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 12/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State var readingDays = 0
    @State var readDay = Date().dayBefore
    @State var readToday = false
    
    @State var exercisingDays = 0
    @State var exerciseDay = Date().dayBefore
    @State var exercisedToday = false
    let currentDay = Date()
    var body: some View {
        VStack {
            
            HStack {
                Text("My Habits").font(.system(size:60)).padding(.top, -220.0)
            }
            if #available(iOS 15.0, *) {
                Text("\(currentDay.formatted(date: .complete, time: .omitted))")
                    .padding(.top, -150.0)
            } else {
                // Fallback on earlier versions
            }
            HStack {
                Label("Reading", systemImage: "book")
                Button("Completed") {
                    if (Calendar.current.isDateInToday(readDay)) {
                        readToday = true
                    }
                    else {
                        readingDays = readingDays + 1
                        readDay = currentDay
                    }
                }
                Text("\(Int(readingDays))")
                Label("\(Int(readingDays))", systemImage: "flame.fill").labelStyle(.iconOnly)
            }
            .padding(.vertical)
            
            HStack {
                if (readToday == true) {
                    Text("Please read again tomorrow")
                }
            }
            
            HStack {
                Label("Exercising", systemImage: "figure.run")
                Button("Completed") {
                    if (Calendar.current.isDateInToday(exerciseDay)) {
                        exercisedToday = true
                    }
                    else {
                        exercisingDays = exercisingDays + 1
                        exerciseDay = currentDay
                    }
                }
                Text("\(Int(exercisingDays))")
                Label("\(Int(exercisingDays))", systemImage: "flame.fill").labelStyle(.iconOnly)
            }
            .padding(.vertical)
            
            HStack {
                if (exercisedToday == true) {
                    Label("Please exercise again tomorrow", systemImage: "flame.fill")
//                    Text("Please exercise again tomorrow")
                }
            }
            
            
        }
        .padding()
    }
}

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    

}
