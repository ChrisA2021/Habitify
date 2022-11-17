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
    
    init(id: UUID = UUID(), title: String, streak: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.streak = streak
        self.theme = theme
    }
}

extension DailyHabits {
    
    struct Data {
        var title: String = ""
        var streak: Double = 0
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, streak: Double(streak), theme: theme)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        streak = Int(data.streak)
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        streak = Int(data.streak)
        theme = data.theme
    }
}

extension DailyHabits {
    static let sampleData: [DailyHabits] =
    [
        DailyHabits(title: "Reading", streak: 10, theme: .yellow),
        DailyHabits(title: "Exercise",  streak: 5, theme: .orange),
        DailyHabits(title: "Web Dev",  streak: 5, theme: .poppy)
    ]
}
