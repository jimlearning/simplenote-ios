import XCTest

let notExpectedEnding = " is NOT as expected",
    notFoundEnding = " NOT found",
    notAbsentEnding = " NOT absent"

let inAllNotesEnding = " in \"All Notes\"",
    inTrashEnding = " in \"Trash\"",
    inEditorEnding = " in Note Editor",
    inNotePreviewEnding = " in Note Preview",
    inWebViewEnding = " in WebView"

let checkboxNotFound = " checkbox" + notFoundEnding,
    checkboxNotAbsent = " checkbox" + notAbsentEnding,
    textViewNotFound = " TextView" + notFoundEnding,
    buttonNotFound = " button" + notFoundEnding,
    labelNotFound = " label" + notFoundEnding,
    labelNotAbsent = " label" + notAbsentEnding

let alertHeadingNotFound = " alert heading" + notFoundEnding,
    alertContentNotFound = " alert content" + notFoundEnding,
    alertButtonNotFound = " alert button" + notFoundEnding

let navBarNotFound = " navigation bar" + notFoundEnding,
    imageNotFound = " image" + notFoundEnding

let noteNotFoundInAllNotes = "\" Note" + notFoundEnding + inAllNotesEnding,
    noteNotAbsentInAllNotes = " Note" + notAbsentEnding + inAllNotesEnding,
    noteNotFoundInTrash = " Note" + notFoundEnding + inTrashEnding,
    noteNotAbsentInTrash = " Note" + notAbsentEnding + inTrashEnding

let numberOfNotesInAllNotesNotExpected = "Notes Number" + inAllNotesEnding + notExpectedEnding,
    numberOfNotesInTrashNotExpected = "Notes Number" + inTrashEnding + notExpectedEnding

let linkContainerNotFoundInEditor = "\" link container" + notFoundEnding + inEditorEnding,
    linkNotFoundInEditor = "\" link" + notFoundEnding + inEditorEnding,
    linkNotFoundInPreview = "\" link" + notFoundEnding + inNotePreviewEnding

let textNotFoundInEditor = "\" text" + notFoundEnding + inEditorEnding,
    textNotFoundInPreview = "\" text" + notFoundEnding + inNotePreviewEnding,
    textNotFoundInWebView = "\" text" + notFoundEnding + inWebViewEnding

let numberOfBoxesInPreviewNotExpected = "Boxes number" + inNotePreviewEnding + notExpectedEnding,
    numberOfCheckedBoxesInPreviewNotExpected = "Checked boxes number" + inNotePreviewEnding + notExpectedEnding,
    numberOfEmptyBoxesInPreviewNotExpected = "Empty boxes number" + inNotePreviewEnding + notExpectedEnding

let checkboxFoundMoreThanOnce = "Checkbox found more than once"

let maxLoadTimeout = 20.0,
    minLoadTimeout = 1.0

class Assert {

    class func labelExists(labelText: String) {
        XCTAssertTrue(app.staticTexts[labelText].waitForExistence(timeout: minLoadTimeout), labelText + labelNotFound)
    }

    class func labelAbsent(labelText: String) {
        XCTAssertFalse(app.staticTexts[labelText].waitForExistence(timeout: minLoadTimeout), labelText + labelNotAbsent)
    }

    class func alertExistsAndClose(headingText: String, content: String, buttonText: String) {
        let alert = app.alerts[headingText]
        let alertHeadingExists = alert.waitForExistence(timeout: maxLoadTimeout)

        XCTAssertTrue(alertHeadingExists, headingText + alertHeadingNotFound)

        if alertHeadingExists {
            XCTAssertTrue(alert.staticTexts[content].waitForExistence(timeout: minLoadTimeout), content + alertContentNotFound)
            XCTAssertTrue(alert.buttons[buttonText].waitForExistence(timeout: minLoadTimeout), buttonText + alertButtonNotFound)
        }

        alert.buttons[buttonText].tap()
    }

    class func signUpLogInScreenShown() {
        XCTAssertTrue(app.images[uidPicture_AppLogo].waitForExistence(timeout: minLoadTimeout), uidPicture_AppLogo + imageNotFound)
        XCTAssertTrue(app.staticTexts[text_AppName].waitForExistence(timeout: minLoadTimeout), text_AppName + labelNotFound)
        XCTAssertTrue(app.staticTexts[text_AppTagline].waitForExistence(timeout: minLoadTimeout), text_AppTagline + labelNotFound)
        XCTAssertTrue(app.buttons[uidButton_SignUp].waitForExistence(timeout: minLoadTimeout), uidButton_SignUp + buttonNotFound)
        XCTAssertTrue(app.buttons[uidButton_LogIn].waitForExistence(timeout: minLoadTimeout), uidButton_LogIn + buttonNotFound)
    }
}