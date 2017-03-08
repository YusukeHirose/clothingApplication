//
//  HomeViewController.swift
//  clothingApplication
//
//  Created by User on 2017/03/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    //画像ボタン作成
    let image : UIImage = UIImage(named:"toNewEdit.png")!
    
    
    
    // UIButton のインスタンスを生成
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面の横幅を取得
        let screenWidth: CGFloat = self.view.frame.width
        let screenHeight: CGFloat = self.view.frame.height
        
        // 画像を設定
        button.setImage(image, for: .normal)
        
        // Buttonの位置と大きさを設定
        button.frame = CGRect(x:screenWidth/1.3, y:screenHeight/1.5-20, width:70, height:70)
        
        button.alpha = 0.4
        
        // ViewにButtonを追加
        self.view.addSubview(button)
        
        
        //最前面に移動
        self.view.bringSubview(toFront: button)
        
        // タップされたときのactionをセット
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        

        

        initImageView()    }

    
    private func initImageView(){
        // UIImage インスタンスの生成
        let image1:UIImage = UIImage(named:"closet3.jpg")!
        
        // UIImageView 初期化
        let backImageView = UIImageView(image:image1)
        
        // 画面の横幅を取得
        let screenWidth:CGFloat = self.formView.frame.size.width
        let screenHeight:CGFloat = self.formView.frame.size.height
        
        // 画像の幅・高さの取得
        width = image1.size.width
        height = image1.size.height
        
        // 画像サイズをスクリーン幅に合わせる
        scale = screenWidth / width
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        // 画像の中心を画面の中心に設定
        backImageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        // UIImageViewのインスタンスをビューに追加
        self.formView.addSubview(backImageView)
        //画像最背面
        self.formView.sendSubview(toBack: backImageView)
        
        //backImageView.alpha = 0.5
    }
    
    func buttonTapped(sender: UIButton){
        let next = storyboard!.instantiateViewController(withIdentifier: "NewEditViewController")
        self.present(next,animated: true, completion: nil)
        
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
