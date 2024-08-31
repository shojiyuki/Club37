import SwiftUI

struct CountdownWrapperView<Content: View>: View {
    let selectedItemTime: Date
    let content: (Bool, String) -> Content
    
    @State private var isCheckInAllowed: Bool = false
    @State private var timeRemaining: String = ""
    
    var body: some View {
        content(isCheckInAllowed, timeRemaining)
            .onAppear {
                updateCheckInAllowed()
                startTimerIfNeeded()
            }
    }
    
    func updateCheckInAllowed() {
        isCheckInAllowed = isItemTimeWithin37MinutesOfCurrentTime()
    }
    
    func isItemTimeWithin37MinutesOfCurrentTime() -> Bool {
        let currentTime = Date()
        let timeInterval: TimeInterval = TimeInterval(Constants.minute37) * 60 // 37分を秒に変換
        let timeThreshold = currentTime.addingTimeInterval(-timeInterval)
        
        return selectedItemTime >= timeThreshold && selectedItemTime <= currentTime
    }
    
    func startTimerIfNeeded() {
        if isCheckInAllowed {
            startTimer()
        } else {
            timeRemaining = "" // チェックイン不可のときにカウントダウンをリセット
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let endTime = selectedItemTime.addingTimeInterval(TimeInterval(Constants.minute37) * 60)
            let currentTime = Date()
            let remainingTime = endTime.timeIntervalSince(currentTime)
            
            if remainingTime <= 0 {
                timer.invalidate()
                timeRemaining = ""
                isCheckInAllowed = false
            } else {
                timeRemaining = TimeIntervalFormatterUtil.formatToMinutesAndSeconds(remainingTime)
            }
        }
    }
}

#Preview {
    CountdownWrapperView(selectedItemTime: Date()) { isCheckInAllowed, timeRemaining in
        Text("This is a preview")
            .foregroundColor(isCheckInAllowed ? .green : .red)
            .overlay(Text(timeRemaining))
    }
}
