//
//  HabitifyApp.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 12/11/2022.
//

import SwiftUI

@main
struct HabitifyApp: App {
    @StateObject private var store = HabitsStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HabitsView(habits: $store.habits) {
                    HabitsStore.save(habits: store.habits) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                HabitsStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let habits):
                        store.habits = habits
                    }
                }
            }
        }
    }
}
