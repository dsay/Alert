import UIKit

extension Alert {
    
    open class Action {
        
        open var title: String?
        internal var style: UIAlertAction.Style
        
        internal init(_ title: String? = nil, style: UIAlertAction.Style) {
            self.title = title
            self.style = style
        }
    }
    
    open class DefaultAction: Action {
        
        public init(_ title: String? = nil) {
            super.init(title, style: .default)
        }
    }
    
    open class DestructiveAction: Action {
        
        public init(_ title: String? = nil) {
            super.init(title, style: .destructive)
        }
    }
    
    open class CancelAction: Action {
        
        public init(_ title: String? = nil) {
            super.init(title, style: .cancel)
        }
    }
}
