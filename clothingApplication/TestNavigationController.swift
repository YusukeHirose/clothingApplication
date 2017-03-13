//
//  TestNavigationController.swift
//  clothingApplication
//
//  Created by User on 2017/03/10.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class TestNavigationController: UINavigationController ,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        //デリゲート先に自分を設定する。
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    //画面遷移後の呼び出しメソッド
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        //ナビゲーションバーの背景画像を設定する。
        self.navigationBar.setBackgroundImage(UIImage(named: "ki.jpeg"), for: .default)
        
        //ナビゲーションバーのシャドウイメージを設定する。
        self.navigationBar.shadowImage = UIImage(named: "ki.jpeg")
        
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
