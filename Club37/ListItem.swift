import Foundation

struct ListItem: Identifiable {
    let id: UUID
    let location: String
    let time: Date
    let item: String

    init(location: String, time: Date, item: String) {
        self.id = UUID()
        self.location = location
        self.time = time
        self.item = item
    }
}

