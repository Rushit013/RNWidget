//
//  RNWidgetDemo.swift
//  RNWidgetDemo
//
//  Created by MAC on 28/04/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
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

struct Entry: TimelineEntry {
    let configuration: ConfigurationIntent
    let date: Date

    let startDate: Date?
}

struct RNWidgetDemoEntryView : View {
    var entry: Provider.Entry

    var body: some View {
       HStack {
            VStack(alignment: .leading, spacing: 15) {
                Image("duo")
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
}

@main
struct RNWidgetDemo: Widget {
    let kind: String = "RNWidgetDemo"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            RNWidgetDemoEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct RNWidgetDemo_Previews: PreviewProvider {
    static var previews: some View {
        RNWidgetDemoEntryView(entry: Entry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
