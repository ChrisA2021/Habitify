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
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyHabits.sampleData[0].data))
    }
}
