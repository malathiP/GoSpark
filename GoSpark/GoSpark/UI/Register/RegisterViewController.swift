//
//  RegisterViewController.swift
//  GoSpark
//
//  Created by Malathi Pothala on 9/18/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift

class RegisterViewController: BaseViewController {

    // MARK: Variables
    weak var loginViewModel = LoginViewModel.sharedInstance
    let disposeBag = DisposeBag()

    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Registration"
    }
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: 0, height: 0)
    }

    // MARK: Register Action
    @IBAction func register(_ sender: Any) {
        
       self.validateRegistrationFields()

    }
    func validateRegistrationFields() {
        
        let stackView = self.scrollView.viewWithTag(TagConstants.Registration.stackViewTag)
        guard stackView != nil else {
            
            return 
        }
        let nameTextField = stackView?.viewWithTag(TagConstants.Registration.nameTag) as? UITextField
        let emailTextField = stackView?.viewWithTag(TagConstants.Registration.emailTag) as? UITextField
        let passwordTextField = stackView?.viewWithTag(TagConstants.Registration.passwordTag) as? UITextField
        let confirmPasswordTextField = stackView?.viewWithTag(TagConstants.Registration.confirmPasswordTag) as? UITextField
        let phoneNumberTextField = stackView?.viewWithTag(TagConstants.Registration.phoneNumberTag) as? UITextField
        let genderSegmentControl = stackView?.viewWithTag(TagConstants.Registration.genderTag) as? UISegmentedControl
        
        let name = nameTextField?.text ?? ""
        let email = emailTextField?.text ?? ""
        let password = passwordTextField?.text ?? ""
        let confirmPassword = confirmPasswordTextField?.text ?? ""
        let phoneNumber = phoneNumberTextField?.text ?? ""
        let gender = genderSegmentControl?.selectedSegmentIndex == 0 ? "Female" : "Male"
        
        guard name.count != 0  else {
            
            self.showAlertWith("Alert!", message: "Enter Name", completionHandler: nil)
            return
        }
        
        guard email.count != 0 else {
            
            self.showAlertWith("Alert!", message: "Enter EmailId", completionHandler: nil)
            return
        }
        guard email.isValidEmail() else {
            
            self.showAlertWith("Alert!", message: "Enter Valid EmailId", completionHandler: nil)
            return
        }
        guard password.count != 0 else {
            
            self.showAlertWith("Alert!", message: "Enter Password", completionHandler: nil)
            return
        }
        guard confirmPassword.count != 0 else {
            
            self.showAlertWith("Alert!", message: "Enter ConfirmPassword", completionHandler: nil)
            return
        }
        guard password == confirmPassword  else {
            
            self.showAlertWith("Alert!", message: "Password and confirmPassword is not matching", completionHandler: nil)
            return
        }
        guard phoneNumber.count != 0 else {
            
            self.showAlertWith("Alert!", message: "Enter PhoneNumber", completionHandler: nil)
            return
        }
        self.loginViewModel?.register(withName:name , emailId: email, password: password, phoneNumber: phoneNumber, gender: gender).asObservable().subscribe(onNext: {[weak self] (status) in
            
            self?.hideLoader()
            self?.showAlertWith("Alert!", message: status ?? "", completionHandler:{
                
                self?.navigationController?.popViewController(animated: true)
            })
            
            }, onError: { [weak self](error) in
                
                self?.hideLoader()
                print("RegisterViewController.addObserverToRegister : \(error.localizedDescription)")
                self?.showAlertWith("Error!", message: "Registration Failed", completionHandler: nil)
                
        }).disposed(by: self.disposeBag)
    }

}

// MARK: UITextFieldDelegate Methods
extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let tag = textField.tag
        let stackView = self.scrollView.viewWithTag(TagConstants.Registration.stackViewTag)
        let nameTextField = stackView?.viewWithTag(tag + 1) as? UITextField
        guard nameTextField != nil else {
            
            textField.resignFirstResponder()
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            return true
        }
        nameTextField?.becomeFirstResponder()
        self.scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y), animated: true)
        return true
    }
}
