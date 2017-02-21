//
//  ViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // インスタンス配列
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?
    
    // サイト情報
    let category:[Dictionary<String,String>] = [
        ["title":"トップス","storyboadID":"ViewController"],
        ["title":"パンツ"],
        ["title":"ジャケット"],
        ["title":"パンツ"],
        ["title":"シューズ"]
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for site in category {
            
            var storyboardID:String = site["storyboadID"]!
            switch storyboardID{
                case "topsViewController":
                    var controller:topsViewController = self.storyboard?.instantiateInitialViewController(withIdentifier:"topsViewController") as! topsViewController
                
                    controller.title = site["title"]!
                contorllerArray.append(controller)
            default:
                var controller:ContentsViewController = ContentsViewController(nibName:"ContentsViewController",bundle:nil)
                controller.title = site["title"]!
                
                controller.webView = UIWebView(frame : self.view.bounds)
                //controller.webView.delegate = controller
                controller.view.addSubview(controller.webView)
                //let req = URLRequest(url: URL(string:controller.siteUrl!)!)
                // controller.webView.loadRequest(req)
                controllerArray.append(controller)


            }
            
                        //controller.siteUrl = site["url"]!
            
            
            
        }
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.black),
            .viewBackgroundColor(UIColor.white),
            .bottomMenuHairlineColor(UIColor.white),
            .selectionIndicatorColor(UIColor.blue),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 20.0)!),
            .centerMenuItems(true),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .menuMargin(16),
            .selectedMenuItemLabelColor(UIColor.blue),
            .unselectedMenuItemLabelColor(UIColor.white)
            
        ]
        
        // Initialize scroll menu
        
        let rect = CGRect(origin: CGPoint(x: 0,y :25), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: rect, pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
        
        }
    

    

    
    // 画面が表示されたとき
    override func viewWillAppear(_ animated: Bool) {
         //Appdelegateにアクセスするための準備
        //let myApp = UIApplication.shared.delegate as! AppDelegate
    }
    
    let photos = ["ayala","moalboal","oslob"]
    
    var selectedImage: UIImage?
    
    
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: photos[(indexPath as NSIndexPath).row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        
        
        return testCell
    }
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = UIImage(named: photos[(indexPath as NSIndexPath).row])
        if selectedImage != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toEditViewController",sender: nil)
        }
        
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toEditViewContlloer") {
            let subVC: EditViewController = (segue.destination as? EditViewController)!
            // EditViewController のselectedImgに選択された画像を設定する
            subVC.selectedImg = selectedImage
        }
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGFloat = self.view.frame.size.width/2-2
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 3;
    }
    
    
            override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

