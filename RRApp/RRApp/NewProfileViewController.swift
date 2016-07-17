//
//  NewProfileViewController.swift
//  RRApp
//
//  Created by Michael Defranco on 7/9/16.
//  Copyright © 2016 Michael Defranco. All rights reserved.
//

import UIKit

class NewProfileViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var carType: UITextField!
    @IBOutlet weak var carColor: UITextField!
    @IBOutlet weak var licenseNum: UITextField!
    @IBOutlet weak var statePlate: UITextField!
    @IBOutlet weak var age: UIPickerView!
    @IBOutlet weak var radioStation: UITextField!
    @IBOutlet weak var driverType: UITextField!
    @IBOutlet weak var musicGenre: UITextField!
    @IBOutlet weak var driveDesc: UITextField!
    
    var databasePath = NSString();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        print (dirPaths)
        //let docsDir = dirPaths[0] as NSString
        let docsDir = "/Users/MichaelDeFranco/Documents/Workspace/RoadRage" as NSString
        databasePath = docsDir.stringByAppendingPathComponent(
            "profiles.db")
        print (databasePath as String)
        if !filemgr.fileExistsAtPath(databasePath as String) {
            
            let profilesDB = FMDatabase(path: databasePath as String)
            
            if profilesDB == nil {
                print("Error: \(profilesDB.lastErrorMessage())")
            }
            
            if profilesDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS PROFILES (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, CARTYPE TEXT, CARCOLOR TEXT, LICENCENUM TEXT, STATEPLATE TEXT, AGE INTEGER, RADIOSTATION TEXT, DRIVERTYPE TEXT, MUSICGENRE TEXT, DRIVEDESC TEXT)"
                if !profilesDB.executeStatements(sql_stmt) {
                    print("Error: \(profilesDB.lastErrorMessage())")
                }
                profilesDB.close()
            } else {
                print("Error: \(profilesDB.lastErrorMessage())")
            }
        }
        //profilesDB.close();
    }
    
    @IBAction func saveProfile(sender: AnyObject) {
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            
            let insertSQL = "INSERT INTO PROFILES (username, cartype, carcolor) VALUES ('\(username.text)', '\(carType.text)', '\(carColor.text)')"
            
            let result = contactDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                //status.text = "Failed to add contact"
                print("Error: \(contactDB.lastErrorMessage())")
            } else {
                //status.text = "Contact Added"
                //name.text = ""
                //address.text = ""
                //phone.text = ""
                print("success")
            }
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}