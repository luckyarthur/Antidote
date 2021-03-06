// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import UIKit
import SnapKit

private struct Constants {
    static let ButtonSize = 40.0
    static let VerticalOffset = 8.0
}

class StaticTableChatButtonsCell: StaticTableBaseCell {
    private var chatButton: UIButton!
    private var callButton: UIButton!
    private var videoButton: UIButton!

    private var separators: [UIView]!

    private var chatButtonHandler: (Void -> Void)?
    private var callButtonHandler: (Void -> Void)?
    private var videoButtonHandler: (Void -> Void)?

    override func setupWithTheme(theme: Theme, model: BaseCellModel) {
        super.setupWithTheme(theme, model: model)

        guard let buttonsModel = model as? StaticTableChatButtonsCellModel else {
            assert(false, "Wrong model \(model) passed to cell \(self)")
            return
        }

        selectionStyle = .None

        chatButtonHandler = buttonsModel.chatButtonHandler
        callButtonHandler = buttonsModel.callButtonHandler
        videoButtonHandler = buttonsModel.videoButtonHandler

        chatButton.enabled = buttonsModel.chatButtonEnabled
        callButton.enabled = buttonsModel.callButtonEnabled
        videoButton.enabled = buttonsModel.videoButtonEnabled
    }

    override func createViews() {
        super.createViews()

        chatButton = createButtonWithImageName("friend-card-chat", action: #selector(StaticTableChatButtonsCell.chatButtonPressed))
        callButton = createButtonWithImageName("start-call", action: #selector(StaticTableChatButtonsCell.callButtonPressed))
        videoButton = createButtonWithImageName("video-call", action: #selector(StaticTableChatButtonsCell.videoButtonPressed))

        separators = [UIView]()
        for _ in 0...3 {
            let sep = UIView()
            sep.backgroundColor = UIColor.clearColor()
            customContentView.addSubview(sep)
            separators.append(sep)
        }
    }

    override func installConstraints() {
        super.installConstraints()

        var previous: UIView? = nil
        for (index, sep) in separators.enumerate() {
            sep.snp_makeConstraints {
                if previous != nil {
                    $0.width.equalTo(previous!.snp_width)
                }

                if index == 0 {
                    $0.leading.equalTo(customContentView)
                }

                if index == (separators.count-1) {
                    $0.trailing.equalTo(customContentView)
                }
            }

            previous = sep
        }

        func installForButton(button: UIButton, index: Int) {
            button.snp_makeConstraints {
                $0.top.equalTo(customContentView).offset(Constants.VerticalOffset)
                $0.bottom.equalTo(customContentView).offset(-Constants.VerticalOffset)

                $0.leading.equalTo(separators[index].snp_trailing)
                $0.trailing.equalTo(separators[index+1].snp_leading)

                $0.size.equalTo(Constants.ButtonSize)
            }
        }

        installForButton(chatButton, index: 0)
        installForButton(callButton, index: 1)
        installForButton(videoButton, index: 2)
    }
}

extension StaticTableChatButtonsCell {
    func chatButtonPressed() {
        chatButtonHandler?()
    }

    func callButtonPressed() {
        callButtonHandler?()
    }

    func videoButtonPressed() {
        videoButtonHandler?()
    }
}

private extension StaticTableChatButtonsCell {
    func createButtonWithImageName(imageName: String, action: Selector) -> UIButton {
        let image = UIImage.templateNamed(imageName)

        let button = UIButton()
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        customContentView.addSubview(button)

        return button
    }
}
