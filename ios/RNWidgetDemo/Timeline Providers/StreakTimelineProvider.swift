//
//  StreakTimelineProvider.swift
//  RNWidget
//
//  Created by MAC on 28/04/23.
//

import Foundation
import WidgetKit

struct StreakTimelineProvider: IntentTimelineProvider {
    
    typealias Entry = StreakEntry
    
    func placeholder(in context: Context) -> Entry {
        Entry(configuration: ConfigurationIntent(), date: Date(), startDate: nil)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = Entry(configuration: context.isPreview ? ConfigurationIntent() : configuration, date: Date(), startDate: nil)
        completion(entry)
    }

  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
      var entries: [Entry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = Entry(configuration: configuration, date: Date(), startDate: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}
