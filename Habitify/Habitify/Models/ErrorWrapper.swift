//
//  ErrorWrapper.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 20/11/2022.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}

