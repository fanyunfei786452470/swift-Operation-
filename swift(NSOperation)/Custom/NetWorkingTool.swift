//
//  NetWorkingTool.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/14.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit

import Alamofire

enum RequestType {
    case get
    case post
}

let share = NetWorkingTool()

class NetWorkingTool: NSObject {
    
    static var shareInstance:NetWorkingTool
    {
        return share
    }
    
    /* init方法 */
    override init() {
        super.init()
        print("调用初始化方法")
    }
    
    //可根据需要传参数
    public func requestData(_ type : RequestType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error ?? -1)
                return
            }
            finishedCallback(result)
        }
    }
}
