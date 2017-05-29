//
//  CategoryTableViewCell.swift
//  PublicEyes
//
//  Created by HungHN on 5/28/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCategory: UIImageView!
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
        if(category.image != nil && (category.image?.isEmpty)!) {
            let url = URL.init(string: getImageUrl(path: category.image!))
            imgCategory.setImageWith(url!, placeholderImage: UIImage.init(named: "ic_photo"))
        }
    }
    
}
