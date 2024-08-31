import Foundation

// TODO リストのアイテムを設定する画面の作成。どんな形になる？別のアプリで作成してDBに保存するなどの形など？
let sampleListItems: [ListItem] = [
    ListItem(location: "YOYOGI PARK", time:DateFormatterUtil.date(from: "2024/08/31 15:50", format: DateFormat.full) ?? Date(), item: "白いTシャツ"),
    ListItem(location: "SHIBUYA", time:DateFormatterUtil.date(from: "2024/08/31 15:00", format: DateFormat.full) ?? Date(), item: "赤い帽子"),
    ListItem(location: "AKIHABARA", time:DateFormatterUtil.date(from: "2025/01/01 15:00", format: DateFormat.full) ?? Date(), item: "黒いカバン")
]
