//
//  BlockOperation_VC.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/13.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit

class BlockOperation_VC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        request()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    //MARK:多个请求，依次执行
    func request() {
        let operation1 = BlockOperation
        {
            self.request1()
        }
        
        let operation2 = BlockOperation
        {
            self.request2()
        }
        
        let operation3 = BlockOperation
        {
            self.request3()
        }
        
        let operation4 = BlockOperation()
        operation4.addExecutionBlock
        {
            for _ in 0..<10
            {
                print("3-------------%@",Thread.current)
            }
        }
        
        let operation5 = BlockOperation()
        operation5.addExecutionBlock
        {
            self.request5()
        }
        
        
        /* 设置依赖 */
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
        
        /* 创建队列并加入任务 */
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        queue.addOperations([operation1,operation2,operation3,operation4,operation5], waitUntilFinished: false)
        
        /* 主线程刷新 */
        OperationQueue.main.addOperation
        {
            print("完事")
        }
    }

    /* 请求1 */
    func request1()
    {
        sleep(2)
        print("请求1")
    }
    
    /* 请求2 */
    func request2()
    {
        sleep(4)
        print("请求2")
    }
    
    /* 请求3 */
    func request3()
    {
        sleep(6)
        print("请求3")
    }
    
    /* 请求5 */
    func request5()
    {
        sleep(6)
        print("请求5")
    }
}
