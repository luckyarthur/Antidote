// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation

protocol SettingsAboutControllerDelegate: class {
    func settingsAboutControllerShowAcknowledgements(controller: SettingsAboutController)
}

class SettingsAboutController: StaticTableController {
    weak var delegate: SettingsAboutControllerDelegate?

    private let antidoteVersionModel = StaticTableInfoCellModel()
    private let antidoteBuildModel = StaticTableInfoCellModel()
    private let toxcoreVersionModel = StaticTableInfoCellModel()
    private let acknowledgementsModel = StaticTableDefaultCellModel()

    init(theme: Theme) {
        super.init(theme: theme, style: .Grouped, model: [
            [
                antidoteVersionModel,
                antidoteBuildModel,
            ],
            [
                toxcoreVersionModel,
            ],
            [
                acknowledgementsModel,
            ],
        ])

        title = String(localized: "settings_about")
        updateModels()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsAboutController {
    func updateModels() {
        antidoteVersionModel.title = String(localized: "settings_antidote_version")
        antidoteVersionModel.value =  NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String

        antidoteBuildModel.title = String(localized: "settings_antidote_build")
        antidoteBuildModel.value = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String

        toxcoreVersionModel.title = String(localized: "settings_toxcore_version")
        toxcoreVersionModel.value = OCTTox.version()

        acknowledgementsModel.value = String(localized: "settings_acknowledgements")
        acknowledgementsModel.didSelectHandler = showAcknowledgements
        acknowledgementsModel.rightImageType = .Arrow
    }

    func showAcknowledgements(_: StaticTableBaseCell) {
        delegate?.settingsAboutControllerShowAcknowledgements(self)
    }
}
