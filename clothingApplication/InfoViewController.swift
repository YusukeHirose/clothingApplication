//
//  InfoViewController.swift
//  clothingApplication
//
//  Created by User on 2017/03/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

//
//  ViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/20.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {
    
    
    // インスタンス配列
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?
    
    // サイト情報
    let category:[Dictionary<String,String>] = [
        ["title":"ZOZOTOWN","url":"http://zozo.jp/"],
        ["title":"WEAR","url":"http://wear.jp/"],
        ["title":"楽天市場","url":"http://www.rakuten.co.jp/category/mensfashion/?l-id=top_normal_gmenu_m01"],
        ["title":"iLUMINE","url":"https://i.lumine.jp/mens?ranking_type=001"],
        ["title":"ARTIF","url":"http://www.artif.co.jp/"],
        ["title":"ファッションプレス","url":"http://www.fashion-press.net/"],
        ["title":"LOOKBOOK","url":"http://lookbook.nu/"],
        ["title":"KnowerMag","url":"www.neqwsnet-japan.info"],
        ["title":"MENZ-STYLE","url":"http://shop.menz-style.com/"],
        ["title":"SPUTNICKS","url":"http://sputnicks.jp/"],
        ["title":"CAMBIO","url":"http://www.cambio.co.jp/"]
        
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        for site in category {
            
            let controller:ContentsViewController = ContentsViewController(nibName: "ContentsViewController", bundle: nil)
            
            controller.title = site["title"]!
            controller.siteUrl = site["url"]!
            
            controller.webView = UIWebView(frame : self.view.bounds)
            controller.webView.delegate = controller
            controller.view.addSubview(controller.webView)
            let req = URLRequest(url: URL(string:controller.siteUrl!)!)
            controller.webView.loadRequest(req)
            controllerArray.append(controller)
            
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
            .menuMargin(10),
            .selectedMenuItemLabelColor(UIColor.blue),
            .unselectedMenuItemLabelColor(UIColor.white)
            
        ]

        
               // Initialize scroll menu
        
        let rect = CGRect(origin: CGPoint(x: 0,y :60), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: rect, pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
