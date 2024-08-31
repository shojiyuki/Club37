import Foundation

enum DateFormat: String {
    case full = "yyyy/MM/dd HH:mm"
    case detailed = "dd-MM-yyyy HH:mm:ss"
    case short = "MMM d, yyyy"
}

struct DateFormatterUtil {
    static func string(from date: Date, format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
    static func date(from string: String, format: DateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: string)
    }
}
