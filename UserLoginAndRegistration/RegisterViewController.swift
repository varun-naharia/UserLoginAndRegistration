//
//  RegisterViewController.swift
//  UserLoginAndRegistration
//
//  Created by Prince Hunter on 03/05/15.
//  Copyright (c) 2015 techwizard. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var userid: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var repeatpassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerTapped(sender: AnyObject) {
        let userId = userid.text;
        let user_password = password.text;
        let user_password_reaeat = repeatpassword.text;
        
        if(userId.isEmpty || user_password.isEmpty || user_password_reaeat.isEmpty)
        {
            displayMyAlertMessage("All Fields are required !!");
        }
        
        if(user_password != user_password_reaeat)
        {
            displayMyAlertMessage("Password didn't match !!");
        }
        
        
        let myURL = NSURL(string: "http://tech3i.com/varun/ios-api/userRegister.php");
        let request = NSMutableURLRequest(URL: myURL!);
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod="POST"
        let postString = "userid=\(userId)&password=\(user_password)";
        
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
                    isUserRegistered = true;
                }
                var messageToDisplay = parseJSON["message"] as String!;
                if(!isUserRegistered)
                {
                    messageToDisplay = parseJSON["message"] as String!;
                }
                
                dispatch_async(dispatch_get_main_queue(),
                {
                    //Display Alert messsage with confirmation
                    var myAlert = UIAlertController(title: "Alert", message:messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                    let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.Default)
                    {
                        action in
                        self.dismissViewControllerAnimated(true, completion:nil);
                    }
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated: true, completion:nil);
                });
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
