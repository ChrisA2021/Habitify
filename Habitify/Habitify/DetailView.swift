//
//  DetailView.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 17/11/2022.
//

import SwiftUI

struct DetailView: View {
    @Binding var habits: DailyHabits
    
    @State private var data = DailyHabits.Data()
    @State private var isPresentingEditView = false
    @State private var streakCompleted = ""
    
    func streakMessage() {
        if (Calendar.current.isDateInToday(habits.lastUpdated)) {
            streakCompleted = "You're done for today, check back in tomorrow!"
        }
        else {
            streakCompleted = "Don't break that streak, complete it now!"
        }
    }
    
    func updateStreak() {
        // If last updated day is yesterday then update streak
        if Calendar.current.isDateInYesterday(habits.lastUpdated) {
            data.title = habits.title
            data.theme = habits.theme
            data.lastUpdated = Date()
            data.streak = habits.streak + 1
            streakCompleted = "Another day, another win"
            habits.update(from: data)
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Habit Info")) {
                HStack {
                    Label("Name", systemImage: "target")
                    Spacer()
                    Text("\(habits.title)")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(habits.theme.name)
                        .padding(4)
                        .foregroundColor(habits.theme.accentColor)
                        .background(habits.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
                }
            HStack {
                Text("Streak: \(Int(habits.streak)) days")
                Spacer()
                Button("Completed") {
                    updateStreak()
                }
            }
            HStack {
                Text(streakCompleted)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
            }
        }
        .navigationTitle(habits.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = habits.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(habits.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                habits.update(from: data)
                            }
                        }
                    }
            }
        }.onAppear(perform: streakMessage)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(habits: .constant(DailyHabits.sampleData[0]))
        }
    }
}
