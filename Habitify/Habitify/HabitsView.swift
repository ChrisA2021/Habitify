//
//  HabitsView.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 17/11/2022.
//

import SwiftUI

struct HabitsView: View {
    @Binding var habits: [DailyHabits]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewHabitsView = false
    @State private var newHabitsData = DailyHabits.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($habits) { $habits in
                NavigationLink(destination: DetailView(habits: $habits)) {
                    CardView(habits: habits)
                }
                .listRowBackground(habits.theme.mainColor)
            }
        }
        .navigationTitle("Daily habits")
        .toolbar {
            Button(action: {
                isPresentingNewHabitsView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New habits")
        }
        .sheet(isPresented: $isPresentingNewHabitsView) {
            NavigationView {
                DetailEditView(data: $newHabitsData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewHabitsView = false
                                newHabitsData = DailyHabits.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newhabits = DailyHabits(data: newHabitsData)
                                habits.append(newhabits)
                                isPresentingNewHabitsView = false
                                newHabitsData = DailyHabits.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitsView(habits: .constant(DailyHabits.sampleData), saveAction: {})
        }
    }
}

