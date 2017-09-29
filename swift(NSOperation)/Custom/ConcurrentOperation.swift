//
//  ConcurrentOperation.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/13.
//  Copyright © 2017年 范云飞. All rights reserved.
//

/**
 自定并发的NSOperation 需要以下步骤
 1.start方法：该方法必须实现
 2.main：该方法可选，如果你在start方法中定义了你的任务，则这个放就可以不实现，但通常为了代码逻辑清晰，通常会在该方法中定义自己的任务
 3.isExecuting isFinished 主要作用是在线程状态改变时，产生适当的KVO通知
 4.isConcurrent ：必须覆盖并且返回YES
 */

import Foundation
import UIKit

protocol ConcurrentOperationDelegate: NSObjectProtocol
{
    func downLoad(_ operation: ConcurrentOperation, didFinishedDownload image: UIImage)
}

class ConcurrentOperation: Operation
{
    var urlStr: String = ""
    var indexPath: IndexPath?
    weak var delegate: ConcurrentOperationDelegate?
    
    private var _executing: Bool = false
    override var isExecuting: Bool
    {
        get
        {
            return _executing
        }
        set
        {
            if _executing != newValue
            {
//                willChangeValue(forKey: "isExecuting")
                _executing = newValue
//                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    private var _finished: Bool = false;
    override var isFinished: Bool
    {
        get
        {
            return _finished
        }
        set
        {
            if _finished != newValue
            {
//                willChangeValue(forKey: "isFinished")
                _finished = newValue
//                didChangeValue(forKey: "isFinished")
            }
        }
    }
    
    override var isConcurrent: Bool
    {
        get
        {
            return true
        }
    }
    
    override init()
    {
        _executing = false
        _finished = false
    }
    
    override func start()
    {
        /* 第一步就要检查是否被取消了，如果取消了，要实现相应的KVO */
        if self.isCancelled
        {
            willChangeValue(forKey: "isFinished")
            _finished = true
            didChangeValue(forKey: "isFinished")
            return
        }
        
        /* 如果没有被取消，开始执行任务 */
        willChangeValue(forKey: "isExecuting")
        
        Thread.detachNewThreadSelector(#selector(main), toTarget: self, with: nil)
        _executing = true
        didChangeValue(forKey: "isExecuting")
        
    }
    
    override func main() {
        defer {
        }
        do {
            autoreleasepool {
                /* 在这里定义自己的并发任务 */
                print("自定义并发操作NSOperation")
                let url = URL(string: urlStr)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                /* 图片下载完毕后，通知代理 */
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate?.downLoad(self, didFinishedDownload: image!)
                })
                
                print("thread-----------\(Thread.current)")
                /* 任务执行完后要实现相应的KVO */
                willChangeValue(forKey: "isFinished")
                willChangeValue(forKey: "isExecuting")
                _executing = false
                _finished = true
                didChangeValue(forKey: "isExecuting")
                didChangeValue(forKey: "isFinished")
            }
        } catch let exception {
        } 
    }

//    override func main()
//    {
//        defer
//        {
//            print("出现错误")
//        }
//        
//        do {
//            autoreleasepool{
//                /* 在这里定义自己的并发任务 */
//                print("自定义并发操作NSOperation")
//                let url = URL(string: urlStr)
//                let data = try? Data(contentsOf: url!)
//                let image = UIImage(data: data!)
//                
//                /* 图片下载完毕后，通知代理 */
//                if (delegate?.responds(to: Selector(("downLoadOperation:didFinishedDownload:"))))!
//                {
//                    DispatchQueue.main.async(execute: {() -> Void in
//                        self.delegate?.downLoad(self, didFinishedDownload: image!)
//                    })
//                }
//                
//                print("thread --------------------\(Thread.current)")
//                
//                /* 任务执行完后要实现相应的KVO */
//                willChangeValue(forKey: "isFinished")
//                willChangeValue(forKey: "isExecuting")
//                _executing = false
//                _finished = true
//                didChangeValue(forKey: "isExecuting")
//                didChangeValue(forKey: "isFinished")
//            }
//        } 
//    }
}

