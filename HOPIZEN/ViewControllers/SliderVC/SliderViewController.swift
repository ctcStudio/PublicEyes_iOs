//
//  SliderViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var doneSlider: UIButton!
    @IBOutlet weak var skipSlider: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        doneSlider.layer.cornerRadius = 0.5 * doneSlider.bounds.size.width
        doneSlider.clipsToBounds = true
        
        let scrollViewWidth:CGFloat = screenWidth
        let scrollViewHeight:CGFloat = screenHeight - statusBarHeight
        
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "bg_slider_1")
        imgOne.contentMode = .scaleAspectFit
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "bg_slider_2")
        imgTwo.contentMode = .scaleAspectFit
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "bg_slider_3")
        imgThree.contentMode = .scaleAspectFit
        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgFour.image = UIImage(named: "bg_slider_4")
        imgFour.contentMode = .scaleAspectFit
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
        
        self.scrollView.contentSize = CGSize(width:scrollViewWidth * 4, height:scrollViewHeight)
        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.scrollView.delegate = self
        
        self.pageControl.currentPage = 0
        self.skipSlider.isHidden = false
        self.doneSlider.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        if(pageControl.currentPage == 3) {
            self.skipSlider.isHidden = true
            self.doneSlider.isHidden = false
        } else {
            self.skipSlider.isHidden = false
            self.doneSlider.isHidden = true
        }
    }
    @IBAction func skip(_ sender: Any) {
        HPZMainFrame.showHomeVC()
    }
    @IBAction func done(_ sender: Any) {
        HPZMainFrame.showHomeVC()
    }
}
