//
//  ViewController.swift
//  doonmobile
//
//  Created by Aryan Ahmad on 2020-09-02.
//  Copyright © 2020 Aryan Ahmad. All rights reserved.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming
import AVFoundation
import MaterialComponents.MaterialDialogs


class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountToggle: UISegmentedControl!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var loginmdc: MDCButton!
    
    let containerScheme = MDCContainerScheme()
    let NetworkRequest = networkRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 15
        
        loginmdc.applyContainedTheme(withScheme: containerScheme)
        firstNameField.isHidden = true
        lastNameField.isHidden = true
        
    }
    
    @IBAction func loginToggleSelect(_ sender: Any) {
        if accountToggle.selectedSegmentIndex == 0{
            //Login Selected
            passwordField.placeholder = "Password"
            passwordField.isSecureTextEntry = true
            passwordField.text = ""
            firstNameField.isHidden = true
            lastNameField.isHidden = true
            
        }else{
            //Create account selected
            passwordField.placeholder = "Email"
            passwordField.isSecureTextEntry = false
            passwordField.text = ""
            firstNameField.isHidden = false
            lastNameField.isHidden = false
        }
    }
    
    @IBAction func loginbuttonmdcClick(_ sender: Any) {
        var params : Parameters
        if accountToggle.selectedSegmentIndex == 0{
            //Login
            params = ["username": usernameField.text!, "password":passwordField.text!]
            authenticate(header: signIn, params: params)
        }else{
            //Create Account
            params = ["firstName": firstNameField.text!, "lastName":lastNameField.text!, "email": passwordField.text!, "message":""]
            authenticate(header: signUp, params: params)
        }
    }
    
    
    fileprivate func showAlert(_ message: String, _ title: String) {
        let alertController = MDCAlertController(title: title, message: message)
        let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
        alertController.addAction(action)
        self.present(alertController, animated:true, completion: nil)
    }
    
    func authenticate(header: String, params: Parameters){
        AF.request(url + auth + header, method: .post, parameters: params, encoding: JSONEncoding.default).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response in
            //print("STATUS CODE = ",  response.response!.statusCode)
            switch response.result {
            case .success(let JSON):
                //print ("\n\n Login Successfull : \(JSON)");
                do{
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .formatted(.utcDateFormatter)
                    let loginResp = try jsonDecoder.decode(LoginResponse.self, from: response.data!)
                    let accessToken = loginResp.accessToken
                    let defaults = UserDefaults.standard
                    defaults.set(accessToken, forKey: "accessToken")
                    defaults.set(loginResp.expiration, forKey: "token_expire")
                    self.moveStoryBoard()
                }
                catch{
                    print("Error getting LoginResponse: \(error).")
                }
            case .failure(let error):
                print(error.localizedDescription)
                do {
                    if(response.data == nil)
                    {
                        self.showAlert(error.localizedDescription, "Login Error")
                        return
                    }
                    let responseDecoded = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
                    print(responseDecoded)
                    self.showAlert(responseDecoded.message, "Login Error")
                    
                } catch {
                    print("Error Calling Login: \(error).")
                }
            }
        }
        
    }
    
    func moveStoryBoard(){
        let settingController = UIStoryboard(name: "dashboard", bundle: nil).instantiateViewController(withIdentifier: "dashboardVC1") as! dashboardVC
        //settingController.modalPresentationStyle = .fullScreen;
        settingController.modalPresentationStyle = .fullScreen
        self.present(settingController, animated: true, completion: nil)
    }
    
    
}

