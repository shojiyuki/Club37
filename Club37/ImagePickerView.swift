import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true) // モーダルでないので直接は閉じないが、念のため
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
#if targetEnvironment(simulator)
        // シミュレーターの場合はカスタムのViewControllerで固定画像を選択
        let fixedImageViewController = UIViewController()
        let imageView = UIImageView(image: UIImage(systemName: "photo")) // 固定の画像を設定
        imageView.contentMode = .scaleAspectFit
        imageView.frame = fixedImageViewController.view.frame
        fixedImageViewController.view.addSubview(imageView)
        
        // シミュレーターの場合は直接画像を選択する動作にする
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.selectedImage = UIImage(systemName: "photo") // 固定の画像を設定
        }
        return fixedImageViewController
        
#else
        // 実機ではカメラを使用
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
#endif
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Do nothing
    }
}
