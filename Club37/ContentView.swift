import SwiftUI
import UIKit

struct ContentView: View {
    let items: [ListItem] = sampleListItems
    @State private var isImagePickerPresented = false
    @State private var capturedImage: UIImage?

    var body: some View {
        VStack {
            Spacer()
            ListItemView(items: items)
            Spacer()
            // Check-inボタン
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
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}
