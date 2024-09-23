import SwiftUI

struct ContentView: View {
    let items: [ListItem] = sampleListItems
    
    @State private var currentIndex: Int = 0
    @State private var capturedImage: UIImage?
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                CountdownWrapperView(selectedItemTime: items[currentIndex].time) { isCheckInAllowed, timeRemaining in
                    VStack {
                        HeaderView(timeRemaining: .constant(timeRemaining), isCheckInAllowed: .constant(isCheckInAllowed))
                        
                        Spacer()
                        ListItemView(items: items, currentIndex: $currentIndex)
                        Spacer()
                        
                        if isCheckInAllowed {
                            CheckInButton {
                                path.append("ImagePicker")  // 識別子を追加して遷移を制御
                            }
                            .padding(.bottom, 30)
                        }
                    }
                    .background(Color.black.edgesIgnoringSafeArea(.all))
                }
                .id(currentIndex)  // currentIndex の変更に応じて再生成
            }
            .navigationDestination(for: String.self) { view in  // 識別子に基づいた遷移を定義
                if view == "ImagePicker" {
                    ImagePickerView(selectedImage: $capturedImage)
                        .onChange(of: capturedImage) {
                            if capturedImage != nil {
                                path.append("ImagePreview")
                            }
                        }
                } else if view == "ImagePreview" {
                    // ImagePreviewViewに現在のselectedItemTimeを渡す
                    ImagePreviewView(image: $capturedImage, selectedItemTime: items[currentIndex].time)
                }
            }
        }
    }
}
