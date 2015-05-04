//
//  LoginViewController.swift
//  UserLoginAndRegistration
//
//  Created by Prince Hunter on 03/05/15.
//  Copyright (c) 2015 techwizard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLogin(sender: AnyObject) {
        let userid = txtEmail.text
        let password = txtPassword.text
        
        if(userid.isEmpty || password.isEmpty)
        {
            displayMyAlertMessage("All Fields are required !!");
        }
        
        
        
        let myURL = NSURL(string: "http://tech3i.com/varun/ios-api/userLogin.php");
        let request = NSMutableURLRequest(URL: myURL!);
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod="POST"
        let postString = "userid=\(userid)&password=\(password)";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                data, response, error in
                if(error != nil)
                {
                    println("error=\(error)")
                    return
                }
                
                
                var err:NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
                
                if let parseJSON = json
                {
                    var resultValue = parseJSON["status"] as? String!;
                    println("result:\(resultValue)")
                    
                    var isUserRegistered:Bool = false
                    if(resultValue=="Success")
                    {
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLogedIn");
                        NSUserDefaults.standardUserDefaults().synchronize();
                        self.dismissViewControllerAnimated(true, completion: nil);
                        
                    }
                    
                }
        }
        task.resume()
        
    }
    func displayMyAlertMessage(userMessage:String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion:nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
