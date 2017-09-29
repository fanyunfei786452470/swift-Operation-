//
//  User.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/13.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit
import HandyJSON

class customModel: HandyJSON {
    var msg: String!
    var data: data!
    var code: Int = 0
    required init() {
    }
}
struct data:HandyJSON {
    var totalPage:Int = 0
    var list:[User]!
    
}

struct User:HandyJSON {
    /** 直播地址 */
    
    var flv: String = ""
    /** 昵称 */
    var nickname: String = ""
    /** 照片地址 */
    var photo: String = ""
    /** 所在地区 */
    var position: String = ""
    /** 房间号 */
    var roomid: String = ""
    /** 用户id */
    var useridx: String = ""
    /** 是否是新人 */
    var newStar: Int = 0
    /** 服务器号 */
    var serverid: Int = 0
    /** 性别 */
    var sex: Int = 0
    /** 等级 */
    var starlevel: Int = 0
}

