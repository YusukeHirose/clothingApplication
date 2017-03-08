//
//  PantsViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/20.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
import Photos

class outerViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //画像ボタン作成
    let image : UIImage = UIImage(named:"toNewEdit.png")!
    
    // 画面の横幅を取得
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    // UIButton のインスタンスを生成
    let button = UIButton()
    
    // 画面が表示されたとき
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //let photos = ["ayala","moalboal","oslob"]
    var photList2 = NSMutableArray()
    
    
    
    
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
        
        
        
        
        let myDefault = UserDefaults.standard
        
        photList2[0] = ["phot":"noimages.png","date":"2017/02/26"]
        
        print(photList2)
        
        read()
        
    }
    
    func buttonTapped(sender: UIButton){
        let next = storyboard!.instantiateViewController(withIdentifier: "NewEditViewController")
        self.present(next,animated: true, completion: nil)
        
    }
    
    //すでに存在するデータの読み込み処理
    func read(){
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        //どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<UserDate> = UserDate.fetchRequest()
        query.predicate = NSPredicate(format:"category = %@","アウター")
        do{
            //データを一括取得
            let fetchResults = try viewContext.fetch(query)
            //一旦配列を空にする(初期化)
            photList2 = NSMutableArray()
            for result : AnyObject in fetchResults{
                var photDate: String? = result.value(forKey: "phot") as? String
                var dateDate: String? = result.value(forKey: "created_at") as? String
                var categoryDate: String? = result.value(forKey: "category") as? String
                photList2.add(["phot":photDate,"created_at": dateDate,"category": categoryDate])

            }
            
        }catch{
            
        }
        
        
    }
    
    var selectedImage: String = ""
    var selectedDt : String = ""
    var count = 0
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        //        // Cell はストーリーボードで設定したセルのID
        var testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as! UIImageView
        //      // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        //
        
        var photListDate:NSDictionary = photList2[indexPath.row] as! NSDictionary
        //sample45から
        var phot:String = photListDate["phot"] as! String
        
        var cellImage = UIImage(named: phot)
        //        //       // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        //q
        //
        //  var photListDictionary:NSDictionary = photList2[indexPath.row] as! NSDictionary
        
        
        //        // ユーザーデフォルトを用意する
        //        let myDefault = UserDefaults.standard
        //
        //        // データを取り出す
        //        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        //
        if phot != nil{
            
            let url = URL(string: phot as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                imageView.image = image
                self.count += 1
            }
            
        }else{
            imageView.image = UIImage(named: "noimages.png")
        }
        return testCell
        
        
    }
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var photListDate:NSDictionary = photList2[indexPath.row] as! NSDictionary
        //sample45から
        var phot:String = photListDate["phot"]! as! String
        var date:String = photListDate["created_at"]! as! String
        // var phot:String = photList2[indexPath.row] as! String
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage =  phot
        selectedDt = date
        print(selectedDt)
        if (selectedImage != nil) && (selectedDt != nil) {
            //  SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toEditViewController",sender: nil)
        }
        
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toEditViewController") {
            let subVC: EditViewController = (segue.destination as? EditViewController)!
            // EditViewController のselectedImgに選択された画像を設定する
            subVC.selectedImg = selectedImage
            subVC.selectedCD = selectedDt
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
        return photList2.count;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


