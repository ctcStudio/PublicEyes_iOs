//
//  ComplaintTableViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ComplaintTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "complaintCell"
    var complaintModels: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.getListComplaint()
        
        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: "ComplaintTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    func clickBack(_ sender:UIButton!){
        HPZMainFrame.showHomeVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getListComplaint() {
        HPZWebservice.shareInstance.getUserInfo(path:API_GET_COMPLAINT,params:NSDictionary(),handler:{success , response in
            if(success) {
                if(response?.isKind(of: ListComplaintModel.self))!{
                    let listComplaint:ListComplaintModel = response as! ListComplaintModel
                    if(listComplaint.code == 0) {
                        if(listComplaint.complaintList.count != 0) {
                            self.complaintModels = listComplaint.complaintList
                            self.tableView.reloadData()
                        }
                        return
                    } else {
                        let alert = UIAlertController(title: "Alert", message: listComplaint.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, entity:ListComplaintModel())
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return complaintModels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ComplaintTableViewCell
        
        let complaint = complaintModels.object(at: indexPath.row) as! ComplaintModel
        cell.updateView(complaint: complaint)
        return cell
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
