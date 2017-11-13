

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var myTextField: UITextView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myMap: MKMapView!
    
    var contentOffset = CGPoint.zero //init
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTextField.contentOffset = contentOffset //set
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentOffset = myTextField.contentOffset //keep
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentOffset = CGPoint.zero //init
    }
    
    //前の画面から受け取るためのプロパティ
    var getAreaName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ファイルのパスを取得（エリア名が格納されているプロパティリスト）
        var filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に代入
        var dic = NSDictionary(contentsOfFile: filePath!)
        
        //（for文で表さないやり方）今画面に表示したいデータの取得
        let detailInfo = dic![getAreaName] as! NSDictionary
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["description"] as! String)
        print(detailInfo["image"] as! String)
        print(detailInfo["latitude"] as! String)
        print(detailInfo["longitude"] as! String)
        
        
        //タイトルを、ナビゲーションバーの真ん中に表示
        self.title = getAreaName
        //説明
        myTextField.text = detailInfo["description"] as! String
        //画像
        myImage.image = UIImage(named:detailInfo["image"] as! String)
        //地図
        let latitude = detailInfo["latitude"] as! String
        let longitude = detailInfo["longitude"] as! String
        
        
        //座標オブジェクト
        //型変換 String型->Double型 「atof」をぶち込む！！！！！！
        let coodinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
        //拡張率
        let span = MKCoordinateSpanMake(0.04, 0.04)
        //範囲オブジェクト
        let region = MKCoordinateRegionMake(coodinate, span)
        //地図にセット
        myMap.setRegion(region,animated: true)
        //ピンをセット
        let myPin: MKPointAnnotation = MKPointAnnotation()
        //座標を設定
        myPin.coordinate = coodinate
        //タイトルを設定
        myPin.title = getAreaName
        //サブタイトを設定
        myPin.subtitle = "おすすめ"
        //myMapにピンを追加
        myMap.addAnnotation(myPin)
        
    
        //TableViewで扱いやすい形（エリア名の入ってる配列）を作成(for文を使ったやり方)
//        for(key,data) in dic!{
//            var dicForData:NSDictionary = data as! NSDictionary
//            if((key as! NSString) as String == getAreaName){
//                navigationItem.title = getAreaName
//                myTextField.text = dicForData["description"] as! String
//                myImage.image = UIImage(named:dicForData["image"] as! String)
//
//                var latitude:String = dicForData["latitude"] as! String
//                var longitude:String = dicForData["longitude"] as! String
//
//                let coordinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
//                let span = MKCoordinateSpanMake(0.05, 0.05)
//                let region = MKCoordinateRegionMake(coordinate, span)
//                myMap.setRegion(region, animated:true)
//
//                // ピンを生成.==================================
//                let myPin: MKPointAnnotation = MKPointAnnotation()
//
//                // 座標を設定.
//                myPin.coordinate = coordinate
//
//                // タイトルを設定.
//                myPin.title = getAreaName
//
//                // サブタイトルを設定.
//                myPin.subtitle = "おすすめ"
//
//                // MapViewにピンを追加.
//                myMap.addAnnotation(myPin)

    }
    
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        let controller = UIActivityViewController(activityItems: [myImage.image!],
                                                  applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
