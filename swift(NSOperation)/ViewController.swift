//
//  ViewController.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/7.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    var titlArr = [String]()
    var dataArr = [[String]()]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Create_UI()
        Create_DATA()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:UI
    func Create_UI()
    {
        self.view.addSubview(self.tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"UITableViewCell")
    }
    
    //MARK:Data
    func Create_DATA()
    {
        self.titlArr = ["Operation的子类",
                        "ConcurrentOperation(自定义并发)"
                       ]
        self.dataArr = [["BlockOperation",
                         "OperationQueue"
                         ],
                        ["ConcurrentOperation"
                         ]
                       ]
        /* 刷新 */
        self.tableView.reloadData()
    }
    
    //MARK:Delegate
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.titlArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.dataArr[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return self.titlArr[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let blockOperation_VC = BlockOperation_VC()
                self.navigationController?.pushViewController(blockOperation_VC, animated: true)
            }
            if indexPath.row == 1
            {
                let operationQueue_VC = OperationQueue_VC()
                self.navigationController?.pushViewController(operationQueue_VC, animated: true)
            }
        }
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                let concurrentOperation_VC = ConcurrentOperation_VC()
                self.navigationController?.pushViewController(concurrentOperation_VC, animated: true)
            }
        }
    }
    
    //MARK:Lazy
    lazy var tableView: UITableView =
    {
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

