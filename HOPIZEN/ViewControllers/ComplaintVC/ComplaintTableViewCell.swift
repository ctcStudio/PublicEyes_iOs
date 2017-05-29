//
//  ComplaintTableViewCell.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class ComplaintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtContent: UILabel!
    @IBOutlet weak var tvDate: UILabel!
    @IBOutlet weak var tvAddress: UILabel!
    @IBOutlet weak var imgComplaint: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateView(complaint:ComplaintModel) -> Void {
        self.txtContent.text = complaint.categoryName
        self.tvDate.text = complaint.time
        self.tvAddress.text = complaint.address
        if(complaint.image != nil && complaint.image?.isEmpty == false) {
            let url = URL.init(string: getImageUrl(path: complaint.image!))
            imgComplaint.setImageWith(url!, placeholderImage: UIImage.init(named: "ic_complaint_dummy"))
            self.imgComplaint.contentMode = .scaleAspectFit
        }
    }
    
}
