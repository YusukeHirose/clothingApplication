//
//  ViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
class TopsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
   
    

    
    // 画面が表示されたとき
    override func viewWillAppear(_ animated: Bool) {
         //Appdelegateにアクセスするための準備
        //let myApp = UIApplication.shared.delegate as! AppDelegate
    }
    
    //let photos = ["ayala","moalboal","oslob"]
    var photList2 = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var myDefault = UserDefaults.standard
        
        if(myDefault.object(forKey: "photList") != nil){
            //データを呼び出す
            photList2 = NSMutableArray(array:myDefault.object(forKey: "photList") as! NSMutableArray)
        }
        
        
    }
    
    
    var selectedImage: UIImage?
    


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
//        // Cell はストーリーボードで設定したセルのID
       let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//      
//        // Tag番号を使ってImageViewのインスタンス生成
     let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
//      // 画像配列の番号で指定された要素の名前の画像をUIImageとする
      let cellImage = UIImage(named: [(indexPath as NSIndexPath).row])
//       // UIImageをUIImageViewのimageとして設定
       imageView.image = cellImage
//
        var photListDate:NSDictionary = photList2[indexPath.Item] as! NSDictionary
        //sample45から
        var photListDictionary:NSDictionary = photList2[indexPath.row] as! NSDictionary
        return testCell
    }
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = UIImage(named: photo[(indexPath as NSIndexPath).row])
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

