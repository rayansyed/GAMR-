//
//  EditAccountVC.swift
//  GAMR
//
//  Created by Rayan Syed on 2019-11-29.
//  Copyright © 2019 Rayan Syed. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditAccountVC: UIViewController {
    
    @IBOutlet var editName : UITextField!
    @IBOutlet var editPassword:UITextField!
    @IBOutlet var editEmail:UITextField!
    @IBOutlet var editConfirmPassword : UITextField!
    
    //todo use Usercontroller for updating, error handling/validation
    var dbUsername: String = ""
    var dbEmail: String = ""
    var dbPassword: String = ""
    var dbName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        editName.text = dbName
        editEmail.text = dbEmail
        editPassword.text = dbPassword


        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateUser(){
        
        if(editName.text == "" || editEmail.text == "" || editPassword.text == "")
        {
            let alert = UIAlertController(title: "Edit Account Error", message: "Fill All Fields.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(editPassword.text != editConfirmPassword.text)
        {
            let alert = UIAlertController(title: "Edit Account Error", message: "Passwords Must Match.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let ref = Database.database().reference().child("users").child(dbUsername)
            ref.child("name").setValue(editName.text)
            ref.child("email").setValue(editEmail.text)
            ref.child("password").setValue(editPassword.text)
            openAccountScene()
            
        }
        

    }
    
    func openAccountScene()
    {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountVC = mainSB.instantiateViewController(withIdentifier: "AccountScene") as! AccountVC
        accountVC.modalPresentationStyle = .fullScreen
        accountVC.dbUsername = self.dbUsername
        self.navigationController?.pushViewController(accountVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

