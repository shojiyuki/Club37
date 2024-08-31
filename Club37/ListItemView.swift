import SwiftUI

struct ListItemView: View {
    let items: [ListItem]
    @Binding var currentIndex: Int  // Bindingとして渡す
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(items.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 16) {
                        // 上のスタイリッシュな線
                        Capsule() // 丸みを帯びた線
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.7), Color.white]), startPoint: .leading, endPoint: .trailing)) // グラデーションをかける
                            .frame(height: 4)
                            .padding(.horizontal, 0) // 横幅いっぱいにする

                        HStack {
                            Image(systemName: "location.circle.fill")
                                .foregroundColor(.white)
                            Text(items[index].location)
                                .font(.title)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Divider()
                            .background(Color.white)
                            .frame(height: 1)
                            .overlay(
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))  // 点線スタイル
                                    .foregroundColor(.white)
                            )
                        
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.white)
                            Text(DateFormatterUtil.string(from: items[index].time, format: DateFormat.full))
                                .font(.title)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Divider()
                            .background(Color.white)
                            .frame(height: 1)
                            .overlay(
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))  // 点線スタイル
                                    .foregroundColor(.white)
                            )
                        
                        HStack {
                            Image(systemName: "briefcase.fill")
                                .foregroundColor(.white)
                            Text(items[index].item)
                                .font(.title)
                                .foregroundColor(.white)
                            Spacer()
                        }

                        // 下のスタイリッシュな線
                        Capsule() // 丸みを帯びた線
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)) // グラデーションをかける
                            .frame(height: 4)
                            .padding(.horizontal, 0) // 横幅いっぱいにする
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, maxHeight: 220)  // 高さ制限
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(maxWidth: .infinity, maxHeight: 300)  // TabView自体のサイズを制限
        }
        .background(Color.black)
    }
}

#Preview {
    ListItemView(items: sampleListItems, currentIndex: .constant(0))
}
