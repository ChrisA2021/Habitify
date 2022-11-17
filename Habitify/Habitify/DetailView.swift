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
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(habits: .constant(DailyHabits.sampleData[0]))
        }
    }
}
