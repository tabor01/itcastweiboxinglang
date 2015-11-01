//
//  GGOauthViewController.swift
//  Myweibo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit
import SVProgressHUD
class GGOauthViewController: UIViewController {

    
    override func loadView() {
        view = webview
        webview.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view = webview
//        view.backgroundColor = UIColor.orangeColor()
        
//        let rightButton = UIButton()
//        rightButton.setTitle("取消", forState: UIControlState.Normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "填充", style: UIBarButtonItemStyle.Plain, target: self, action: "autoFill")
        let request = NSURLRequest(URL: GGNetworkTool.sharedInstance.authUrl())
        
        webview.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func autoFill(){
    
    let js = "document.getElementById('userId').value='xngpq@198.com';" + "document.getElementById('passwd').value='0000023456';"
//        let result = webview.stringByEvaluatingJavaScriptFromString(js)
//        print(result)
    
       webview.stringByEvaluatingJavaScriptFromString(js)
        
//    let js = "document.getElementById('userId').value='czbkiosweibo@163.com';" + "document.getElementById('passwd').value='czbkiosczbkios';"
        
        // webView执行js代码
//        webview.stringByEvaluatingJavaScriptFromString(js)
        
    }
    
    lazy var webview:UIWebView = {
        let wb = UIWebView(frame: UIScreen.mainScreen().bounds)
        return wb
    }()
    
    
    func close(){
        
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    


}
extension GGOauthViewController: UIWebViewDelegate{

    func webViewDidStartLoad(webView: UIWebView) {
//        SVProgressHUD.showProgress(2, status: "正在玩命加载")
        SVProgressHUD.showWithStatus("天上在", maskType: SVProgressHUDMaskType.Black)
        print("----start-----\(__FUNCTION__)")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.showWithStatus("pfq", maskType: SVProgressHUDMaskType.Black)
        SVProgressHUD.dismiss()
       print("----finish----\(__FUNCTION__)")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
//        SVProgressHUD.showWithStatus("天上", maskType: SVProgressHUDMaskType.Black)
       print("----fail---\(__FUNCTION__)")
        SVProgressHUD.dismiss()
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("----request----\(__FUNCTION__)")
        let urlString = request.URL?.absoluteString
        print(urlString)
        
        if ((urlString?.hasPrefix(GGNetworkTool.sharedInstance.redirect_uri)) == false) {
            return true
        }
        
        
        if let query = request.URL?.query {
            
            let coding = "code="
            if query.hasPrefix(coding){
                let nsQuery = query as NSString
                let code = nsQuery.substringFromIndex(coding.characters.count)
                
                print(code)
            
                loadToken(code)
            }
            
        }
        
        return false
    }
    
    
    
    func loadToken(code:String){
        
        GGNetworkTool.sharedInstance.loadToken(code) { (result, error) -> () in
            if error != nil || result == nil
            {
                self.netError("网络不给力")
                return
            }
            
            print(result)
            
            let account =  GGUserAccount(dict: result!)
            // 保存用户数据
            account.saveAccount()
           
            //加载网页信息
            account.loadUserInfo({ (error) -> () in
                if error != nil
                {
                    self.netError("加载用户数据出错")
//                    self.netError(<#T##error: String##String#>)
                
                }
                return
            })
           
             print("account:\(GGUserAccount.loadAccount())")
            //关闭弹出信息
//            SVProgressHUD.dismiss()
            self.close()
            //加载成功， 进入欢迎界面
             (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootVC(false)
        }
        
    }

func netError(error:String){

    SVProgressHUD.showErrorWithStatus(error, maskType: SVProgressHUDMaskType.Black)
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)),dispatch_get_main_queue(), { () -> Void in
        self.close()
    })

}
    
}