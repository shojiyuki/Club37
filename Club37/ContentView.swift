import SwiftUI

struct ContentView: View {
    let items: [ListItem] = sampleListItems
    
    @State private var currentIndex: Int = 0
    @State private var isImagePickerPresented = false
    @State private var capturedImage: UIImage?
    @State private var showImagePreview = false
    
    var body: some View {
        VStack {
            CountdownWrapperView(selectedItemTime: items[currentIndex].time) { isCheckInAllowed, timeRemaining in
                VStack {
                    HeaderView(timeRemaining: .constant(timeRemaining), isCheckInAllowed: .constant(isCheckInAllowed))
                    
                    Spacer()
                    ListItemView(items: items, currentIndex: $currentIndex)
                    Spacer()
                    
                    if isCheckInAllowed {
                        CheckInButton() {
                            isImagePickerPresented = true
                        }
                        .padding(.bottom, 30)
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePickerView(isPresented: $isImagePickerPresented, selectedImage: $capturedImage)
                        }
                        .fullScreenCover(isPresented: $showImagePreview) {
                            ImagePreviewView(image: $capturedImage, isImagePickerPresented: $isImagePickerPresented)
                        }
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
            .id(currentIndex)  // ここで CountdownWrapperView を currentIndex の変更に応じて再生成する
        }
        .onChange(of: capturedImage) { oldValue, newValue in
            if capturedImage != nil {
                showImagePreview = true
            }
        }
    }
}

#Preview {
    ContentView()
}
