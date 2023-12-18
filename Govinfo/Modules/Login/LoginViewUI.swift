//
//  LoginViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class LoginViewUI: UIView {
    private weak var delegate: LoginViewUIProtocol?
    
    private lazy var scrollContent: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .govinfoBlack
        label.font = .getComicFont(24)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Login.title".localized
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .fill
        stack.isHidden = true
        return stack
    }()
    
    private lazy var userTextfield: GovinfoTextfieldViewUI = {
       let textfield = GovinfoTextfieldViewUI()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.govinfoPlaceholder = "Textfields.user".localized
        textfield.identifier = "Textfields.user".localized
        textfield.casing = .lowercased
        textfield.govinfoDelegate = self
        return textfield
    }()
    
    private lazy var passTextfield: GovinfoTextfieldViewUI = {
       let textfield = GovinfoTextfieldViewUI()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isSecureTextEntry = true
        textfield.govinfoPlaceholder = "Textfields.pass".localized
        textfield.identifier = "Textfields.pass".localized
        textfield.govinfoDelegate = self
        return textfield
    }()
    
    private lazy var loginButton: GovinfoButtonViewUI = {
       let button = GovinfoButtonViewUI()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buttons.login".localized, for: .normal)
        return button
    }()
    
    private lazy var registerButton: GovinfoButtonViewUI = {
       let button = GovinfoButtonViewUI()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buttons.register".localized, for: .normal)
        return button
    }()
    
    
    private lazy var separatorView: GovinfoSeparatorViewUI = {
       let separator = GovinfoSeparatorViewUI()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.title = "Separators.or".localized
        return separator
    }()
    
    private lazy var googleButton: GovinfoButtonViewUI = {
       let button = GovinfoButtonViewUI()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buttons.google".localized, for: .normal)
        return button
    }()
    
    private lazy var biometricCheckboxButton: GovinfoCheckboxViewUI = {
       let checkbox = GovinfoCheckboxViewUI()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.title = "Buttons.biometricsCheckbox".localized
        checkbox.delegate = self
        return checkbox
    }()
    
    private lazy var biometricLogInButton: GovinfoBiometricButtonViewUI = {
       let button = GovinfoBiometricButtonViewUI()
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private lazy var changeToManualLoginButton: GovinfoButtonViewUI = {
       let button = GovinfoButtonViewUI()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buttons.manually".localized, for: .normal)
        button.isHidden = true
        return button
    }()
    
    
    required init(delegate: LoginViewUIProtocol) {
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        setTargets()
        backgroundColor = .govinfoOrange
    }
    
    func setSubviews(){
        addSubview(scrollContent)
        
        scrollContent.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(userTextfield)
        mainStackView.addArrangedSubview(passTextfield)
        mainStackView.addArrangedSubview(biometricCheckboxButton)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(separatorView)
        mainStackView.addArrangedSubview(registerButton)
        mainStackView.addArrangedSubview(googleButton)
        
        containerView.addSubview(biometricLogInButton)
        containerView.addSubview(changeToManualLoginButton)
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
            scrollContent.topAnchor.constraint(equalTo: topAnchor),
            scrollContent.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollContent.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollContent.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollContent.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            
            userTextfield.heightAnchor.constraint(equalToConstant: 60),
            passTextfield.heightAnchor.constraint(equalToConstant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            biometricLogInButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            biometricLogInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            biometricLogInButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            biometricLogInButton.heightAnchor.constraint(equalTo: biometricLogInButton.widthAnchor),
            
            changeToManualLoginButton.topAnchor.constraint(equalTo: biometricLogInButton.bottomAnchor, constant: 20),
            changeToManualLoginButton.leadingAnchor.constraint(equalTo: biometricLogInButton.leadingAnchor),
            changeToManualLoginButton.trailingAnchor.constraint(equalTo: biometricLogInButton.trailingAnchor),
            changeToManualLoginButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setTargets() {
        googleButton.addTarget(self, action: #selector(logInUsingGoogle), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(logInUsingUserAndPass), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerUsingUserAndPass), for: .touchUpInside)
        changeToManualLoginButton.addTarget(self, action: #selector(logInManually), for: .touchUpInside)
    }
    
    @objc func logInUsingGoogle() {
        delegate?.logInWithGoogle(useBiometrics: biometricCheckboxButton.status)
    }
    
    @objc func logInUsingUserAndPass() {
        guard validate() else {
            return
        }
        
        delegate?.logInWithUserAndPass(model: LoginRequest(user: userTextfield.getText(), pass: passTextfield.getText()), useBiometrics: biometricCheckboxButton.status)
    }
    
    @objc func registerUsingUserAndPass() {
        guard validate() else {
            return
        }
        
        delegate?.registerUser(model: LoginRequest(user: userTextfield.getText(), pass: passTextfield.getText()), useBiometrics: biometricCheckboxButton.status)
    }
    
    @objc func logInManually() {
        showViewComponents(biometricsSaved: false)
    }
    
    private func validate() -> Bool {
        userTextfield.validateText()
        passTextfield.validateText()
        
        return (userTextfield.isTextValid && passTextfield.isTextValid)
    }
    
    func showViewComponents(biometricsSaved: Bool) {
        mainStackView.isHidden = biometricsSaved
        biometricLogInButton.isHidden = !biometricsSaved
        changeToManualLoginButton.isHidden = !biometricsSaved
    }
    
    func clearFields() {
        userTextfield.text = ""
        passTextfield.text = ""
        setBiometricsCheckStatus(status: false)
    }
    
    func setBiometricsCheckStatus(status: Bool) {
        biometricCheckboxButton.setStatus(status: status)
    }
}

extension LoginViewUI: GovinfoTextfieldViewUIDelegate {
    func govinfoTextfieldViewUIDone(textField: GovinfoTextfieldViewUI) {
        if textField.identifier == "Textfields.user".localized {
            passTextfield.becomeFirstResponder()
        } else {
            passTextfield.resignFirstResponder()
        }
    }
}

extension LoginViewUI: GovinfoBiometricButtonViewUIDelegate {
    func biometricStatus(authenticated: Bool) {
        delegate?.logInWithBiometrics()
    }
}

extension LoginViewUI: GovinfoCheckboxViewUIDelegate {
    func checkBoxDidCheck(status: Bool) {
        if status {
            delegate?.checkBiometricsPermission()
        }
    }
}

