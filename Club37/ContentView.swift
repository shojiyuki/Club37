import SwiftUI

struct ContentView: View {
    let items: [ListItem] = sampleListItems
    
    @State private var currentIndex: Int = 0
    @State private var capturedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                CountdownWrapperView(selectedItemTime: items[currentIndex].time) { isCheckInAllowed, timeRemaining in
                    VStack {
                        HeaderView(timeRemaining: .constant(timeRemaining), isCheckInAllowed: .constant(isCheckInAllowed))
                        
                        Spacer()
                        ListItemView(items: items, currentIndex: $currentIndex)
                        Spacer()
                        
                        if isCheckInAllowed {
                            NavigationLink(destination: ImagePickerView(selectedImage: $capturedImage)) {
                                CheckInButton {}
                                    .padding(.bottom, 30)
                            }
                        }
                    }
                    .background(Color.black.edgesIgnoringSafeArea(.all))
                }
                .id(currentIndex)  // ここで CountdownWrapperView を currentIndex の変更に応じて再生成する
            }
        }
    }
}

#Preview {
    ContentView()
}
