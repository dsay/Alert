import XCTest
@testable import Alert

struct Config: AlertConfigurator {
    var title: String? = "Title"
    var message: String? = "Message"
    var tintColor: UIColor? = UIColor.red
}

final class AlertTests: XCTestCase {
    
    func testActionSheet() {
        let config = Config()
        let fd = Alert.actionSheet(config).action(.cancel("Cancel"))
        
        XCTAssertEqual(fd.alertController.title, config.title)
        XCTAssertEqual(fd.alertController.message, config.message)
    }
    
    func testAlert() {
        let config = Config()
        let fd = Alert.alert(config).action(.cancel("Cancel"))
        
        XCTAssertEqual(fd.alertController.title, config.title)
        XCTAssertEqual(fd.alertController.message, config.message)
    }
    
    func testActionCancel() {
        let config = Config()
        let fd = Alert.alert(config).action(.cancel("Cancel"))
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Cancel")
            XCTAssertEqual(action.style, .cancel)
        } else {
            XCTFail()
        }
    }
    
    func testActionDefault() {
        let config = Config()
        let fd = Alert.alert(config).action(.default("Default"))
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Default")
            XCTAssertEqual(action.style, .default)
        } else {
            XCTFail()
        }
    }
    
    func testActionDestructive() {
        let config = Config()
        let fd = Alert.alert(config).action(.destructive("Destructive"))
        
        if let action = fd.alertController.actions.last {
            XCTAssertEqual(action.title, "Destructive")
            XCTAssertEqual(action.style, .destructive)
        } else {
            XCTFail()
        }
    }

    func testAction() {
        let config = Config()
        let fd = Alert.alert(config).actions(["Default"])
        
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
