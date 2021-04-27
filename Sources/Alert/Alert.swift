import UIKit

open class Alert {

    public typealias Completion = () -> Void
    public typealias Handler = (UIAlertAction, Int) -> Void

    let alertController: UIAlertController
    var handler: Handler?
    
    static public func actionSheet(_ config: Configurator) -> Alert {
        let controller = UIAlertController(title: config.title, message: config.message, preferredStyle: .actionSheet)
        controller.view.tintColor = config.tintColor
       return Alert(alertController: controller)
    }
    
    static public func alert(_ config: Configurator) -> Alert {
        let controller = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
        controller.view.tintColor = config.tintColor
       return Alert(alertController: controller)
    }
    
    private init(alertController: UIAlertController) {
        self.alertController = alertController
    }
    
    public func actions(_ actions: [Action]) -> Alert {
       _ = actions.compactMap { action($0) }
        return self
    }
    
    public func actions(_ actions: [String]) -> Alert {
        _ = actions.compactMap { action(DefaultAction($0)) }
        return self
    }
    
    public func action(_ action: Action, handler: Completion? = nil) -> Alert {
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

private extension Alert.Action {

    func createAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        return UIAlertAction(title: self.title, style: self.style, handler: { handler($0) })
    }
}
