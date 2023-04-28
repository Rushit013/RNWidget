//
//  StreakWidgetEntryView.swift
//  RNWidget
//
//  Created by MAC on 28/04/23.
//

import Foundation
import SwiftUI

struct StreakWidgetEntryView: View {
    
    @Environment(\.widgetFamily) var family
    
    var entry: StreakTimelineProvider.Entry
  
  var body: some View {
   return emptyRideView
  }
    
    var emptyRideView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Image("scooter-yellow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Spacer()
                Text("RIDE")
                    .foregroundColor(Color(red: 115 / 255, green: 85 / 255, blue: 7 / 255))
                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
                    .padding([.top, .bottom], 15)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 248 / 255, green: 220 / 255, blue: 150 / 255))
                    .cornerRadius(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(15)
        .background(Color(red: 251 / 255, green: 236 / 255, blue: 197 / 255))
    }
    
    func getBatteryStatusColor(_ charge: Int) -> Color {
        if charge >= 90 {
            return Color.green.opacity(0.7)
        }
        if charge < 90, charge >= 30 {
            return Color.yellow
        }
        return Color.red.opacity(0.7)
    }

}
