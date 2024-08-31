import SwiftUI
import UIKit

struct ContentView: View {
    let items: [ListItem] = sampleListItems
    @State private var currentIndex: Int = 0
    @State private var isImagePickerPresented = false
    @State private var capturedImage: UIImage?
    @State private var isCheckInAllowed: Bool = false
    @State private var timeRemaining: String = ""
    
    var body: some View {
        VStack {
            HeaderView(timeRemaining: $timeRemaining, isCheckInAllowed: $isCheckInAllowed)
            
            Spacer()
            ListItemView(items: items, currentIndex: $currentIndex)
            Spacer()
            if isCheckInAllowed {
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("CHECK-IN")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .shadow(color: .white, radius: 10, x: 0, y: 0)
                        )
                }
                .padding(.bottom, 30)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(isPresented: $isImagePickerPresented, selectedImage: $capturedImage)
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            updateCheckInAllowed()
            startTimerIfNeeded()
        }
        .onChange(of: currentIndex) { oldValue, newValue in
            updateCheckInAllowed()
            startTimerIfNeeded()
        }
    }
    
    func updateCheckInAllowed() {
        isCheckInAllowed = isItemTimeWithin37MinutesOfCurrentTime(selectedItemTime: items[currentIndex].time)
    }
    
    func isItemTimeWithin37MinutesOfCurrentTime(selectedItemTime: Date) -> Bool {
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
            let selectedItemTime = items[currentIndex].time
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
    ContentView()
}
