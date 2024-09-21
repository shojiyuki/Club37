import SwiftUI
import UIKit

struct ImagePreviewView: View {
    @Binding var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("No Image Available")
                    .foregroundColor(.white)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle("Image Preview")
    }
}

#Preview {
    ImagePreviewView(image: .constant(nil))
}
