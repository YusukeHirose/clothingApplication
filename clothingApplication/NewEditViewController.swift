//
//  NewEditViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/23.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
import Photos

class NewEditViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate  {

    @IBOutlet weak var editImage2: UIImageView!
    
    @IBOutlet weak var dateField2: UITextField!
    
    @IBOutlet weak var clotheField2: UITextField!
    
    @IBOutlet weak var categoryField2: UITextField!
    
    @IBOutlet weak var blandField2: UITextField!
    
    @IBOutlet weak var sizeField2: UITextField!
    
   // @IBOutlet weak var priceField2: UITextField!
    
    
    
    
    //セグエ遷移(横から画面が出る)
//    @IBAction func tapBackSegue2(_ sender: UIButton) {
//        performSegue(withIdentifier: "ViewController", sender: nil)
    
   // }
    
    var selectedImg: String!
    var strURL: String!
    var photlist:[NSDictionary] = NSArray() as! [NSDictionary]
    var switchFlag = false
    var selectedCD: Date!
    var selectedDate: NSDate = NSDate()
   // var useDate: String!
    
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
    
   
    @IBAction func tapBack(_ sender: UIBarButtonItem) {
    
    
//        let next = storyboard!.instantiateViewController(withIdentifier: "ViewController")
//        self.present(next,animated: true, completion: nil)
        
        self.dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var navBarImage = UIImage(named: "ki.jpeg") as UIImage?
        
        self.navigationController?.navigationBar.setBackgroundImage(navBarImage,for:.default)

        photList = [["phot":"noimages.png"],["clothename":"黒パーカー"],["size":"S"],["blandname":"ユニクロ"],["date":"2017/02/21"],["category":"パーカー"]]
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self

        
        //日付が変わったときのイベントをdatePickerに設定
        diaryDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
       // categoryPicker.addTarget(self, action: #selector(showPickerSelected(sender:)), for: .valueChanged)

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
        blandField2.inputAccessoryView = upView
        clotheField2.inputAccessoryView = upView
        sizeField2.inputAccessoryView = upView
        //priceField2.inputAccessoryView = upView
        
            editImage2.image = UIImage(named: "noimages.png")
        
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
//        let rect:CGRect = CGRect(x:0, y:10, width:width*scale, height:height*scale)
//        // 画像の中心を画面の中心に設定
//        backImageView.center = CGPoint(x:screenWidth/3, y:screenHeight/3)
//        
//        // UIImageViewのインスタンスをビューに追加
//        self.formView.addSubview(backImageView)
//        //画像最背面
//        self.formView.sendSubview(toBack: backImageView)
//        
//        backImageView.alpha = 0.5
//
        
         //  initImageView()
        
        read()

        
    }

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
//        let rect:CGRect = CGRect(x:0, y:10, width:width*scale, height:height*scale)
//        // 画像の中心を画面の中心に設定
//        backImageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
//        
//        // UIImageViewのインスタンスをビューに追加
//        self.formView.addSubview(backImageView)
//        //画像最背面
//        self.formView.sendSubview(toBack: backImageView)
//        
//        backImageView.alpha = 0.5
//    }
    
    
    //textFieldにカーソルが当たったとき(入力開始)
    func textFieldShouldBeginEditing(_ textField2: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
        print(textField2.tag)
        
        //TODO:キーボード、日付のViewを閉じる
        //キーボード
        blandField2.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        clotheField2.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
        sizeField2.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
        })
        
//        priceField2.resignFirstResponder()
//        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)}, completion: {finished in print("DatePickerを隠しました")
//        })
        
        
        
        
        //日付のview
        hideDatePickerView()
        switch textField2.tag{
        case 1:
            //タイトル
            //キーボード表示
            return true
        case 2:
            return true
        case 3:
            return true
//        case 4:
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
    @IBAction func enterDate(_ sender: UIPickerView) {
    }
    func disprayDatePickerView(){
        UIView.animate(withDuration: 0.5,animations: {() -> Void in self.baseView.frame.origin = CGPoint(x:0,y: self.view.frame.size.height - self.baseView.frame.height)},completion:{finished in print("DatePickerが現れました")})
        
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
        dateField2.text = strSelectedDate
    }
    //キーボードを閉じる
    func closeKeyboad(sender:UIButton){
        blandField2.resignFirstResponder()
        clotheField2.resignFirstResponder()
        sizeField2.resignFirstResponder()
      //  priceField2.resignFirstResponder()
        
    }
    
    
    //CategoryPickerのviewを隠す
    func hideCategoryPickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.baseView2.frame.origin = CGPoint(x:0,y: self.view.frame.size.height)},completion:{finished in print("CategoryPickerを隠しました")})
    }
    
    //CategoryPickerのviewを表示する
    @IBAction func enterCategory(_ sender: UIPickerView) {
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
        categoryField2.text = categoryList[row]
    
    }
    

    



    

    
    
    
    
    //すでに存在するデータの読み込み処理
    func read(){
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        //どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<UserDate> = UserDate.fetchRequest()
        
        do{
            //データを一括取得
            let fetchResults = try viewContext.fetch(query)
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
                
                photlist.append(["phot":editImage2.image,"clothename":clotheField2.text,"size":sizeField2.text,"blandname":blandField2.text,"date":dateField2,"category":categoryField2,])
                
                
                
            }
        }catch{
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
        
        
        
        // 画像タップでライブラリを呼び出す
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
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
                self.editImage2.image = image
                
            }
        }
        
    }
    
    
    
    func launchCamera(_ sender: UIBarButtonItem) {
        //カメラかどうか判別するための情報を取得
        let camera = UIImagePickerControllerSourceType.camera
        //このアプリが起動されているデバイスにカメラ機能がついているかどうか判定
        if UIImagePickerController.isSourceTypeAvailable(camera){
            let picker = UIImagePickerController()
            picker.sourceType = camera
            
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(picker,animated: true, completion: nil)
        }
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        
        if strURL != nil{
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.editImage2.image = image
            }
            
        }
        
    }
    
    //保存ボタンタップで画像をcollectionViewに追加する&&collectionViewに戻る
   
    @IBAction func tapSAVE(_ sender: UIBarButtonItem) {
    
        
       // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
       // エンティティを操作するためのオブジェクトを作成
          let viewContext = appDelegate.persistentContainer.viewContext
        //UserDateエンティティオブジェクトの作成
        let userDate = NSEntityDescription.entity(forEntityName:"UserDate",in:viewContext)
        //UserDateエンティティにレコード(行)を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: userDate!, insertInto: viewContext)
        
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        //日付を文字列に変換
        var changeDate = df.string(from:Date())

        
        
    
        if categoryField2.text == "" {
            let alertController = UIAlertController(title: "Category", message: "categoryを選択してください。", preferredStyle: .alert)
            alertController.addAction(UIAlertAction (title:"OK", style: .default, handler: {action in self.myOK()}))
            
            //アラートを表示する
            present(alertController,animated: true, completion: nil)

        }else{
            
            newRecord.setValue(strURL, forKey: "phot") as? String
            newRecord.setValue(clotheField2.text, forKey: "clothename")
            newRecord.setValue(sizeField2.text, forKey: "size")
            newRecord.setValue(blandField2.text, forKey: "blandname")
            newRecord.setValue(dateField2.text, forKey: "date") as? String
            newRecord.setValue(categoryField2.text, forKey: "category")
            newRecord.setValue(changeDate, forKey: "created_at") as? String
            
            do {
                try viewContext.save()
            } catch {                }

            
            self.dismiss(animated: true, completion: nil)}
        
        
//        let next = storyboard!.instantiateViewController(withIdentifier: "ViewController")
//        self.present(next,animated: true, completion: nil)
        
      //  self.dismiss(animated: true, completion: nil)
    
    //CoreDateからdateを読み込む処理
    read()

}

    override func viewWillAppear(_ animated: Bool) {
        print(selectedDate)
        read()
    }
  
        
    //OKボタンが押されたら発動するメソッド
    func myOK (){
        print("All right")
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
