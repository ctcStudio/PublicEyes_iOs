//
//  CategoryTableViewController.swift
//  PublicEyes
//
//  Created by HungHN on 5/28/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    static let TYPE_CAR:Int = 0;
    static let TYPE_MOTOR:Int = 1;
    
    var image:UIImage?
    var videoUrl:NSURL?
    var path:String!
    var des: String!
    var type: Int!
    
    let reuseIdentifier = "categoryTextCell"
    
    //var categoryList:NSMutableArray = []
    var categoryTextList:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loại vi phạm"
        // self.getListCampaign()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.register(UINib.init(nibName: "CategoryTextCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 90
        
        HPZMainFrame.addBackBtn(target: self, action: #selector(clickBack(_:)))
        
        if(type == CategoryTableViewController.TYPE_CAR) {
            for index in 0..<categoryCarName.count {
                let model = CategoryModel()
                model.name = categoryCarName[index]
                model.cateDescription = categoryCarDes[index]
                model.id = index
                categoryTextList.add(model)
            }
        } else {
            for index in 0..<categoryMotorName.count {
                let model = CategoryModel()
                model.name = categoryMotorName[index]
                model.cateDescription = categoryMotorDes[index]
                model.id = index
                categoryTextList.add(model)
            }
        }
    }
    
    func clickBack(_ sender:UIButton!){
        if(image != nil) {
            HPZMainFrame.showSelectCategoryPhoto(image: image!, path: path, des: des)
        } else if(videoUrl != nil) {
            HPZMainFrame.showSelectCategoryVideo(videoUrl: videoUrl!, path: path, des: des)
        } else{
            HPZMainFrame.showHomeVC()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        SVProgressHUD.dismiss()
    }
    
//    func getListCampaign() {
//        SVProgressHUD.show()
//        HPZWebservice.shareInstance.getUserInfo(path:API_GET_CATEGORY,params:NSDictionary(),handler:{success , response in
//            SVProgressHUD.dismiss()
//            if(success) {
//                if(response?.isKind(of: ListCategoryModel.self))!{
//                    let list:ListCategoryModel = response as! ListCategoryModel
//                    if(list.code == 0) {
//                        if(list.categoryList.count != 0) {
//                            self.categoryList = list.categoryList
//                            self.tableView.reloadData()
//                        }
//                        return
//                    } else {
//                        let alert = UIAlertController(title: "Alert", message: list.message, preferredStyle: UIAlertControllerStyle.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }
//            }
//            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            
//        }, entity:ListCategoryModel())
//        
//    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryTextList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CategoryTextCell
        
        // Configure the cell...
        let category = categoryTextList.object(at: indexPath.row) as!CategoryModel
        cell.updateView(category: category)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var pos:Int = indexPath.row
//        if(pos > categoryList.count) {
//            pos = categoryList.count - 1
//        }
//        let category = categoryList.object(at: pos) as!CategoryModel
        let category = categoryTextList.object(at: indexPath.row)  as!CategoryModel
        let isVideo = (image != nil)
        HPZMainFrame.showLocation(type:type, category: category, path: path, des: des, isVideo:isVideo)
    }
    
    let categoryMotorName:[String] = [
        "Lỗi Điều khiển xe máy không đội “mũ bảo hiểm cho người đi mô tô, xe máy”",
        "Chở người ngồi trên xe không đội mũ bảo hiểm hoặc đội mà cài quai không đúng quy cách",
        "Chở 2 người trên xe",
        "Chở theo 3 người trở lên trên xe",
        "Không giữ khoảng cách an toàn để xảy ra va chạm với xe chạy liền trước hoặc không giữ khoảng cách theo quy định của biển báo hiệu “Cự ly tối thiểu giữa hai xe”",
        "Đi vào đường cao tốc không dành cho xe máy",
        "Sử dụng ô, điện thoại di động, thiết bị âm thanh",
        "Vượt đèn đỏ",
        "Vượt đèn vàng khi sắp chuyển sang đèn đỏ",
        "Chuyển làn đường không đúng nơi được phép hoặc không có tín hiệu báo trước",
        "Quay đầu xe tại nơi cấm quay đầu xe",
        "Điều khiển xe máy khi chưa đủ 16 tuổi",
        "Từ 16 tuổi đến dưới 18 tuổi điều khiển xe mô tô từ 50cm3 trở lên",
        "Điều khiển dưới 175cm3 không có GPLX, sử dụng GPLX không do cơ quan có thẩm quyền cấp, GPLX hoặc bị tẩy xóa",
        "Điều khiển xe từ 175cm3 trở lên không có GPLX, sử dụng GPLX không do cơ quan có thẩm quyền cấp hoặc bị tẩy xóa",
        "Không mang theo Giấy phép lái xe",
        "Điều khiển xe không có Giấy đăng ký xe",
        "Sử dụng Giấy đăng ký xe bị tẩy xóa; Không đúng số khung, số máy hoặc không do cơ quan có thẩm quyền cấp",
        "Không có hoặc không mang theo Giấy chứng nhận bảo hiểm TNDS của chủ xe cơ giới",
        "Không chấp hành hiệu lệnh, chỉ dẫn của biển báo hiệu, vạch kẻ đường",
        "Điều khiển xe chạy quá tốc độ quy định từ 5km/h đến dưới 10km/h",
        "Không sử dụng đủ đèn chiếu sáng khi trời tối hoặc khi sương mù, thời tiết xấu hạn chế tầm nhìn; sử dụng đèn chiếu xa khi tránh xe đi ngược chiều",
        "Không chấp hành hiệu lệnh của đèn tín hiệu giao thông",
        "Đi vào đường cấm, khu vực cấm; đi ngược chiều của đường một chiều, đường có biển “Cấm đi ngược chiều”; trừ các xe ưu tiên đang đi làm nhiệm vụ khẩn cấp theo quy định",
        "Điều khiển xe không đi bên phải theo chiều đi của mình; đi không đúng phần đường hoặc làn đường quy định",
        "Điều khiển xe chạy dưới tốc độ tối thiểu trên những đoạn đường bộ có quy định tốc độ tối thiểu cho phép",
        "Không chấp hành hiệu lệnh, hướng dẫn của người điều khiển giao thông hoặc người kiểm soát giao thông",
        "Điều khiển xe trên đường mà trong máu hoặc hơi thở có nồng độ cồn nhưng chưa tới mức vi phạm quy định",
        "Điều khiển xe chạy quá tốc độ quy định trên 20 km/h",
        "Gây tai nạn giao thông không dừng lại, không giữ nguyên hiện trường, bỏ trốn không đến trình báo với cơ quan có thẩm quyền, không tham gia cấp cứu người bị nạn",
        "Điều khiển xe trên đường mà trong máu hoặc hơi thở có nồng độ cồn vượt quá 50 miligam đến 80 miligam/100 mililít máu hoặc vượt quá 0,25 miligam đến 0,4 miligam/1 lít khí thở\n",
        "Điều khiển xe lạng lách, đánh võng; chạy quá tốc độ đuổi nhau trên đường bộ gây tai nạn giao thông hoặc không chấp hành hiệu lệnh dừng xe của người thi hành công vụ",
        "Bấm còi, rú ga liên tục; bấm còi hơi, sử dụng đèn chiếu xa trong đô thị, khu đông dân cư, trừ các xe ưu tiên đang đi làm nhiệm vụ theo quy định",
        "Điều khiển xe trên đường mà trong cơ thể có chất ma túy",
        "Người không chấp hành yêu cầu kiểm tra chất ma túy, nồng độ cồn của người kiểm soát giao thông hoặc người thi hành công vụ",
        "Điều khiển xe lạng lách, đánh võng trên đường bộ trong, ngoài đô thị",
        "Điều khiển xe chạy quá tốc độ quy định từ 10 km/h đến 20 km/h"
    ]
    let categoryMotorDes:[String] = [
        "100.000 - 200.000",
        "100.000 - 200.000",
        "100.000 - 200.000",
        "200.000 - 400.000",
        "60.000 - 80.000",
        "200.000 - 400.000",
        "60.000 – 80.000",
        "200.000 - 400.000",
        "100.000 - 200.000",
        "80.000 - 100.000",
        "80.000 - 100.000",
        "cảnh cáo",
        "400.000 - 600.000",
        "800.000 - 1.200.000, tịch thu GPLX",
        "4.000.000 - 6.000.000, tịch thu GPLX",
        "80.000 - 120.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "80.000 - 120.000",
        "60.000 - 80.000",
        "100.000 - 200.000",
        "80.000 - 100.000",
        "200.000 - 400.000",
        "200.000 - 400.000",
        "100.000 - 200.000",
        "200.000 - 400.000",
        "200.000 - 400.000",
        "400.000 - 600.000",
        "2.000.000 - 3.000.000",
        "1.000.000 - 3.000.000",
        "500.000 - 1.000.000, Thu GPLX",
        "100.000 - 200.000",
        "200.000 - 400.000",
        "2.000.000 - 3.000.000",
        "2.000.000 - 3.000.000",
        "5.000.000 - 7.000.000",
        "400.000 - 600.000"
    ]
    let categoryCarName:[String] = [
        "Không chấp hành hiệu lệnh, chỉ dẫn của biển báo hiệu, vạch  kẻ đường",
        "Khi dừng xe, đỗ xe không có tín hiệu báo cho người điều khiển phương tiện khác biết",
        "Bấm còi hoặc gây ồn ào, tiếng động lớn trong đô thị, khu đông dân cư từ 22 giờ ngày hôm trước đến 5 giờ ngày hôm sau",
        "Người điều khiển, người được chở trên xe ô tô có trang bị dây an toàn mà không thắt dây an toàn khi xe đang chạy",
        "Chuyển làn đường không đúng nơi cho phép hoặc không có tín hiệu báo trước",
        "Chở người trên buồng lái quá số lượng quy định",
        "Không giảm tốc độ và nhường đường khi điều khiển xe chạy từ trong ngõ, đường nhánh ra đường chính",
        "Xe lắp thiết bị phát tín hiệu sai quy định hoặc sử dụng thiết bị phát tín hiệu mà không có giấy phép\n",
        "Dừng xe sai quy định (dừng trên phần đường xe chạy, dừng xe không sát lề đường, hè phố phía bên phải, dừng xe trên miệng cống thoát nước, miệng hầm đường điện thoại...)",
        "Quay đầu xe trái quy định trong khu dân cư, quay đầu xe ở phần đường dành cho người đi bộ, trên cầu, đầu cầu, gầm cầu vượt... hoặc những nơi có biển báo Cấm quay đầu xe",
        "Lùi xe ở đường một chiều, đường cầm đi ngược chiều, khu vực cấm dừng,... Lùi xe không quan sát hoặc không có tín hiệu báo trước",
        "Điều khiển xe có liên quan trực tiếp đến vụ tai nạn giao thông mà không dừng lại, không giữ nguyên hiện trường, không tham gia cấp cứu người bị nạn",
        "Điều khiển xe chạy quá tốc độ quy định từ 05 km/h đến dưới 10 km/h",
        "Chuyển hướng không giảm tốc độ hoặc không có tín hiệu báo hướng rẽ",
        "Không sử dụng đủ đèn chiếu sáng từ 19 giờ ngày hôm trước đến 06 giờ sáng ngày hôm sau hoặc khi sương mù, thời tiết xấu hạn chế tầm nhìn; sử dụng đèn chiếu xa khi tránh xe đi ngược chiều",
        "Dùng tay sử dụng điện thoại di động khi đang điều khiển xe",
        "Chạy trong hầm đường bộ không sử dụng đèn chiếu sáng gần; lùi xe, quay đầu xe, dừng xe, đỗ xe, vượt xe trong hầm đường bộ không đúng nơi quy định",
        "Đi ngược chiều, đi vào đường cấm, khu vực cấm",
        "Điều khiển xe chạy dưới tốc độ tối thiểu trên những đoạn đường bộ có quy định tốc độ tối thiểu cho phép",
        "Không chấp hành hiệu lệnh, hướng dẫn của người điều khiển giao thông, đèn tín hiệu giao thông",
        "Vượt trong các trường hợp cấm vượt; không có báo hiệu trước khi vượt; vượt bên phải xe khác trong trường hợp không được phép",
        "Tránh xe đi ngược chiều không đúng quy định; không nhường đường cho xe đi ngược chiều theo quy định tại nơi đường hẹp, đường dốc, nơi có chướng ngại vật",
        "Chạy quá tốc độ quy định từ 10 km/h đến 20 km/h",
        "Điều khiển xe chạy quá tốc độ quy định trên 20 km/h đến 35 km/h",
        "Gây tai nạn giao thông không dừng lại, không giữ nguyên hiện trường, bỏ trốn, không tham gia cấp cứu người bị nạn",
        "Điều khiển xe chạy quá tốc độ quy định trên 35 km/h; điều khiển xe đi ngược chiều trên đường cao tốc",
        "Điều khiển xe trên đường mà trong máu hoặc hơi thở có nồng độ cồn vượt quá 50 miligam đến 80 miligam/100 mililít máu hoặc vượt quá 0,25 miligam đến 0,4 miligam/1 lít khí thở",
        "Không chấp hành yêu cầu kiểm tra về chất ma túy, nồng độ cồn của người kiểm soát giao thông hoặc người thi hành công vụ"
    ]
    let categoryCarDes:[String] = [
        "150.000 - 250.000",
        "150.000 - 250.000",
        "150.000 - 250.000",
        "150.000 - 250.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "300.000 - 400.000",
        "600.000 - 800.000",
        "600.000 - 800.000",
        "600.000 - 800.000",
        "600.000 - 800.000",
        "800.000 - 1.200.000",
        "800.000 - 1.200.000",
        "800.000 - 1.200.000",
        "800.000 - 1.200.000, Tước 1-3 tháng",
        "2.000.000 - 3.000.000",
        "2.000.000 - 3.000.000",
        "3.000.000 - 5.000.000",
        "5.000.000 - 7.000.000, Tước 1-3 tháng",
        "5.000.000 - 7.000.000, Tước 2-4 tháng",
        "8.000.000 - 12.000.000, Tước 2-4 tháng",
        "8.000.000 - 12.000.000, Tước 4-6 tháng",
        "16.000.000 - 18.000.000, Tước 10-12 tháng"
    ]
}
