//
//  ConcurrentOperation_VC.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/13.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
let page:Int = 1
let cellID = "UITableViewCell"

class ConcurrentOperation_VC: UIViewController,UITableViewDelegate,UITableViewDataSource,ConcurrentOperationDelegate
{
   //MARK:Life
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUI()
        loadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:UI
    func setUI()
    {
        self.view.addSubview(self.tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    //MARK:Data
    func loadData()
    {
        let url = "http://live.9158.com/Room/GetNewRoomOnline?page=\(UInt(page))"
        weak var weakSelf = self;
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if response.result.isSuccess{
                if let jsonString = response.result.value{
                    if let responseModel = JSONDeserializer<customModel>.deserializeFrom(json: jsonString){
                        for model in responseModel.data.list{
                            weakSelf?.dataSource.add(model)
                        }
                        weakSelf?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK:Delegate
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if self.dataSource.count > 0 {
            let user = self.dataSource[indexPath.row] as! User
            /* 保证一个url对应一个image对象 */
            let image: UIImage? = self.images[user.photo] as? UIImage
            /* 检查缓存中是否有图片 */
            if image != nil {
                cell.imageView?.image = image
            }
            else {
                /* 设置占位图 */
                cell.imageView?.image = UIImage(named: "reflesh1_60x55")
                var operation: ConcurrentOperation? = self.operations[user.photo] as? ConcurrentOperation
                /* 检查是否正在下载 */
                if operation != nil {
                    /* 什么都不做 */
                }
                else {
                    operation = ConcurrentOperation()
                    operation?.urlStr = user.photo
                    operation?.indexPath = indexPath
                    operation?.delegate = self
                    /* 异步下载 */
                    self.queue.addOperation(operation!)
                    self.operations[user.photo] = operation
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func downLoad(_ operation: ConcurrentOperation, didFinishedDownload image: UIImage)
    {
        /* 1.移除执行完毕的操作 */
        self.operations.removeObject(forKey: operation.urlStr)
        /* 2.将图片放到缓存中 */
        self.images[operation.urlStr] = image
        /* 3.刷新表格(只刷新下载的那一行) */
        self.tableView.reloadRows(at: [operation.indexPath!], with: .automatic)
    }
    
    //MARK:Lazy
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var dataSource: NSMutableArray = {
        let dataSource = NSMutableArray()
        return dataSource
    }()
    
    lazy var queue: OperationQueue = {
        let Queue = OperationQueue()
        return Queue
    }()
    
    lazy var operations: NSMutableDictionary = {
        let operatiaon = NSMutableDictionary()
        return operatiaon
    }()
    
    lazy var images: NSMutableDictionary = {
        let images = NSMutableDictionary()
        return images
    }()
}
