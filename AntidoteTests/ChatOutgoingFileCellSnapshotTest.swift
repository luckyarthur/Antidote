// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import MobileCoreServices

class ChatOutgoingFileCellSnapshotTest: CellSnapshotTest {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    func testWaitingState() {
        let model = ChatOutgoingFileCellModel()
        model.state = .WaitingConfirmation
        model.fileName = "file.txt"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePlainText as String

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testLoading() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Loading
        model.fileName = "file.txt"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePlainText as String

        let progressObject = MockedChatProgressProtocol()

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.progressObject = progressObject

        progressObject.updateProgress?(progress: 0.43)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testPaused() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Paused
        model.fileName = "file.txt"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePlainText as String

        let progressObject = MockedChatProgressProtocol()

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.progressObject = progressObject

        progressObject.updateProgress?(progress: 0.43)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testCancelled() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Cancelled
        model.fileName = "file.txt"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePlainText as String

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testDone() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Done
        model.fileName = "file.txt"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePlainText as String

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testWaitingStateWithImage() {
        let model = ChatOutgoingFileCellModel()
        model.state = .WaitingConfirmation
        model.fileName = "icon.png"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePNG as String

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.setButtonImage(image)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testLoadingWithImage() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Loading
        model.fileName = "icon.png"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePNG as String

        let progressObject = MockedChatProgressProtocol()

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.progressObject = progressObject
        cell.setButtonImage(image)

        progressObject.updateProgress?(progress: 0.43)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testPausedWithImage() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Paused
        model.fileName = "icon.png"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePNG as String

        let progressObject = MockedChatProgressProtocol()

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.progressObject = progressObject
        cell.setButtonImage(image)

        progressObject.updateProgress?(progress: 0.43)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testCancelledWithImage() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Cancelled
        model.fileName = "icon.png"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePNG as String

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.setButtonImage(image)

        updateCellLayout(cell)
        verifyView(cell)
    }

    func testDoneWithImage() {
        let model = ChatOutgoingFileCellModel()
        model.state = .Done
        model.fileName = "icon.png"
        model.fileSize = "3.14 KB"
        model.fileUTI = kUTTypePNG as String

        let cell = ChatOutgoingFileCell()
        cell.setupWithTheme(theme, model: model)
        cell.setButtonImage(image)

        updateCellLayout(cell)
        verifyView(cell)
    }
}
