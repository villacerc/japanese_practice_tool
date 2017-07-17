//
//  ViewController.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-15.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import UIKit



class RootViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func launchStrokeViewButton(_ sender: AnyObject) {
        RandomNumber.renew()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
        return UIInterfaceOrientationMask.portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        get {
        return false
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
        return UIInterfaceOrientation.portrait
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
