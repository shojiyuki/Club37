import SwiftUI

struct HeaderView: View {
    @Binding var timeRemaining: String
    @Binding var isCheckInAllowed: Bool

    var body: some View {
        ZStack {
            // 画面全体の中央に配置されるネオン風のテキスト
            if isCheckInAllowed { // isCheckInAllowedがtrueの場合のみ表示
                Text(timeRemaining)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
                    .shadow(color: .red.opacity(0.7), radius: 10, x: 0, y: 0)
                    .shadow(color: .red.opacity(0.5), radius: 20, x: 0, y: 0)
                    .shadow(color: .red.opacity(0.3), radius: 30, x: 0, y: 0)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                // カウントダウンが終わった時に表示されるテキスト（例：空白）
                Text("")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            HStack {
                Image("logo") // Assetsに追加した画像を使用
                    .resizable()  // サイズを変更可能にする
                    .scaledToFit()  // 画像のアスペクト比を維持しながらフィット
                    .frame(width: 70, height: 70)  // 画像サイズを指定
                    .padding(.leading, 10)
                
                Spacer() // 余白を追加してロゴを左寄せ
            }
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, maxHeight: 100)  // 高さを固定
        .background(Color.black)
    }
}

#Preview {
    HeaderView(timeRemaining: .constant("20:24"), isCheckInAllowed: .constant(true))
}
