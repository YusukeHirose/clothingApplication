//
//  EditViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/14.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
import Photos
class EditViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var clotheField: UITextField!
    
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var blandField: UITextField!
    
    @IBOutlet weak var sizeField: UITextField!
    
 //   @IBOutlet weak var priceField: UITextField!
    
//    @IBAction func tabBack(_ sender: UIBarButtonItem) {
//    
//            let next = storyboard!.instantiateViewController(withIdentifier: "ViewController")
//        self.present(next,animated: true, completion: nil)
//        
//    }
    
   
    
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
    
    
//    //セグエ遷移(横から画面が出る)
//            performSegue(withIdentifier: "ViewController", sender: nil)
        self.dismiss(animated: true, completion: nil)

        
    }
    
    var selectedImg: String!
    var strURL: String!
    var photlist:[NSDictionary] = NSArray() as! [NSDictionary]
    var selectedCD: String!
    var selectedDate: NSDate = NSDate()
    
    
    @IBOutlet weak var formView: UIView!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x:0,y:720,width:200,height:250))
    let baseView2:UIView = UIView(frame: CGRect(x:0,y:720,width:200,height:250))
    //datePicker(日付編集時)
    let diaryDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x:10,y:20, width:300,height:250))
    let categoryPicker:UIPickerView = UIPickerView(frame: CGRect(x:10,y:20, width:300,height:250))
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)
    let closeBtnCategoryPicker:UIButton = UIButton(type: .system)

    
    var photList = NSMutableArray()
    
    var categoryList = ["トップス","パンツ","ジャケット","アウター","シューズ","キャップ","その他小物"]
    
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var navBarImage = UIImage(named: "ki.jpeg") as UIImage?
        
        //navigationBarに背景画像設定
        self.navigationController?.navigationBar.setBackgroundImage(navBarImage,for:.default)
        
        photList = [["phot":"noimages.png"],["clothename":"黒パーカー"],["size":"S"],["blandname":"ユニクロ"],["date":"2017/02/21"],["category":"パーカー"],["price":"1200"]]
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        

        diaryDatePicker.datePickerMode = .date
        diaryDatePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        //日付が変わったときのイベントをdatePickerに設定
        diaryDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        
        //baseViewにdatePickerを配置
        baseView.addSubview(diaryDatePicker)
        baseView2.addSubview(categoryPicker)
        //位置、大きさを決定
        closeBtnDatePicker.frame = CGRect(x:self.view.frame.width - 60,y:0 ,width:50,height: 20)
        closeBtnCategoryPicker.frame = CGRect(x:self.view.frame.width - 60,y:0 ,width:50,height: 20)
        //タイトルの設定
        closeBtnDatePicker.setTitle("close",for: .normal)
        closeBtnCategoryPicker.setTitle("close",for: .normal)
        //イベントの追加
        closeBtnDatePicker.addTarget(self,action: #selector(closeDatePickerView),for: .touchUpInside)
        closeBtnCategoryPicker.addTarget(self,action: #selector(closeCategoryPickerView),for: .touchUpInside)
        //viewに追加
        baseView.addSubview(closeBtnDatePicker)
        baseView2.addSubview(closeBtnCategoryPicker)
        //下にぴったり配置、横幅ぴったりの大きさにしておく
        //位置
        baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)
        baseView2.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)
        //横幅
        baseView.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        baseView2.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        
        //背景色Grayにセット
        baseView.backgroundColor = UIColor.gray
        baseView2.backgroundColor = UIColor.gray
        //画面に追加
        self.view.addSubview(baseView)
        self.view.addSubview(baseView2)
        //キーボードの上に「閉じる」ボタンを配置
        //ビューを作成
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
        blandField.inputAccessoryView = upView
        clotheField.inputAccessoryView = upView
        sizeField.inputAccessoryView = upView
       // priceField.inputAccessoryView = upView
        
//        // UIImage インスタンスの生成
//        let image1:UIImage = UIImage(named:"closet3@2x.jpg")!
//        
//        // UIImageView 初期化
//        let backImageView = UIImageView(image:image1)
//        
//        // 画面の横幅を取得
//        let screenWidth:CGFloat = self.formView.frame.size.width
//        let screenHeight:CGFloat = self.formView.frame.size.height
//        
//        // 画像の幅・高さの取得
//        width = image1.size.width
//        height = image1.size.height
//        
//        // 画像サイズをスクリーン幅に合わせる
//        scale = screenWidth / width
//        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
//        // 画像の中心を画面の中心に設定
//        backImageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
//        
//        // UIImageViewのインスタンスをビューに追加
//        self.formView.addSubview(backImageView)
//        //        //画像最背面
//        self.formView.sendSubview(toBack: backImageView)
//        
//        backImageView.alpha = 0.5
//
        
       // initImageView()

        
        read()
    }
//    //背景画像設定
//    private func initImageView(){
//        // UIImage インスタンスの生成
//        let image1:UIImage = UIImage(named:"closet3.jpg")!
//        
//        // UIImageView 初期化
//        let backImageView = UIImageView(image:image1)
//        
//        // 画面の横幅を取得
//        let screenWidth:CGFloat = self.formView.frame.size.width
//        let screenHeight:CGFloat = self.formView.frame.size.height
//        
//        // 画像の幅・高さの取得
//        width = image1.size.width
//        height = image1.size.height
//        
//        // 画像サイズをスクリーン幅に合わせる
//        scale = screenWidth / width
//        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
//        // 画像の中心を画面の中心に設定
//        backImageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
//        
//        // UIImageViewのインスタンスをビューに追加
//        self.formView.addSubview(backImageView)
////        //画像最背面
//        self.formView.sendSubview(toBack: backImageView)
//        
//        backImageView.alpha = 0.5
//    }
//    //背景画像設定完了

    
    
    //textFieldにカーソルが当たったとき(入力開始)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
        print(textField.tag)
        
        //TODO:キーボード、日付のViewを閉じる
        //キーボード
        blandField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        clotheField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        sizeField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
     //   priceField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })



        
        //日付のview
        hideDatePickerView()
       switch textField.tag{
       case 1:
           //タイトル
            //キーボード表示
            return true
       case 2:
            textViewShouldBeginEditing2()
            return true
       case 3:
            textViewShouldBeginEditing2()
            return true
//       case 4:
//            return true
//        
       case 5:
        disprayDatePickerView()
            return false
      
       case 6:
        disprayCategoryPickerView()
        return false
        
       default:
        return true
}
        
        return true
    }
    
    //DatePickerのviewを隠す
    func hideDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)},completion:{finished in print("DatePickerを隠しました")})
    }
    
    //DatePickerのviewを表示する
    @IBAction func enterDate(_ sender: UITextField) {
    }
    func disprayDatePickerView(){
        UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height - self.baseView.frame.height)},completion:{finished in print("DatePickerが現れました")})
        
    }
    
    func textViewShouldBeginEditing2() {
        
        //フォーム全体を上に移動する
        UIView.animate(withDuration: 1, animations: {() -> Void in self.formView.frame.origin = CGPoint(x:self.formView.frame.origin.x,y: self.formView.frame.origin.y - 350)
            
        },completion:{finished in print("FormViewが上に移動しました")})
        
    }

    
    //DatePickerが載ったviewを隠す
    func closeDatePickerView(_sender:UIButton){UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)
    },completion:{finished in print("DatePickerを隠しました")})
    }

    
    //DatePickerで選択している日付を変えたとき、日付用のTextFieldに値を表示
    func showDateSelected(sender:UIDatePicker){
        //フォーマット設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        //日付を文字列に変換
        var strSelectedDate = df.string(from:sender.date)
        //dateFieldに値を表示
        dateField.text = strSelectedDate
        
    }
    //キーボードを閉じる
    func closeKeyboad(sender:UIButton){
        blandField.resignFirstResponder()
        clotheField.resignFirstResponder()
        sizeField.resignFirstResponder()
       // priceField.resignFirstResponder()
    
    }
    
    
    //CategoryPickerのviewを隠す
    func hideCategoryPickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView2.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)},completion:{finished in print("CategoryPickerを隠しました")})
    }
    
    //CategoryPickerのviewを表示する
    @IBAction func enterCategory(_ sender: UITextField) {
    }
       func disprayCategoryPickerView(){
        UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView2.frame.origin = CGPoint(x:0,y: self.view.frame.size.height - self.baseView2.frame.height)},completion:{finished in print("CategoryPickerが現れました")})
        
    }
    //CategoryPickerが載ったviewを隠す
    func closeCategoryPickerView(_sender:UIButton){UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView2.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)
    },completion:{finished in print("CategoryPickerを隠しました")})
    }
    
    // ピッカービューの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // ピッカービューの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    // ピッカービューに表示する文字
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    
    
    //CategoryPickerで選択したときcategoryFieldに表示
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(categoryList[row])
        categoryField.text = categoryList[row]
        
    }

    
    
    //すでに存在するデータの読み込み処理
    func read(){
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        //どのエンティティからdataを取得してくるか設定
       // let query: NSFetchRequest<UserDate> = UserDate.fetchRequest()
        
        do{
            //データを一括取得
            let query:NSFetchRequest<UserDate> = UserDate.fetchRequest()
            query.predicate = NSPredicate(format:"created_at = %@", selectedCD)
          //  query.predicate = NSPredicate(format:"category = %@")
            let fetchResults = try viewContext.fetch(query)
            print("selectedCD=\(selectedCD)")
            //一旦配列を空にする(初期化)
            photlist = NSArray() as! [NSDictionary]
            for result : AnyObject in fetchResults{
                var photDate: String? = result.value(forKey: "phot") as? String
                var clothenameDate: String? = result.value(forKey: "clothename") as? String
                var sizeDate: String? = result.value(forKey:"size") as? String
                var blandDate: String? = result.value(forKey:"blandname") as? String
                var dateDate: String? = result.value(forKey:"date") as? String
                var categoryDate: String? = result.value(forKey:"category") as? String
                var changeDate: String? = result.value(forKey:"created_at") as? String
               // var priceDate: Int16? = result.value(forKey: "price") as? Int16
                
              photlist.append(["phot":editImage.image,"clothename":clotheField.text,"size":sizeField.text,"blandname":blandField.text,"date":dateField,"category":categoryField,])
           
                print("dateDate=\(dateDate)")
           //NewEditの登録内容読み込み
            dateField.text = "\(dateDate!)"
            clotheField.text = "\(clothenameDate!)"
            sizeField.text = "\(sizeDate!)"
            categoryField.text = "\(categoryDate!)"
            blandField.text = "\(blandDate!)"
                
                var AImage: UIImage!
                if photDate != nil{
                    
                    let url = URL(string: photDate as String!)
                    let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                    let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                    let manager: PHImageManager = PHImageManager()
                    var options:PHImageRequestOptions = PHImageRequestOptions()
                    options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
                    manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                        AImage = image
                        self.strURL = photDate!
                        self.editImage.image = AImage
                    }
                    //editImage.image = AImage
            }
                
            }
        }catch{
            
        }

    
    }
    
    
    
    

    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
    
    
       // 画像タップでライブラリを呼び出す
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let picker = UIImagePickerController()
            //picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self // UINavigationControllerDelegate と　UIImagePickerControllerDelegateを実装する
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //トリミング
            picker.allowsEditing = true
            
            
            self.present(picker, animated: true, completion: nil)
        }
    
        
    }
    
         //ライブラリで写真を選んだ後
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
        
        let strURL:String = assetURL.description
        
        print(strURL)
        
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを書き込んで
        myDefault.set(strURL, forKey: "selectedPhotoURL")


        
        // 即反映させる
        myDefault.synchronize()
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        if strURL != nil{
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.editImage.image = image
                
               
                
            }
            
        }

    }

    
    
//    @IBAction func tapCamera(_ sender: UIBarButtonItem) {
//    
//    
//        //カメラかどうか判別するための情報を取得
//        let camera = UIImagePickerControllerSourceType.camera
//        //このアプリが起動されているデバイスにカメラ機能がついているかどうか判定
//        if UIImagePickerController.isSourceTypeAvailable(camera){
//            let picker = UIImagePickerController()
//            picker.sourceType = camera
//            
//            picker.delegate = self
//            picker.sourceType = UIImagePickerControllerSourceType.camera
//
//            self.present(picker,animated: true, completion: nil)
//        }
//        //UserDefaultから取り出す
//        // ユーザーデフォルトを用意する
//        let myDefault = UserDefaults.standard
//        
//        // データを取り出す
//        let strURL = myDefault.string(forKey: "selectedPhotoURL")
//        
//        if strURL != nil{
//            
//            let url = URL(string: strURL as String!)
//            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
//            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
//            let manager: PHImageManager = PHImageManager()
//            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
//                self.editImage.image = image
//            }
//            
//        }
//        
//    }
    
    //保存ボタンタップで移動・追加
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
    
    
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //UserDateエンティティオブジェクトの作成
        let userDate = NSEntityDescription.entity(forEntityName:"UserDate",in:viewContext)
        
        
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")

        

            let date = Date()
            let df = DateFormatter()
           // df.timeZone = TimeZone.current
            df.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let selectedDate = df.string(from: date)
            let changeDate = df.date(from: selectedDate)
//           // if (switchFlag){
//                //Update
                let request: NSFetchRequest<UserDate> = UserDate.fetchRequest()
                let strSavedDate: String = df.string(from: date)
                let savedDate :Date = df.date(from: strSavedDate)!
            do {
                   request.predicate = NSPredicate(format:"created_at = %@", selectedCD)
                   //request.predicate = namePredicte
                   let fetchResults = try viewContext.fetch(request)
                    //登録された日付を元に1件取得　新しい値を入れる
                    for result: AnyObject in fetchResults {
                        let record = result as! NSManagedObject
       
                  //値のセット
                        if strURL != nil{
                        var photDate:String? = record.setValue(strURL, forKey: "phot") as? String
                        }
                        
                        
                        var clothenameDate:String? = record.setValue(clotheField.text, forKey: "clothename")as? String
                        var sizeDate:String? =  record.setValue(sizeField.text, forKey: "size") as? String
                        var blandnameDate:String? = record.setValue(blandField.text, forKey: "blandname") as? String
                        var dateDate:String? = record.setValue(dateField.text, forKey: "date") as? String
                        var categoryDate:String? = record.setValue(categoryField.text, forKey: "category") as? String
        var changeDate: String? = record.setValue(df.string(from: Date()) ,forKey: "created_at") as? String
        //  newRecord.setValue(priceField.text, forKey: "price") as? Int16
                    
                        
                        photlist.append(["phot":editImage.image,"clothename":clotheField.text,"size":sizeField.text,"blandname":blandField.text,"date":dateField,"category":categoryField,])
                        
//                        print("dateDate=\(dateDate)")
//                        //NewEditの登録内容読み込み
//                        dateField.text = "\(dateDate!)"
//                        clotheField.text = "\(clothenameDate!)"
//                        sizeField.text = "\(sizeDate!)"
//                        categoryField.text = "\(categoryDate!)"
//                        blandField.text = "\(blandnameDate!)"
//                        
                        var AImage: UIImage!
                        if strURL != nil{
                            
                            
                            let url = URL(string: strURL as String!)
                            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                            let manager: PHImageManager = PHImageManager()
                            manager.requestImage(for: asset,targetSize: CGSize(width: 500, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                                AImage = image
                                self.strURL = strURL!
                                
                                
                            }
                            editImage.image = AImage
                            
                            
                        }

                        
                    }
                
                
                
                           //レコードの即時保存
            try viewContext.save()
        }catch{
            
       }
    
        self.dismiss(animated: true, completion: nil)
        //CoreDateからdateを読み込む処理
        read()
        
     

            }
    
    
//    func nameOK(){
//        
//    }
//
//    func picOK(){
//        
//    }
//    func namePicOK(){
//        
//    }
    
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
    
        let alertController = UIAlertController(title: "削除", message: "データを削除しました", preferredStyle: .alert)
        alertController.addAction(UIAlertAction (title:"OK", style: .default, handler: {action in self.myOK()}))
        
        //アラートを表示する
        present(alertController,animated: true, completion: nil)
        
        
            //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<UserDate> = UserDate.fetchRequest()
        
            //削除するdateを取得
            let namePredicte = NSPredicate(format: "created_at = %@",selectedCD)
           // let namePredicte = NSPredicate(format: "phot", strURL)
            request.predicate = namePredicte

            let fetchResults = try! viewContext.fetch(request)
            for result: AnyObject in fetchResults {
                let record = result as! NSManagedObject

                viewContext.delete(record)
                do{
                
                    try viewContext.save()}catch{
                }
         
        }
       
    }
    
    func myOK(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(selectedDate)
        read()
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

