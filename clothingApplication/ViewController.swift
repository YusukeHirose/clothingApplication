//
//  ViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    let photos = ["ayala","itpark","oslob","domitory","moalboal"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        return 5;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
