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
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
            WindowGroup {
                NavigationView {
                    HabitsView(habits: $store.habits) {
                        Task {
                            do {
                                try await HabitsStore.save(habits: store.habits)
                            } catch {
                                errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                            }
                        }
                    }
                }
                .task {
                    do {
                        store.habits = try await HabitsStore.load()
                        await store.checkLastUpdated()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Habitify will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper, onDismiss: {
                    store.habits = DailyHabits.sampleData
                }) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            }
        }
}
