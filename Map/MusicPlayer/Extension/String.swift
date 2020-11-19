
import UIKit


extension String {
    
    func validateEmail() -> Bool {
        // 偵測使用者打字的格式, 符不符合客製化的要求
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)

    }
}
