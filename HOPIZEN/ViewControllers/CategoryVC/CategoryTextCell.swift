//
//  CategoryTextCell.swift
//  PublicEyes
//
//  Created by HungHN on 7/1/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class CategoryTextCell: UITableViewCell {

    @IBOutlet weak var tvDescription: UILabel!
    @IBOutlet weak var tvCategogy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateView(category: CategoryModel) -> Void {
        tvCategogy.text = category.name
        tvDescription.text = category.cateDescription
    }
    
}
