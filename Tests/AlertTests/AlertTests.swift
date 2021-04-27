import XCTest
@testable import Alert

extension Alert.Action  {

    static var cancel = Alert.CancelAction("Cancel")
    static var `default` = Alert.DefaultAction("Default")
    static var destructive = Alert.DestructiveAction("Destructive")
}

extension Alert.Configurator {
   
    static var config = Alert.Configurator(title: "Title", message: "Message", tintColor: .red)
}

final class AlertTests: XCTestCase {
    
    func testActionSheet() {
        let config: Alert.Configurator = .config
        let fd = Alert.actionSheet(config).action(.cancel)
        
        XCTAssertEqual(fd.alertController.title, config.title)
        XCTAssertEqual(fd.alertController.message, config.message)
        XCTAssertEqual(fd.alertController.view.tintColor, config.tintColor)
    }
    
    func testAlert() {
        let config: Alert.Configurator = .config
        let fd = Alert.alert(config).action(.cancel)
        
        XCTAssertEqual(fd.alertController.title, config.title)
        XCTAssertEqual(fd.alertController.message, config.message)
        XCTAssertEqual(fd.alertController.view.tintColor, config.tintColor)
    }
    
    func testActionCancel() {
        let fd = Alert.alert(.config).action(.cancel)
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Cancel")
            XCTAssertEqual(action.style, .cancel)
        } else {
            XCTFail()
        }
    }
    
    func testActionDefault() {
        let fd = Alert.alert(.config).action(.default)
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Default")
            XCTAssertEqual(action.style, .default)
        } else {
            XCTFail()
        }
    }
    
    func testActionDestructive() {
        let fd = Alert.alert(.config).action(.destructive)
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Destructive")
            XCTAssertEqual(action.style, .destructive)
        } else {
            XCTFail()
        }
    }

    func testAction() {
        let fd = Alert.alert(.config).actions(["Default"])
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Default")
            XCTAssertEqual(action.style, .default)
        } else {
            XCTFail()
        }
    }
    
    static var allTests = [
        ("testActionSheet", testActionSheet),
        ("testAlert", testAlert),
        ("testActionCancel", testActionCancel),
        ("testActionDefault", testActionDefault),
        ("testActionDestructive", testActionDestructive),
        ("testAction", testAction),
    ]
}
