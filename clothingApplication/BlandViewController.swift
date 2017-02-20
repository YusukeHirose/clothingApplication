//
//  BlandViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/13.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class BlandViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var myCollectionView3: UICollectionView!
    
                        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // 画面が表示されたとき
    override func viewWillAppear(_ animated: Bool) {
        // Appdelegateにアクセスするための準備
        //let myApp = UIApplication.shared.delegate as! AppDelegate
    }
    
    //個数の決定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    //セルに表示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //セルオブジェクトの作成
        let cell:customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! customCell
        
        //タイトルのセット
        cell.backgroundColor = UIColor.white
        
        //画像のセット
        cell.myImageView3.image = UIImage(named: "oslob.jpeg")
        
        //セルを返す
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 2 - 0
        let height: CGFloat = width
        return CGSize(width: width, height: height)
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
