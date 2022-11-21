//
//  DetailEditView.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 17/11/2022.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: DailyHabits.Data
    @State private var newAttendeeName = ""
    @State private var streakCompleted = "Don't break that streak, complete it now!"
    
    var body: some View {
        Form {
            Section(header: Text("Habit Info")) {
                TextField("Title", text: $data.title)
                ThemePicker(selection: $data.theme)
                HStack {
                    Text("Streak: \(Int(data.streak)) days")
                    Spacer()
                    Button("Completed") {
                        if (Calendar.current.isDateInToday(data.lastUpdated)) {
                            streakCompleted = "You're done for today, check back in tomorrow!"
                        }
                        else {
                            data.lastUpdated = Date()
                            data.streak = data.streak + 1
                            streakCompleted = "Another day another win"
                        }
                    }
                }
                HStack {
                    Text("\(streakCompleted)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.red)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyHabits.sampleData[0].data))
    }
}


//func updateStreak (data: DailyHabits.Data) -> String {
//    if (Calendar.current.isDateInToday(data.lastUpdated)) {
//        return "You're done for today, check back in tomorrow!"
//    }
//    else {
//        data.lastUpdated = Date()
//        data.streak = data.streak + 1
//        streakCompleted = "Another day another win"
//    }
//
//}
