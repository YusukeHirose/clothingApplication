//
//  wantEditViewController.swift
//  clothingApplication
//
//  Created by User on 2017/03/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
import Photos

class wantEditViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var photImageView: UIImageView!
    
    @IBOutlet weak var wantTextField: UITextField!
    
    @IBOutlet weak var blandTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    var myTextField = NSArray() as! [String]
    var strURL: String = ""
    var textView: UITextView!
    //var selectedRating: Int!
    //    受け取り用の変数
    var scSelectedDate = NSDate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var navBarImage = UIImage(named: "ki.jpeg") as UIImage?
        
        self.navigationController?.navigationBar.setBackgroundImage(navBarImage,for:.default)


        photImageView.image = UIImage(named: "noimages.png")

        let upView = UIView()
        upView.frame.size.height = 60//高さ配置
        upView.backgroundColor = UIColor.lightGray
        
        //閉じるボタンを作成
        let closeButton = UIButton(frame: CGRect(x: self.view.bounds.width - 70,y:0,width: 70,height: 50))
        closeButton.setTitle("閉じる", for: .normal)
        
        //閉じるボタンにイベントを設定
        closeButton.addTarget(self ,action: #selector(closeKeyboad(sender:)), for: .touchUpInside)
        
        //ビューに閉じるボタンを追加
        upView.addSubview(closeButton)
        //キーボードのアクセサリービューを設定する
        wantTextField.inputAccessoryView = upView
        blandTextField.inputAccessoryView = upView
        priceTextField.inputAccessoryView = upView
        
        
        read()

        
           }
    
    //キーボードを閉じる
    func closeKeyboad(sender:UIButton){
        
        wantTextField.resignFirstResponder()
        blandTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //キーボードが立ち上がるとき
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print(textField.tag)
        switch textField.tag {
        case 1:
            //商品名記入欄の表示
            return true
        case 2:
            return true
        case 3:
            return true
        default:
            return true
        }
    }

    //編集後の操作
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        print(textField.tag)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    //カメラロールで選択された後の処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        

        // Set photoImageView to display the selected image.
        photImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        
        
        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
        
        strURL = assetURL.description
        if strURL != "" {
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 500, height: 500),contentMode: .aspectFit,options: nil) { (image, info) -> Void in
                self.photImageView.image = image
                //閉じる処理
                picker.dismiss(animated: true, completion: nil)
                
            }
        }
    }

    //MARK: バリデーション（空白の確認）
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = wantTextField.text ?? ""
        let text2 = blandTextField.text ?? ""
        let text3 = priceTextField.text ?? ""
        // saveButton.isEnabled = !text.isEmpty
    }
    
    //MARK: Navigation
    
//    @IBAction func cancel(_ sender: UIBarButtonItem) {
//       
//       let next = storyboard!.instantiateViewController(withIdentifier: "want2ViewController")
//        self.dismiss(animated: true, completion: nil)
//
//       
// 
//        
//    }

    //MARK: 画像を選択したとき
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        wantTextField.resignFirstResponder()
        // 画像タップでライブラリを呼び出す
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let picker = UIImagePickerController()
           // picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self // UINavigationControllerDelegate と　UIImagePickerControllerDelegateを実装する
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //トリミング
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
        
        
    }

    //データの保存
    
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //UserDateエンティティオブジェクトの作成
        let user = NSEntityDescription.entity(forEntityName:"User",in:viewContext)
        //UserDateエンティティにレコード(行)を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: user!, insertInto: viewContext)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        //日付を文字列に変換
        var scSelectedDate = df.string(from:Date())
        
        //値のセット
        newRecord.setValue(wantTextField.text ?? String(), forKey: "wantname")
        newRecord.setValue(scSelectedDate, forKey: "date")
        newRecord.setValue(blandTextField.text ?? String(), forKey: "wantbland")
        newRecord.setValue(strURL, forKey: "img")
        newRecord.setValue(priceTextField.text ?? String(), forKey: "wantprice")
        //例外処理
        do{
            //レコード（行）の即時保存
            try viewContext.save()
            
            //前の画面に戻る
            // navigationController?.popViewController(animated: true)
        } catch {
        }
        let next = storyboard!.instantiateViewController(withIdentifier: "want2ViewController")
        self.dismiss(animated: true, completion: nil)
        

        
        read()
    }
}

//既に存在するデータの読み込み処理
func read() {
    //AppDelegateを使う用意をする
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを作成
    let viewContext = appDelegate.persistentContainer.viewContext
    
    //どのエンティティからdataを取得してくるか設定
    let query:NSFetchRequest<User> = User.fetchRequest()
    
    do{
        //データを一括取得
        //データを一括取得
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "date")
        // query.predicate = NSPredicate(format:"date = %@", scSelectedDate)
        
        let fetchResults = try viewContext.fetch(query)
        
        
        print(fetchResults.count)
        
        //nilが入るかもしれないのでasに?をつける。
        for result: AnyObject in fetchResults {
            
            let wantname:String? = result.value(forKey: "wantname") as? String
            let wantbland:String? = result.value(forKey: "wantbland") as? String
            let scSelectedDate: String? = result.value(forKey: "date") as? String
            let img: String? = result.value(forKey: "img") as? String
            let wantprice: String? = result.value(forKey: "wantprice") as? String
            
        }
    } catch {
    }
    //TableViewの再描画
    //        myTableView.reloadData()
}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


