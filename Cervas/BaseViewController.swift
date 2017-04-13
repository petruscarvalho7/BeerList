//
//  BaseViewController.swift
//  Cervas
//
//  Created by Petrus Carvalho on 13/04/17.
//  Copyright © 2017 Petrus Carvalho. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator() {
        
        self.loadingView = UIView()
        self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        self.loadingView.center = self.view.center
        self.loadingView.backgroundColor = UIColor.gray
        self.loadingView.alpha = 0.7
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
        
        self.loadingView.addSubview(self.spinner)
        self.view.addSubview(self.loadingView)
        self.spinner.startAnimating()
        
    }
    
    func hideActivityIndicator() {
        
        self.spinner.stopAnimating()
        self.loadingView.removeFromSuperview()
        
    }

    func isConnectedInternet(){
        if !Reachability.isConnectedToNetwork(){
            alertSettings()
        }
    }
    
    private func alertSettings(){
        let alertController = UIAlertController (title: "Sem conexão com Internet", message: "Para usar o aplicativo é necessário ter uma conexão com a internet.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Configurações", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
        
    }


}
