//
//  BookChallengeWidget.swift
//  BookChallengeWidget
//
//  Created by 박성민 on 10/22/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct BookChallengeWidgetEntryView : View {
    var entry: Provider.Entry
    let image = UserDefaults(suiteName: "group.com.Sixteenis.BookChallenge.min")?.data(forKey: "widgetImage")
    let percent = UserDefaults(suiteName: "group.com.Sixteenis.BookChallenge.min")?.double(forKey: "widgetPagePercent") ?? 0.0
    let day = UserDefaults(suiteName: "group.com.Sixteenis.BookChallenge.min")?.string(forKey: "widgetDay") ?? ""
    var body: some View {
        let _ = print(percent)
        let _ = print(day)
        HStack(spacing: 0) {
            if let imageData = image,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)  // UIImage를 SwiftUI Image로 변환
                    .resizable()
                    .frame(width: 65, height: 115)
                    .cornerRadius(10)
            } else {
                Image("noBook")  // 기본 이미지
                    .resizable()
                    .frame(width: 65, height: 115)
                    .cornerRadius(10)
            }
            Spacer()
            VStack {
                Spacer()
                    .frame(height: 2)
                Text("D-\(day)")
                    .font(.headline)
                    .lineLimit(1)
                BatteryView(percent: percent)
                    .overlay {
                        Text("\(Int(percent*100))%")
                    }
                Spacer()
                
                
            }
            
        }
    }
}

struct BookChallengeWidget: Widget {
    let kind: String = "BookChallengeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                BookChallengeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                BookChallengeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    BookChallengeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
struct BatteryView: View {
    let percent: Double
    init(percent: Double) {
        self.percent = percent
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 2) { // HStack에서 VStack으로 변경
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .frame(width: geo.size.width/2, height: 4)
                
                GeometryReader { rectangle in
                    ZStack(alignment: .bottom) { // alignment를 bottom으로 변경
                        // 배터리 외곽선
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                        
                        // 배터리 잔량
                        RoundedRectangle(cornerRadius: 15)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 3)
                            .frame(height: rectangle.size.height - (rectangle.size.height * (1.0 - percent)))
                            .foregroundColor(Color.BatteryLevel(percent))
                    }
                }
            }
            .padding(.top, 5) // .leading 대신 .top으로 변경
        }
    }
}

extension Color {
    static func BatteryLevel(_ percent: Double) -> Color {
        switch percent {
            // returns red color for range %0 to %20
        case 0...0.2:
            return Color.red
            // returns yellow color for range %20 to %50
        case 0.2...0.5:
            return Color.yellow
            // returns green color for range %50 to %100
        case 0.5...1.0:
            return Color.green
        default:
            return Color.clear
        }
    }
}
