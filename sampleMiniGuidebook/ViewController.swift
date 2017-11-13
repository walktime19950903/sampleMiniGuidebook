

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var selectedName:String = ""

    
    var areaList:[String] = []
    
    var selectIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "大阪オススメの店"
        
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let filePath = Bundle.main.path(forResource:"areaList",ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //TableViewで扱いやすい街列の形（エリア名の入っている配列）を作成
        for (key,data) in dic! {
            print(key)
            areaList.append(key as! String)
        }
        
        }

    
    //行数を決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    //文字列を決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字列を表示するセルの取得（セルの再利用）
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //表示したい文字の設定
        //cell.textLabel?.text = "\(indexPath.row)行目"
        cell.textLabel?.text = areaList[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.orange
        
        //文字を設定したセルを返す
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    // 選択された時に行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\((indexPath as NSIndexPath).row)行目を選択")
        
        //タップされた行のエリア名を保存
        selectedName = areaList[(indexPath as NSIndexPath).row] as String
        
        //セグエのidentifierを指定して、画面移動
        performSegue(withIdentifier: "showSecondView",sender: nil)
    }
    
    // Segueで画面遷移する時に発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DetailVC = segue.destination as! DetailViewController
        
        //次の画面のインスタンスを発動
        
        //次の画面のプロパティにタップされた行のエリア名を渡す
        DetailVC.getAreaName = selectedName
    }



}

