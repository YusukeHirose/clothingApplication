//
//  EditViewController.swift
//  clothingApplication
//
//  Created by User on 2017/02/14.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import UIKit
import CoreData
class EditViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate{

    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var clotheField: UITextField!
    
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var blandField: UITextField!
    
    @IBOutlet weak var sizeField: UITextField!
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBAction func tapBack(_ sender: UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "ViewController")
        self.present(next,animated: true, completion: nil)
        
    }
    
   
    
    //セグエ遷移(横から画面が出る)
    @IBAction func tapBackSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "ViewController", sender: nil)
        
    }
    
    var selectedImg: UIImage!

    var list:[String] = NSArray() as! [String]
    
    
    @IBOutlet weak var formView: UIView!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x:0,y:720,width:200,height:250))
    
    //datePicker(日付編集時)
    let diaryDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x:10,y:20, width:300,height:250))
    
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //日付が変わったときのイベントをdatePickerに設定
        diaryDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        
        //baseViewにdatePickerを配置
        baseView.addSubview(diaryDatePicker)
        
        //位置、大きさを決定
        closeBtnDatePicker.frame = CGRect(x:self.view.frame.width - 60,y:0 ,width:50,height: 20)
        //タイトルの設定
        closeBtnDatePicker.setTitle("close",for: .normal)
        //イベントの追加
        closeBtnDatePicker.addTarget(self,action: #selector(closeDatePickerView),for: .touchUpInside)
        //viewに追加
        baseView.addSubview(closeBtnDatePicker)
        //下にぴったり配置、横幅ぴったりの大きさにしておく
        //位置
        baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)
        //横幅
        baseView.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        
        //背景色Grayにセット
        baseView.backgroundColor = UIColor.gray
        
        //画面に追加
        self.view.addSubview(baseView)
        
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
        priceField.inputAccessoryView = upView
        

        
        editImage.image = selectedImg
        
        read()
    }
    
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
        
        priceField.resignFirstResponder()
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
            return true
       case 3:
            return true
       case 4:
            return true
       case 5:
            //日付
            //アニメーションでDatePickerが載ったviewを表示

            disprayDatePickerView()
            return false
       case 6:
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
        let strSelectedDate = df.string(from:sender.date)
        //dateFieldに値を表示
        dateField.text = strSelectedDate
    }
    //キーボードを閉じる
    func closeKeyboad(sender:UIButton){
        blandField.resignFirstResponder()
        clotheField.resignFirstResponder()
        sizeField.resignFirstResponder()
        priceField.resignFirstResponder()
    
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
            list = NSArray() as! [String]
            for result : AnyObject in fetchResults{
                let photDate: String? = result.value(forKey: "phot") as? String
                let clothenameDate: String? = result.value(forKey: "clothename") as? String
                let sizeDate: String? = result.value(forKey:"size") as? String
                let blandDate: String? = result.value(forKey:"blandname") as? String
                let dateDate: String? = result.value(forKey:"date") as? String
                let categoryDate: String? = result.value(forKey:"category") as? String
                let priceDate: Int16? = result.value(forKey: "price") as? Int16
                list.append(photDate!)
                list.append(clothenameDate!)
                list.append(sizeDate!)
                list.append(blandDate!)
                list.append(dateDate!)
                list.append(categoryDate!)
                list.append(priceDate! as! String)

            }
        }catch{
            
        }

    
    }
    
    
    //保存ボタンタップで追加
    @IBAction func tapBtn(_ sender: UIButton) {
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //UserDateエンティティオブジェクトの作成
        let UserDate = NSEntityDescription.entity(forEntityName:"UserDate",in:viewContext)
        //UserDateエンティティにレコード(行)を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: UserDate!, insertInto: viewContext)
        //値のセット
        newRecord.setValue(editImage.image, forKey: "phot")
        newRecord.setValue(clotheField.text, forKey: "clothename")
        newRecord.setValue(sizeField.text, forKey: "size")
        newRecord.setValue(blandField.text, forKey: "blandname")
        newRecord.setValue(dateField.text, forKey: "date")
        newRecord.setValue(categoryField.text, forKey: "category")
        newRecord.setValue(priceField.text, forKey: "price")
        do{
            //レコードの即時保存
            try viewContext.save()
        }catch{
        
        }
        //CoreDateからdateを読み込む処理
        read()
    }
    
    
    
    
    
    
    @IBAction func tapImage(_ sender: Any) {
        
       // 画像タップでライブラリを呼び出す
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self // UINavigationControllerDelegate と　UIImagePickerControllerDelegateを実装する
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
           
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func launchCamera(_ sender: UIBarButtonItem) {
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
        
        //撮影終了後発動するメゾット
        func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]){
            //撮影した写真を代入
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            //imageViewに撮影した写真を設定
            editImage.image = image
            
            //自分のデバイスに写真を保存
            UIImageWriteToSavedPhotosAlbum(image,nil ,nil ,nil )
            
            //モーダルで表示した写真撮影用画面を閉じる(前の画面に戻る)
            dismiss(animated: true)}
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
