//
//  GGUserAccount.swift
//  Myweibo
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGUserAccount: NSObject,NSCoding{

    
    
    var access_token : String?
    
    var expires_in: NSTimeInterval = 0 {
        
        didSet
         {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            
        }
    }
    
    var uid:String?
    
    var expires_date : NSDate?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
    
    override var description:String {
    
        return "access_token = \(access_token), expires_in = \(expires_in), uid = \(uid), expires_date = \(expires_date)"
    }
    
    init(dict : [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    static let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!+"/account.plist"
    
    func saveAccount(){
        NSKeyedArchiver.archiveRootObject(self, toFile: GGUserAccount.accountPath)
        print(GGUserAccount.accountPath)
    }
    
    class func loadAccount() -> GGUserAccount? {
     return   NSKeyedUnarchiver.unarchiveObjectWithFile(GGUserAccount.accountPath) as? GGUserAccount
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }
    
}
