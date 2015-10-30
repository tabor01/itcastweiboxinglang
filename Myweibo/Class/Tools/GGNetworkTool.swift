//
//  GGNetworkTool.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

import AFNetworking

class GGNetworkTool: AFHTTPSessionManager {
    
    
    static let networkTool:GGNetworkTool = {
        let networkUrl = "https://api.weibo.com"
        
        let tool = GGNetworkTool(baseURL: NSURL(string: networkUrl))
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tool
    }()
    
    private let client_id = "804584268"
     let redirect_uri = "http://www.baidu.com"
    
    private let client_secret = "0a5c3c304c2c421c6d65ba7b710c3fd4"
    private let grant_type = "authorization_code"

//
    /// 申请应用时分配的AppSecret
//    private let client_secret = "8c30d1e7d3754eca9076689b91531c6a"
//    /// 申请应用时分配的AppKey
//    private let client_id = "3769988269"
//    /// 请求的类型，填写authorization_code
//    private let grant_type = "authorization_code"
////
////    /// 回调地址
//    let redirect_uri = "http://www.baidu.com/"
//
    func authUrl()->NSURL{
    
        return NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)")!
    
    }
    
    func loadToken(code:String,finished:(result:[String:AnyObject]?,error:NSError?)->()){
        
        let urlString = "/oauth2/access_token"
        
        let parameters = [
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": grant_type,
            "code": code,
            "redirect_uri": redirect_uri
        ]
   
        POST(urlString, parameters: parameters, success: { (_, result) -> Void in
//            let data = String(data:result as! NSData, encoding: NSUTF8StringEncoding)
//            print( "data: \(data)")
            finished(result: result as? [String:AnyObject], error: nil)
            print("result : \(result)")
            }) { (_, error:NSError) -> Void in
//                finished(result: nil, error: error)
                print(error)
        }
    
    }
    

}
