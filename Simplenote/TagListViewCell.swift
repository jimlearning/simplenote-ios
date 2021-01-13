import UIKit

// MARK: - TagListViewCellDelegate
//
protocol TagListViewCellDelegate: class {
    func tagListViewCellShouldDeleteTag(_ cell: TagListViewCell)
    func tagListViewCellShouldRenameTag(_ cell: TagListViewCell)
}

// MARK: - TagListViewCell
//
class TagListViewCell: UITableViewCell {
    @IBOutlet private(set) var textField: UITextField!
    @IBOutlet private var trashButton: UIButton!

    /// Delegate
    ///
    weak var delegate: TagListViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        refreshStyle()

        // Don't use textField as an accessibility element.
        // Instead use textField value as a cell accessibility label.
        textField.isAccessibilityElement = false
    }

    override var accessibilityLabel: String? {
        get {
            return textField.text
        }
        set {
            //
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        refreshStyle()
        reset()
    }

    override func willTransition(to state: UITableViewCell.StateMask) {
        super.willTransition(to: state)
        if state.isEmpty {
            textField.resignFirstResponder()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        let changesBlock = {
            self.trashButton.isHidden = !editing
            self.trashButton.alpha = editing ? UIKitConstants.alpha1_0 : UIKitConstants.alpha0_0
        }

        if animated {
            let stackView = self.trashButton?.superview

            UIView.animate(withDuration: UIKitConstants.animationShortDuration) {
                changesBlock()
                stackView?.layoutIfNeeded()
            }
        } else {
            changesBlock()
        }
    }
}

// MARK: - Private
//
private extension TagListViewCell {
    func reset() {
        accessoryType = .none
        textField.delegate = nil
        textField.isEnabled = false
        delegate = nil
    }

    func refreshStyle() {
        refreshCellStyle()
        refreshSelectionStyle()
        refreshComponentsStyle()
    }

    func refreshCellStyle() {
        backgroundColor = .simplenoteBackgroundColor
    }

    func refreshSelectionStyle() {
        let selectedView = UIView()
        selectedView.backgroundColor = .simplenoteLightBlueColor
        selectedBackgroundView = selectedView
    }

    func refreshComponentsStyle() {
        textField.textColor = .simplenoteTextColor
        trashButton.tintColor = .simplenoteTintColor
    }
}

// MARK: - Actions
//
extension TagListViewCell {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(rename(_:)) || action == #selector(delete(_:))) && !textField.isEditing
    }

    @objc
    override func delete(_ sender: Any?) {
        delegate?.tagListViewCellShouldDeleteTag(self)
    }

    @objc
    private func rename(_ sender: Any?) {
        delegate?.tagListViewCellShouldRenameTag(self)
    }

    @IBAction private func handleTapOnTrashButton() {
        delegate?.tagListViewCellShouldDeleteTag(self)
    }
}
