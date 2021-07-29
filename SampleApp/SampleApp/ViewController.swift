//
//  ViewController.swift
//  SampleApp
//
//  Created by Luechen Christopher on 3/30/21.
//

import UIKit
import OrbaOneSdk

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: Any) {
        let config = OrbaOneConfig().setApiKey("PUBLIC-KEY").setApplicantId("GUEST").setFlow([.INTRO, .ID, .FACESCAN]).build()
        do {
            let sdk = try OrbaOneFlow(configuration: config)
            sdk.with(responseHandler: {response in
                switch response {
                case .success(let result):
                    print("Flow completed successfully: \(result)")
                case .failure(let error):
                    print("Flow cancelled by the user: \(error)")
                case .start:
                    print("Flow started.")
                case .error(let error):
                    switch error {
                    case .exception(withMessage: let message):
                       print("\(message)")
                    case .API_KEY_MISSING:
                        print("Publishable key missing.")
                    case .API_KEY_INVALID:
                        print("Publishable key is invalid.")
                    case .USER_INVALID:
                        print("Applicant id is invalid.")
                    case .USER_CANCELLED:
                        print("Applicant cancelled verification.")
                    case .API_NOT_AVAILABLE:
                        print("Orba One servers are unreachable.")
                    case .UPLOAD_INVALID:
                        print("Upload data is corrupted or missing meta data.")
                    @unknown default:
                        print("An unknown error occured.")
                    }
                break;
                }
            })
            
            var presentationStyle: UIModalPresentationStyle = .fullScreen
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                presentationStyle = .formSheet
            }
            
            try sdk.startVerification(origin: self, style: presentationStyle)
        } catch let error {
            print("Flow not started. Error: \(error)")
        }
    }
    
}

