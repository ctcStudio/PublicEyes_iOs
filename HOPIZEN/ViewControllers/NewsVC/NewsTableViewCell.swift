//
//  NewsTableViewCell.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvDateTime: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var btnShow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateView(campaign: CampaignModel) -> Void {
        self.tvTitle.text = campaign.tile
        self.tvDateTime.text = campaign.fromDate ?? "" + " ~ " + campaign.toDate! ?? ""
        self.tvContent.text = campaign.content
        if(campaign.image != nil && campaign.image?.isEmpty == false) {
            let url = URL.init(string: getImageUrl(path: campaign.image!))
            self.imgBanner.setImageWith(url!)
            self.imgBanner.contentMode = .scaleAspectFit
        }
    }
    
    @IBAction func showContent(_ sender: Any) {
        
    }
}
