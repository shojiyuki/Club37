import SwiftUI
import UIKit

struct ImagePreviewView: View {
    @Binding var image: UIImage?
    let selectedItemTime: Date  // selectedItemTimeを受け取る
    
    var body: some View {
        CountdownWrapperView(selectedItemTime: selectedItemTime) { isCheckInAllowed, timeRemaining in
            VStack {
                if isCheckInAllowed {
                    if let image = image {
                        HeaderView(timeRemaining: .constant(timeRemaining), isCheckInAllowed: .constant(isCheckInAllowed))
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        CheckInButton {
                        }
                        .padding(.bottom, 30)
                        
                    } else {
                        Text("No Image Available")
                            .foregroundColor(.white)
                    }
                } else {
                    Text("Check-in not allowed.")
                        .foregroundColor(.white)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("Image Preview")
        }
    }
}
