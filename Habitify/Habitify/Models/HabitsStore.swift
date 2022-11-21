//
//  habitstore.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 17/11/2022.
//

import Foundation
import SwiftUI

class HabitsStore: ObservableObject {
    @Published var habits: [DailyHabits] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("habits.data")
    }
    
    static func load() async throws -> [DailyHabits] {
            try await withCheckedThrowingContinuation { continuation in
                load { result in
                    switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .success(let habits):
                        continuation.resume(returning: habits)
                    }
                }
            }
        }
    
    static func load(completion: @escaping (Result<[DailyHabits], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyHabits = try JSONDecoder().decode([DailyHabits].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyHabits))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
        static func save(habits: [DailyHabits]) async throws -> Int {
            try await withCheckedThrowingContinuation { continuation in
                save(habits: habits) { result in
                    switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .success(let habitsSaved):
                        continuation.resume(returning: habitsSaved)
                    }
                }
            }
        }
    
    static func save(habits: [DailyHabits], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(habits)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(habits.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
