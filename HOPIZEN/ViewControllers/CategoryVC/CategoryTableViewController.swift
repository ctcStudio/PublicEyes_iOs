//
//  CategoryTableViewController.swift
//  PublicEyes
//
//  Created by HungHN on 5/28/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    var image:UIImage?
    var videoUrl:NSURL?
    var path:String!
    var des: String!
    
    let reuseIdentifier = "categoryCell"
    
    var categoryList:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loại vi phạm"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.register(UINib.init(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
    }
    
    func clickBack(_ sender:UIButton!){
        if(image != nil) {
            HPZMainFrame.showReportPhoto(image: image!)
        } else if(videoUrl != nil) {
            HPZMainFrame.showReportVideo(videoUrl: videoUrl!)
        } else{
            HPZMainFrame.showHomeVC()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getListCampaign() {
        HPZWebservice.shareInstance.getUserInfo(path:API_GET_CATEGORY,params:NSDictionary(),handler:{success , response in
            if(success) {
                if(response?.isKind(of: ListCategoryModel.self))!{
                    let list:ListCategoryModel = response as! ListCategoryModel
                    if(list.code == 0) {
                        if(list.categoryList.count != 0) {
                            self.categoryList = list.categoryList
                            self.tableView.reloadData()
                        }
                        return
                    } else {
                        let alert = UIAlertController(title: "Alert", message: list.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:ListCategoryModel())
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CategoryTableViewCell
        
        // Configure the cell...
        let category = categoryList.object(at: indexPath.row) as!CategoryModel
        cell.updateView(category: category)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoryList.object(at: indexPath.row) as!CategoryModel
        HPZMainFrame.showLocation(category: category, path: path, des: des)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
