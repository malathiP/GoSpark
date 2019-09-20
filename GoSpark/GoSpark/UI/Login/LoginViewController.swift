//
//  LoginViewController.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Variables
    var loginViewModel = LoginViewModel.sharedInstance
    let disposeBag = DisposeBag()
    var subscribe : Disposable?
    
    // MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Login"

    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.emailIdTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    // MARK: Login Action
    @IBAction func login(_ sender: Any) {
        
        DispatchQueue.main.async {

        self.doLogin()
        }
    }
    func doLogin() {
        
        guard self.isValidateLogin() else {
            
            return
        }
        self.showLoader()
        self.loginViewModel.login(withEmail: self.emailIdTextField.text, password: self.passwordTextField.text).asObservable().subscribe(onNext: {[weak self] (user) in
            
            self?.hideLoader()
            self?.showNewsFeedsController(withUserName: user?.name ?? "")
            
            }, onError: { [weak self](error) in
                
                self?.hideLoader()
                print("LoginViewController.addObserverToLogin : \(error.localizedDescription)")
                self?.showAlertWith("Error!", message: "Invalid Credentials", completionHandler: nil)
                
        }).disposed(by: self.disposeBag)
    }
    func isValidateLogin() -> Bool {
        
        guard self.emailIdTextField.text?.count != 0  else {
            
            self.showAlertWith("Alert!", message: "Enter EmailId", completionHandler: nil)
            return false
        }
        
        guard self.passwordTextField.text?.count != 0 else {
            
            self.showAlertWith("Alert!", message: "Enter Password", completionHandler: nil)
            return false
        }
        guard self.emailIdTextField.text?.isValidEmail() ?? false else {
            
            self.showAlertWith("Alert!", message: "Enter Valid EmailId", completionHandler: nil)
            return false
        }
        return true
    }
}

// MARK: UITextFieldDelegate Methods
extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.doLogin()
        return true
    }
}
