// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import QuickLook

private class FilePreviewItem: NSObject, QLPreviewItem {
    @objc var previewItemURL: NSURL?
    @objc var previewItemTitle: String?

    init(url: NSURL, title: String?) {
        self.previewItemURL = url
        self.previewItemTitle = title
    }
}

class FilePreviewControllerDataSource: NSObject , QuickLookPreviewControllerDataSource {
    weak var previewController: QuickLookPreviewController?

    let messages: Results<OCTMessageAbstract>
    var messagesToken: RLMNotificationToken?

    init(chat: OCTChat, submanagerObjects: OCTSubmanagerObjects) {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "chatUniqueIdentifier == %@ AND messageFile != nil", chat.uniqueIdentifier),

            NSCompoundPredicate(orPredicateWithSubpredicates: [
                NSPredicate(format: "messageFile.fileType == \(OCTMessageFileType.Ready.rawValue)"),
                NSPredicate(format: "senderUniqueIdentifier == nil AND messageFile.fileType == \(OCTMessageFileType.Canceled.rawValue)"),
            ]),
        ])

        self.messages = submanagerObjects.messages(predicate: predicate).sortedResultsUsingProperty("dateInterval", ascending: true)

        super.init()

        messagesToken = messages.addNotificationBlock { [unowned self] change in
            switch change {
                case .Initial:
                    break
                case .Update:
                    self.previewController?.reloadData()
                case .Error(let error):
                fatalError("\(error)")
            }
        }
    }

    deinit {
        messagesToken?.stop()
    }

    func indexOfMessage(message: OCTMessageAbstract) -> Int? {
        return messages.indexOfObject(message)
    }
}

extension FilePreviewControllerDataSource: QLPreviewControllerDataSource {
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        return messages.count
    }

    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        let message = messages[index]

        let url = NSURL.fileURLWithPath(message.messageFile!.filePath()!)

        return FilePreviewItem(url: url, title: message.messageFile!.fileName)
    }
}
