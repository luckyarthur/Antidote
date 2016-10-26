// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import UIKit

class CopyLabel: UILabel {
    var copyable = true {
        didSet {
            recognizer.enabled = copyable
        }
    }

    private var recognizer: UITapGestureRecognizer!

    override init(frame: CGRect) {
        super.init(frame: frame)

        userInteractionEnabled = true

        recognizer = UITapGestureRecognizer(target: self, action: #selector(CopyLabel.tapGesture))
        addGestureRecognizer(recognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Actions
extension CopyLabel {
    func tapGesture() {
        // This fixes issue with calling UIMenuController after UIActionSheet was presented.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.makeKeyWindow()

        becomeFirstResponder()

        let menu = UIMenuController.sharedMenuController()
        menu.setTargetRect(frame, inView: superview!)
        menu.setMenuVisible(true, animated: true)
    }
}

// MARK: Copying
extension CopyLabel {
    override func copy(sender: AnyObject?) {
        UIPasteboard.generalPasteboard().string = text
    }

    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return action == #selector(copy(_:))
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }
}
