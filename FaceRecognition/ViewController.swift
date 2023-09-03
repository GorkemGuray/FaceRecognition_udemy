//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Görkem Güray on 3.09.2023.
//

import UIKit
//burası import edilmelidir.
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signInClicked(_ sender: UIButton) {
        
        //biometric doğrulama için LocalAuthentication contextinie ihtiyacımız var.
        let authContext = LAContext()
        
        //ayrıca NSErrorPointer -'a da ihtiyacımız var
        //aşağıda başında & işreti ile kullanıldığına dikkat edelim.
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you") { succes, error in
                if succes == true {
                    
                    //perform segue işlemi main thread'de olması lazım o yüzden, dispatch kullanıyoruz.
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                    
                    
                } else {
                    
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                    
                    
                    
                }
            }
            
        }
        
    }
}

