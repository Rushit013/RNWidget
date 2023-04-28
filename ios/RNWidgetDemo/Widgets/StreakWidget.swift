//
//  StreakWidget.swift
//  RNWidget
//
//  Created by MAC on 28/04/23.
//

import Foundation
import SwiftUI
import WidgetKit

struct StreakWidget: Widget {

    let kind: String = "StreakWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: StreakTimelineProvider()) { entry in
            StreakWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Streak Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }

}
