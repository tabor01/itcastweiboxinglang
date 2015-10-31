//
//  GGUserAccount.swift
//  Myweibo
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

//import 

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
    
    var name: String?
    
    var avatar_large: String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
    
    override var description:String {
    
        return "access_token = \(access_token), expires_in = \(expires_in), uid = \(uid), expires_date = \(expires_date), name = \(name), avatar_large = \(avatar_large)"
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
    
    private static var userAccount:GGUserAccount?
    
    class func loadAccount() -> GGUserAccount? {
        
        if userAccount == nil
        {
            
          userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(GGUserAccount.accountPath) as? GGUserAccount
        }
        
        if userAccount != nil && userAccount?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending{
            print("账号有效")
            return userAccount
        }
        return nil
    }
   
    func loadUserInfo(finish:(error:NSError?)->()){
        GGNetworkTool.sharedInstance.loadUserInfo { (result, error) -> () in
            if error != nil || result == nil
            {
                print("加载用户数据失败")
                finish(error: error!)
                return
            }
            
            self.name = result!["name"] as? String
            self.avatar_large = result!["avatar_large"] as? String
            
            
            GGUserAccount.userAccount = self
        self.saveAccount()
            finish(error: nil)
        }
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(name, forKey: "name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
    
    }
    
}
