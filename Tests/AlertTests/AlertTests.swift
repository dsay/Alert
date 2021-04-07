import XCTest
@testable import Alert

extension AlertConfigurator {
    
    static var config: AlertConfigurator {
        AlertConfigurator(title: "Title", message: "Message", tintColor: .red)
    }
}

final class AlertTests: XCTestCase {
    
    func testActionSheet() {
        let config: AlertConfigurator = .config
        let fd = Alert.actionSheet(config).action(.cancel("Cancel"))
        
        XCTAssertEqual(fd.alertController.title, config.title)
        XCTAssertEqual(fd.alertController.message, config.message)
    }
    
    func testAlert() {
        let config: AlertConfigurator = .config
        let fd = Alert.alert(config).action(.cancel("Cancel"))
        
        XCTAssertEqual(fd.alertController.title, config.title)
        XCTAssertEqual(fd.alertController.message, config.message)
    }
    
    func testActionCancel() {
        let fd = Alert.alert(.config).action(.cancel("Cancel"))
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Cancel")
            XCTAssertEqual(action.style, .cancel)
        } else {
            XCTFail()
        }
    }
    
    func testActionDefault() {
        let fd = Alert.alert(.config).action(.default("Default"))
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Default")
            XCTAssertEqual(action.style, .default)
        } else {
            XCTFail()
        }
    }
    
    func testActionDestructive() {
        let fd = Alert.alert(.config).action(.destructive("Destructive"))
        
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
