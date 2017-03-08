//
//  TabBarController.swift
//  clothingApplication
//
//  Created by User on 2017/02/12.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //レンダリングモードをAlwaysOriginalでボタンの画像を登録する。
        tabBar.items![0].image = UIImage(named: "Clothes-50.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![2].image = UIImage(named: "Player Change-50.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
       tabBar.items![1].image = UIImage(named: "Add to Favorites-50.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //tabBar.items![3].image = UIImage(named: "Screenshot-50.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

    


        // Do any additional setup after loading the view.
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
