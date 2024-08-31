import SwiftUI
import UIKit

struct ImagePreviewView: View {
    @Binding var image: UIImage?
    @Binding var isImagePickerPresented: Bool
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
            } else {
                Text("No Image Available")
                    .foregroundColor(.white)
            }
            
            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Retake")
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
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ImagePreviewView(image: .constant(nil), isImagePickerPresented: .constant(false))
}
