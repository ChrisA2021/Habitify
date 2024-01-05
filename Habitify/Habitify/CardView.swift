//
//  CardView.swift
//  Habitify
//
//  Created by Chrishane Amarasekara on 17/11/2022.
//

import SwiftUI

struct CardView: View {
    let habits: DailyHabits
    
    var body: some View {
        VStack(alignment: .leading) {
//            Spacer()
            HStack {
                Text(habits.title)
                    .accessibilityAddTraits(.isHeader)
                    .font(.headline)
                Spacer()
                Text("\(habits.streak)").font(.body)
                Text("🔥").font(.body)
              .accessibilityLabel("\(habits.streak)").labelStyle(.trailingIcon)
                    
            }
            .font(.caption)
        }
        .padding(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var habits = DailyHabits.sampleData[0]
    static var previews: some View {
        CardView(habits: habits)
            .background(habits.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
