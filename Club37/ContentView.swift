import SwiftUI
import UIKit

struct ContentView: View {
    let items: [ListItem] = sampleListItems
    @State private var currentIndex: Int = 0
    @State private var isImagePickerPresented = false
    @State private var capturedImage: UIImage?
    @State private var isCheckInAllowed: Bool = false
    @State private var showHeaderTime: Bool = false

    var body: some View {
        VStack {
            HeaderView(showTime: $showHeaderTime)

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
            let isAllowed = isItemTimeWithin37MinutesOfCurrentTime(selectedItemTime: items[currentIndex].time)
            isCheckInAllowed = isAllowed
            showHeaderTime = isAllowed
        }
        .onChange(of: currentIndex) { oldValue, newValue in
            let isAllowed = isItemTimeWithin37MinutesOfCurrentTime(selectedItemTime: items[newValue].time)
            isCheckInAllowed = isAllowed
            showHeaderTime = isAllowed
        }
    }
    
    func isItemTimeWithin37MinutesOfCurrentTime(selectedItemTime: Date) -> Bool {
        let currentTime = Date()
        let timeInterval: TimeInterval = TimeInterval(Constants.minute37) * 60 // 37分を秒に変換
        let timeThreshold = currentTime.addingTimeInterval(-timeInterval)
        
        print("現在時刻: \(currentTime)")
        print("アイテムの時間: \(selectedItemTime)")
        
        return selectedItemTime >= timeThreshold && selectedItemTime <= currentTime
    }
}

#Preview {
    ContentView()
}
