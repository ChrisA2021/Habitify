//
//  DailyHabits.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 17/11/2022.
//

import Foundation

struct DailyHabits: Identifiable, Codable {
    let id: UUID
    var title: String
    var streak: Int
    var theme: Theme
    var lastUpdated: Date
    
    init(id: UUID = UUID(), title: String, streak: Int, theme: Theme, lastUpdated: Date) {
        self.id = id
        self.title = title
        self.streak = streak
        self.theme = theme
        self.lastUpdated = lastUpdated
    }
}

extension DailyHabits {
    
    struct Data {
        var title: String = ""
        var streak: Double = 0
        var theme: Theme = .seafoam
        var lastUpdated: Date = Date().dayBefore
    }
    
    var data: Data {
        Data(title: title, streak: Double(streak), theme: theme, lastUpdated: lastUpdated)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        streak = Int(data.streak)
        theme = data.theme
        lastUpdated = data.lastUpdated
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        streak = Int(data.streak)
        theme = data.theme
        lastUpdated = data.lastUpdated
    }
}

extension DailyHabits {
    static let sampleData: [DailyHabits] =
    [
        DailyHabits(title: "Reading", streak: 10, theme: .yellow, lastUpdated: Date().dayBefore),
        DailyHabits(title: "Exercise",  streak: 5, theme: .orange, lastUpdated: Date().dayBefore),
        DailyHabits(title: "Web Dev",  streak: 5, theme: .poppy, lastUpdated: Date().dayBefore)
    ]
}
