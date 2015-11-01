//
//  GGNetworkTool.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

import AFNetworking

enum GGNetworkError: Int {

    case emptyToken = -1
    case emptyUid = -2

    var description: String{
        get {
            switch self {
            case GGNetworkError.emptyToken:
                return "accesstoken 为空"
            case GGNetworkError.emptyUid:
                return "uid 为空"
                
            }
        }
    }
    
    func error()->NSError {
    
    return NSError(domain: "gg.error.network", code: rawValue, userInfo: ["errorDescription":description])
    }

}

class GGNetworkTool: NSObject {
    
    //让工具类独立出来
    private var afnManager: AFHTTPSessionManager
    static let sharedInstance: GGNetworkTool = GGNetworkTool()
    
//    static let networkTool:GGNetworkTool = {
//        let networkUrl = "https://api.weibo.com"
//        
//        let tool = GGNetworkTool(baseURL: NSURL(string: networkUrl))
//        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
//        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
//        return tool
//    }()
    
    override init(){
    let urlString = "https://api.weibo.com"
        afnManager = AFHTTPSessionManager(baseURL: NSURL(string: urlString))
        afnManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
    }
    
    private let client_id = "804584268"
     let redirect_uri = "http://www.baidu.com"
    
    private let client_secret = "0a5c3c304c2c421c6d65ba7b710c3fd4"
    private let grant_type = "authorization_code"


    func authUrl()->NSURL{
    
        return NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)")!
    
    }
    ///第一次验证oAuth时用,传送结果到finish
    func loadToken(code:String,finished:(result:[String:AnyObject]?,error:NSError?)->()){
        
        let urlString = "/oauth2/access_token"
        
        let parameters = [
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": grant_type,
            "code": code,
            "redirect_uri": redirect_uri
        ]
   
        afnManager.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
//            let data = String(data:result as! NSData, encoding: NSUTF8StringEncoding)
//            print( "data: \(data)")
            finished(result: result as? [String:AnyObject], error: nil)
            print("result : \(result)")
            }) { (_, error:NSError) -> Void in
                finished(result: nil, error: error)
//                print(error)
        }
    
    }
    /// 第二次 验证用户接口时，传送结果到finish
    func loadUserInfo(finish:(result:[String:AnyObject]?,error:NSError?)->()){
        
        
        if GGUserAccount.loadAccount()?.access_token != nil
        {
            let error = GGNetworkError.emptyToken.error()
            finish(result: nil, error: error)
            print("没有用户信息")
            return
        }
        
        if GGUserAccount.loadAccount()?.uid == nil
        {
            print("没有uid")
            let error = GGNetworkError.emptyUid.error()
            finish(result: nil, error: error)
            return
        }
    
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = [
        
            "access_token": GGUserAccount.loadAccount()!.access_token!,
            "uid": GGUserAccount.loadAccount()!.uid!
        
        ]
        requestGet(urlString, parameters: parameters, finished: finish)
        
//        afnManager.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
////            print("result:\(result)")
////            let res = result as? [String:AnyObject]
//            finish(result: result as? [String:AnyObject] , error: nil)
//            }) { (_, error) -> Void in
////                print("error:\(error)")
//                finish(result: nil, error: error)
//        }
    
    }
    typealias NetworkFinishedCallBack = (result:[String:AnyObject]?,error:NSError?)->()
    
    //提取公用信息
    func requestGet(urlString: String, parameters: AnyObject?, finished:NetworkFinishedCallBack){
    
        afnManager.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
            finished(result: result as? [String:AnyObject], error: nil)
            }) { (_, error) -> Void in
                finished(result: nil, error: error)
        }
    
    }
    
    

}
