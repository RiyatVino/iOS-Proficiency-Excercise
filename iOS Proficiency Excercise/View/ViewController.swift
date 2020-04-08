//
//  ViewController.swift
//  iOS Proficiency Excercise
//
//  Created by Vino on 4/6/20.
//  Copyright © 2020 Vino. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation

class ViewController: UIViewController {
        
    //MARK:- Variable Declarations
    let cellIdentifier = "RowsTableViewCell"
    let noDataText = "No data found!"
    let network: NetworkManager = NetworkManager.sharedInstance
    private let refreshControl = UIRefreshControl()
    var mainData: MainModel?
    var tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
    var noDataLabel = UILabel()
    var indicator = UIActivityIndicatorView()

    //MARK:- setupactivityIndicator
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    //MARK: startAnimating
    func startAnimating() {
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
    }
    
    //MARK: stopAnimating
    func stopAnimating() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
 

    
    //MARK:- setupTableView
    func setupTableView(){
        //Setting homeListTbl
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(RowsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:tableView.bounds.size.height))
        noDataLabel.text = noDataText
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        noDataLabel.isHidden = true
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.addRefreshControll(actionTarget: self, action: #selector(refreshUpdateData))

        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8)
        ])
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    //MARK:- Common UIAlertView
    func showAlert(_ title: String, _ message: String, _ buttonTitle: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    //MARK:- refreshUpdateData for UIRefreshControl
    @objc private func refreshUpdateData(_ sender: Any) {
        // Fetch Weather Data
        getData()
        tableView.endRefreshing(deadline: .now() + .seconds(3))
    }
    
    //MARK:- refreshData for Refresh ButtonAction
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        tableView.pullAndRefresh()

    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.refreshData))
        
        activityIndicator()
        NetworkManager.isUnreachable { _ in
            self.showAlert("Alert", "No internet Connection","Dismiss")
        }
        
        NetworkManager.isReachable { _ in
            DispatchQueue.main.async {
            self.setupTableView()
            self.getData()
            }
        }
        // Do any additional setup after loading the view.
    }
    //MARK:- getData API Service call
    func getData()
    {
        startAnimating()
        APIManager.sharedInstance.getData(onSuccess: { data in
            DispatchQueue.main.async {
                do {
                    let jsonDecoder = JSONDecoder()
                    self.mainData = try jsonDecoder.decode(MainModel.self, from: data)
                    DispatchQueue.main.async {
                        self.navigationItem.title = self.mainData?.title
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                        self.stopAnimating()
                    }
                } catch {
                    self.showAlert("Error", error.localizedDescription,"Dismiss")
                }
            }
        }, onFailure: { error in
            self.showAlert("Error", error.localizedDescription,"Dismiss")
        })
    }
}

//MARK:- tableview
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    //MARK: tableview : numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    //MARK: tableview : numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainData?.rows?.count == 0 {
            noDataLabel.isHidden = false
        } else {
            noDataLabel.isHidden = true
        }
        return mainData?.rows?.count ?? 0
    }
    
    //MARK: tableview : cellForRowAtIndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowsTableViewCell
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectionStyle = .none
        if mainData?.rows?[indexPath.row].title != nil
        {
            let url = URL(string: "\(mainData?.rows?[indexPath.row].imageHref ?? "")")
            let imagep = #imageLiteral(resourceName: "placeholderimage")
            cell.imageRefView.sd_setImage(with: url, placeholderImage: imagep, options: [], completed: nil)
            cell.titleLabel.text = mainData?.rows?[indexPath.row].title?.uppercased()
            cell.descriptionLabel.text = mainData?.rows?[indexPath.row].description
        } else {
            cell.mainBgView.removeFromSuperview()
        }
        return cell
    }
    
    //MARK: tableview - heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
      
        if mainData?.rows?[indexPath.row].title == nil
        {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    //MARK: tableview - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //toggleRows
    }
    
    //MARK: tableview - calculateHeight of Cell
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes = NSDictionary.init(object: UIFont.systemFont(ofSize: 15.0), forKey:NSAttributedString.Key.font as NSCopying)
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes as? [NSAttributedString.Key : Any])
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
}

//MARK:- tableview - for RefreshControl
public extension UITableView {

    private var myRefreshControl: RefreshControl? { return refreshControl as? RefreshControl }

    func addRefreshControll(actionTarget: AnyObject?, action: Selector, replaceIfExist: Bool = false) {
        if !replaceIfExist && refreshControl != nil { return }
        refreshControl = RefreshControl(actionTarget: actionTarget, actionSelector: action)
    }

    func scrollToTopAndShowRunningRefreshControl(changeContentOffsetWithAnimation: Bool = false) {
        myRefreshControl?.refreshActivityIndicatorView()
        guard   let refreshControl = refreshControl,
                contentOffset.y != -refreshControl.frame.height else { return }
        setContentOffset(CGPoint(x: 0, y: -(refreshControl.frame.height + 75)), animated: changeContentOffsetWithAnimation)
    }

    private var canStartRefreshing: Bool {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else { return false }
        return true
    }

    func startRefreshing() {
        guard canStartRefreshing else { return }
        myRefreshControl?.generateRefreshEvent()
    }

    func pullAndRefresh() {
        guard canStartRefreshing else { return }
        scrollToTopAndShowRunningRefreshControl(changeContentOffsetWithAnimation: true)
        myRefreshControl?.generateRefreshEvent()
    }

    func endRefreshing(deadline: DispatchTime? = nil) { myRefreshControl?.endRefreshing(deadline: deadline) }
}
