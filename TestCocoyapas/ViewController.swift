//
//  ViewController.swift
//  TestCocoyapas
//
//  Created by ios on 2018/1/31.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    var ref: DatabaseReference!
    var user = ""
    
    var e = "abcccc@aaa.com"
    var p = "Password"
//    var u = ""
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var Lab: UILabel!
    @IBAction func Btn(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: e, password: p) { (user, error) in
            // ...
//             u = user
            let error = error
            print(error?.localizedDescription as Any)
            }
        
        Lab.text = e + p
        Auth.auth().signIn(withEmail: e, password: p) { (user, error) in
            // ...
            let a = user?.email
            let b = user?.uid
            
            let photoURL = user?.photoURL
            print("\(a!) \n \(b!) \n \(String(describing: photoURL))")
            let error = error
            print(error?.localizedDescription as Any)
            self.ref.child("users").child(b!).setValue(["username": "username"])
            self.ref.child("users/\(b!) /show").setValue("123")
             self.ref.child("users/\(b!) /aaa").setValue("456")
        }
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            _ = User.self
            print(value)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    
var handle: AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if nameField?.text != "" { // 1
            Auth.auth().signInAnonymously(completion: { (user, error) in // 2
                if let err = error { // 3
                    print(err.localizedDescription)
                    return
                    
                }
                
                self.performSegue(withIdentifier: "LoginToChat", sender: nil) // 4
            })
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
}

