import UIKit

open class AlertConfigurator {
    
    var title: String?
    var message: String?
    var tintColor: UIColor?
    
    public init(title: String? = nil, message: String? = nil, tintColor: UIColor? = nil) {
        self.title = title
        self.message = message
        self.tintColor = tintColor
    }
}

public enum AlertAction {
    
    case cancel(String?)
    case destructive(String?)
    case `default`(String?)
}

open class Alert {

    public typealias Completion = () -> Void
    public typealias Handler = (UIAlertAction, Int) -> Void

    let alertController: UIAlertController
    var handler: Handler?
    
    static public func actionSheet(_ config: AlertConfigurator) -> Alert {
        let controller = UIAlertController(title: config.title, message: config.message, preferredStyle: .actionSheet)
        controller.view.tintColor = config.tintColor
       return Alert(alertController: controller)
    }
    
    static public func alert(_ config: AlertConfigurator) -> Alert {
        let controller = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
       return Alert(alertController: controller)
    }
    
    private init(alertController: UIAlertController) {
        self.alertController = alertController
    }
    
    public func actions(_ actions: [AlertAction]) -> Alert {
       _ = actions.compactMap { action($0) }
        return self
    }
    
    public func actions(_ actions: [String]) -> Alert {
        _ = actions.compactMap { action(.default($0)) }
        return self
    }
    
    public func action(_ action: AlertAction, handler: Completion? = nil) -> Alert {
        if let handler = handler {
            alertController.addAction(action.createAlertAction(handler: { _ in handler() }))
        } else {
            alertController.addAction(action.createAlertAction(handler: handlIndexedActionHandler(_:)))
        }
        return self
    }
    
    public func sink(_ handler: @escaping Handler) -> Alert {
        self.handler = handler
        return self
    }
    
    public func show(_ viewController: UIViewController, _ completion: Completion? = nil) {
        viewController.present(alertController, animated: true, completion: completion)
    }
    
    private func handlIndexedActionHandler(_ action: UIAlertAction) {
        let index = alertController.actions.firstIndex(of: action)
        handler?(action, index ?? 0)
    }
}

private extension AlertAction {

    func createAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        switch self {
        case .cancel(let title):
            return UIAlertAction(title: title, style: .cancel, handler: { handler($0) })
            
        case .default(let title):
            return UIAlertAction(title: title, style: .default, handler: { handler($0) })
            
        case .destructive(let title):
            return UIAlertAction(title: title, style: .destructive, handler: { handler($0) })
        }
    }
}
