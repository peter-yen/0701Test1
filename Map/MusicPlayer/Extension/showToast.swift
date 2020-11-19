import UIKit
import Toast_Swift


extension UIView {
    func showToast(text: String) {
        var style = ToastStyle()
        style.messageFont = UIFont.systemFont(ofSize: 20)
        ToastManager.shared.style = style
        self.makeToast(text, duration: 1.5, position: .top)
    }
}
