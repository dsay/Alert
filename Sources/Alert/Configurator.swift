import UIKit

extension Alert {
    
    open class Configurator {
        
        var title: String?
        var message: String?
        var tintColor: UIColor?
        
        public init(title: String? = nil, message: String? = nil, tintColor: UIColor? = nil) {
            self.title = title
            self.message = message
            self.tintColor = tintColor
        }
    }
}
