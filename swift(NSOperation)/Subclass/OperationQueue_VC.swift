//
//  OperationQueue_VC.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/13.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit

class OperationQueue_VC: UIViewController
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
    
    //MARK:直接添加block任务
    func request() {
        /* 创建队列 */
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        /* 添加任务 */
        queue.addOperation
        {
            for _ in 0..<10
            {
                print("1-------------%@",Thread.current)
            }
        }
        
        queue.addOperation
        {
            for _ in 0..<10
            {
                print("2-------------%@",Thread.current)
            }
        }
        
        queue.addOperation
        {
            for _ in 0..<10
            {
                print("3-------------%@",Thread.current)
            }
        }
        
        /* 主线程刷新 */
        OperationQueue.main.addOperation
        {
            print("main-------------%@",Thread.current)
        }
    }

}
