//
//  LoginViewController.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/21/20.
//

import UIKit

class LoginViewController: UIViewController {
        
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Main Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .light
        setUpKeyboardIntercation()
    }
    
    //MARK: - IBActions
    
    @IBAction func hideKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @IBAction func loginButtonIsPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            self.showAlertController(message: "Please, fill in all fields!")
            return
        }
        if !AuthService.shared.authorisationIsSuccessful(email: email, password: password) {
            self.showAlertController(message: "Incorrect email or password")
        } else {
            if let viewController = self.storyboard?.instantiateViewController(identifier: "CitiesListViewController") as? CitiesListViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //MARK: - Flow Functions
    
    func setUpKeyboardIntercation() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
}

//MARK: - Extensions

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
