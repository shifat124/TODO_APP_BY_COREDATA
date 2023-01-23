//
//  FirstViewController.swift
//  TODO App
//
//  Created by BJIT on 19/10/1401 AP.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        retreiveData()
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        //UserDefault Part
        UserDefaults.standard.set(nameTextView.text, forKey: "Name")
        UserDefaults.standard.set(emailTextView.text, forKey: "Email")
        //keyChain Part
        let flag = KeyChainManager.shared.readFromKeyChain(account: emailTextView.text!, service: "password", userInputPass: passwordTextView.text!)
        if flag == true {
            let alert = UIAlertController(title: "Log In", message: "Logged In Successfully", preferredStyle: .alert)
            let login = UIAlertAction(title: "ok", style: .default) { [weak self] _ in
                self?.performSegue(withIdentifier: "connector", sender: nil)
            }
            alert.addAction(login)
            present(alert, animated: true)
            
            //self.performSegue(withIdentifier: "loginUser", sender: self)
            //dict[emailField.text!] = Date()
           // PlistManager.shared.writeToPlist(with: &dict, userName: emailField.text!)
        }
        
        else {
            let alert = UIAlertController(title: "Log In", message: "Log In Unsuccessfull", preferredStyle: .alert)

            let login = UIAlertAction(title: "Try Again", style: .cancel)
            alert.addAction(login)
            present(alert, animated: true)
        }
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        let userInputPassword: String = passwordTextView.text!
        guard let data = try? JSONEncoder().encode(userInputPassword) else {return}
        
        //writeToKeyChain(data: data)
        KeyChainManager.shared.writeToKeyChain(account: emailTextView.text!, service: "password", data: data)
    }
    
    
    
    
    func retreiveData(){
       let userName = UserDefaults.standard.string(forKey: "Name")
       let userEmail = UserDefaults.standard.string(forKey: "Email")
       print("Name of user is \(userName!) and email of user is \(userEmail!)")
    }
}
