import SwiftUI

struct CheckInButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
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
    }
}

#Preview {
    CheckInButton() {
        print("Button tapped!")
    }
}
