//
//  want2ViewController.swift
//  clothingApplication
//
//  Created by User on 2017/03/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
import Photos


class want2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var wantArray: [NSDictionary] = []
    var wantDic: NSDictionary! = [:]
    var myWant = NSArray() as! [String]
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var selectedImageURL: String!
    var selectedName: String!
    var selectedDate: Date!
    var selectedRating: Int!
    
    var scSelectedDate = NSDate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var navBarImage = UIImage(named: "ki.jpeg") as UIImage?
        
        self.navigationController?.navigationBar.setBackgroundImage(navBarImage,for:.default)
        
    

           }
    
    
   
    //既に存在するデータの読み込み処理
    func read() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //AppDelegateを使う用意をする
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //どのエンティティからdataを取得してくるか設定
        let query:NSFetchRequest<User> = User.fetchRequest()
        
        do{
            //データを一括取得
            var fetchResults = try viewContext.fetch(query)
            print(fetchResults.count)
            //データの取得
            //一旦配列を空っぽにする（初期化する）→そうしないとどんどん、TableViewに表示されてしまう。
            wantArray = NSArray() as! [NSDictionary]
            //nilが入るかもしれないのでasに?をつける。
            for result: AnyObject in fetchResults {
                
                let wantname:String? = result.value(forKey: "wantname") as? String
                let wantbland:String? = result.value(forKey: "wantbland") as? String
                let date: String? = result.value(forKey: "date") as? String
                let img: String? = result.value(forKey: "img") as? String
                let wantprice: String? = result.value(forKey: "wantprice") as? String
                
                wantDic = ["wantname":wantname, "date":date, "wantbland":wantbland, "img":img, "wantprice":wantprice]
                wantArray.append(wantDic)
                print(wantArray)
                
            }
        } catch {
        }
        //TableViewの再描画
        myTableView.reloadData()
    }

    //こっちは表示されるたびに出力される
    override func viewWillAppear(_ animated: Bool) {
        read()
    }
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wantArray.count
    }
    
    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! tableCell
        
        //とってきてるのはディクショナリー型なのでディクショナリーで変換する
        var wantDic = wantArray[indexPath.row] as! NSDictionary
        cell.wantName.text = wantDic["wantname"] as!String
        cell.wantBlandName.text = wantDic["wantbland"]as!String
        cell.wantPrice.text = wantDic["wantprice"]as!String
        
        
        
        
        //画像
        var imgDic = wantArray[indexPath.row] as! NSDictionary
        
        var AImage: UIImage!
        if imgDic["img"] as? String == "" {
            cell.wantImage.image = UIImage(named: "noimages.png")
            
        } else {
            
            let url = URL(string: (imgDic["img"] as! NSString) as String)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                //                        self.cell.tableMyImg.image = image
                AImage = image
                
            }
            cell.wantImage.image = AImage
        }
        
        //        //日付
        //        let formatter: DateFormatter = DateFormatter()
        //        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        //
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
