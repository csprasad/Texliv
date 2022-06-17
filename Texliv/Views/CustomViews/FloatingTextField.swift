//
//  FloatingTextField.swift
//  Texliv
//
//  Created by CSPrasad on 10/06/22.
//

import UIKit

private extension TimeInterval {
    static let animation250ms: TimeInterval = 0.25
}

private extension UIColor {
    static let inactive: UIColor = .lightGray
    //UIColor(red: 146.0, green: 145.0, blue: 171.0, alpha: 1.0)
    
    
    static let active: UIColor = .darkGray
    //UIColor(red: 57.0, green: 62.0, blue: 70.0, alpha: 1.0)
}

private enum Constants {
    static let offset: CGFloat = 8
    static let placeholderSize: CGFloat = 14
}

final class FloatingTextField: UITextField {

    // MARK: - Subviews

    private var border = UIView()
    private var label = UILabel()

    // MARK: - Private Properties

    private var scale: CGFloat {
        Constants.placeholderSize / fontSize
    }

    private var fontSize: CGFloat {
       font?.pointSize ?? 0
    }

    private var labelHeight: CGFloat {
        ceil(font?.withSize(Constants.placeholderSize).lineHeight ?? 0)
    }

    private var textHeight: CGFloat {
        ceil(font?.lineHeight ?? 0)
    }

    private var isEmpty: Bool {
        text?.isEmpty ?? true
    }

    private var textInsets: UIEdgeInsets {
        UIEdgeInsets(top: Constants.offset + labelHeight, left: 0, bottom: Constants.offset, right: 0)
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UITextField

    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textInsets.top + textHeight + textInsets.bottom)
    }

    override var placeholder: String? {
        didSet {
            label.text = placeholder
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        updateLabel(animated: false)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard !isFirstResponder else {
            return
        }

        label.transform = .identity
        label.frame = bounds.inset(by: textInsets)
    }

    // MARK: - Private Methods

    ///customising UI
    private func setupUI() {
        borderStyle = .none

        border.backgroundColor = .inactive
        border.isUserInteractionEnabled = false
        addSubview(border)

        label.textColor = .inactive
        label.font = font
        label.text = placeholder
        label.isUserInteractionEnabled = false
        addSubview(label)

        addTarget(self, action: #selector(handleEditing), for: .allEditingEvents)
    }

    @objc
    private func handleEditing() {
        updateLabel()
        updateBorder()
    }

    private func updateBorder() {
        let borderColor = isValidEmail(self.text ?? "") ? UIColor.active : .inactive
        UIView.animate(withDuration: .animation250ms) {
            self.border.backgroundColor = borderColor
            self.label.textColor = borderColor
        }
    }
    
    ///check if email is valid
    func isValid() -> Bool {
        return isValidEmail(self.text ?? "")
    }

    private func updateLabel(animated: Bool = true) {
        let isActive = isValidEmail(self.text ?? "") || !isEmpty
       _ = isValid()
        //isFirstResponder

        let offsetX = -label.bounds.width * (1 - scale) / 2
        let offsetY = -label.bounds.height * (1 - scale) / 2

        let transform = CGAffineTransform(translationX: offsetX, y: offsetY - labelHeight - Constants.offset)
            .scaledBy(x: scale, y: scale)

        guard animated else {
            label.transform = isActive ? transform : .identity
            return
        }
        
        UIView.animate(withDuration: .animation250ms) {
            self.label.transform = isActive ? transform : .identity
        }
    }
    
    ///checking if email is valid input. regix code
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
