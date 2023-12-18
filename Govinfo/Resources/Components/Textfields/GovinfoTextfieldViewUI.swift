//
//  GovinfoTextfieldView.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

enum GovinfoTextfieldCasing {
    case uppercased
    case lowercased
    case capitalized
    case defaultCasing
}

@objc internal protocol GovinfoTextfieldViewUIDelegate: AnyObject {
    @objc optional func govinfoTextfieldViewUITextChanged(textField: GovinfoTextfieldViewUI)
    @objc optional func govinfoTextfieldViewUIDone(textField: GovinfoTextfieldViewUI)
}

class GovinfoTextfieldViewUI: UITextField {
    weak var govinfoDelegate: GovinfoTextfieldViewUIDelegate?
    var identifier: String = ""
    private(set) var isTextValid: Bool = false
    var needTextValidation: Bool = true
    
    var govinfoPlaceholder: String = "" {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: govinfoPlaceholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.govinfoGray ?? UIColor.gray,
                             NSAttributedString.Key.font: UIFont.getComicFont(16)])
        }
    }
    
    internal var casing: GovinfoTextfieldCasing = .defaultCasing {
        didSet {
            textCasing()
        }
    }
    
    required init() {
        super.init(frame: .zero)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText() -> String {
        return text ?? ""
    }
}

extension GovinfoTextfieldViewUI {
    func initComponents() {
        delegate = self
        backgroundColor = .govinfoWhite
        addBorder()
        setTextfieldStatus(isDefault: true)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        rightViewMode = .always
        textColor = .govinfoBlack
        tintColor = .govinfoBlack
        font = UIFont.getComicFont(16)
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        returnKeyType = .done
        spellCheckingType = .no
        autocorrectionType = .no
        addShadow()
    }
    
    private func setTextfieldStatus(isDefault: Bool) {
        layer.borderColor = isDefault ? UIColor.govinfoBlack?.cgColor : UIColor.govinfoRed?.cgColor
        setShadowStatus(isDefault: isDefault)
        isTextValid = isDefault
    }
    
    @objc private func textFieldDidChange() {
        textCasing()
        validateText()
        govinfoDelegate?.govinfoTextfieldViewUITextChanged?(textField: self)
    }
    
    private func textCasing() {
        if self.casing == .uppercased {
            text = (getText()).uppercased()
        } else if self.casing == .lowercased {
            text = (getText()).lowercased()
        } else if self.casing == .capitalized {
            text = (getText()).capitalized
        }
    }
    
    func validateText() {
        if needTextValidation {
            let validations = (!getText().contains("@") && !getText().isEmpty && !getText().contains(" "))
            setTextfieldStatus(isDefault: validations)
        }
    }
}


extension GovinfoTextfieldViewUI: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        govinfoDelegate?.govinfoTextfieldViewUIDone?(textField: self)
        return true
    }
}
