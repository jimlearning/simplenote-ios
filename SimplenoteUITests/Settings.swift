import XCTest

let screenName = "Settings"

enum SettingsScreen: String {

    case doneButton = "Done"
    case condensedModeSwitch = "Condensed Note List"

    var element: XCUIElement {
        switch self {
        case .doneButton:
            return app.navigationBars[screenName].buttons[self.rawValue]
        case .condensedModeSwitch:
            return app.tables.cells.containing(.staticText, identifier: self.rawValue).firstMatch
        }
    }
}

class Settings {
    class func condensedModeEnable() {
        let condensedModeSwitch = SettingsScreen.condensedModeSwitch.element
        let switchValue = condensedModeSwitch.value as? String

        if switchValue == "0" {
            condensedModeSwitch.tap()
        }
    }

    class func condensedModeDisable() {
        let condensedModeSwitch = SettingsScreen.condensedModeSwitch.element
        let switchValue = condensedModeSwitch.value as? String

        if switchValue == "1" {
            condensedModeSwitch.tap()
        }
    }

    class func close() {
        SettingsScreen.doneButton.element.tap()
    }

    class func open() {
        Sidebar.open()
        Sidebar.getButtonSettings().tap()
    }
}
