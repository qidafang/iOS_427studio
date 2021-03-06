//
//  MyRest.swift
//  testall
//
//  Created by 祁达方 on 15/10/15.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import UIKit

///rest客户端的演示
///要继承NSObject否则说没实现啥协议
class FavoriteDeleteRest: NSObject, NSURLConnectionDataDelegate {
    
    var favoriteManageListController:FavoriteManageListController!
    
    //保存数据列表
    var objects = NSMutableArray()
    //接收从服务器返回数据。
    var datas : NSMutableData!
    
    func doDelete(id:String){
        
        ///地址
        var strURL = "http://427studio.net/api/favorite/" + id + "?token=" + Holder.token;
        strURL = strURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string: strURL)!
        ///请求
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        
        ///连接
        let connection  = NSURLConnection(request: request, delegate: self)
        
        ///初始化桶子
        if connection != nil {
            self.datas = NSMutableData()
        }
    }
    
    
    ///数据接收中的回调
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.datas.appendData(data)
    }
    
    ///数据接收错误的回调
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("%@",error.localizedDescription)
    }
    
    ///数据都接收完的回调
    ///关键的类:NSMutableArray和NSMutableDictionary
    func connectionDidFinishLoading(connection: NSURLConnection) {
        favoriteManageListController.reloadData()
    }
    
}
