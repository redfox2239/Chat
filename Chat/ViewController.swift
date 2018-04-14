//
//  ViewController.swift
//  Chat
//
//  Created by 原田 礼朗 on 2018/04/14.
//  Copyright © 2018年 reo harada. All rights reserved.
//

import UIKit

// tableViewと相談する準備その1
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    // メッセージのデータ
    var messageData: [String] = [
        "あと少しで帰ります。",
        "はーい",
        "晩ごはん家で食べる？",
        "食べるよ〜",
        "彼氏できた？！",
    ]
    
    // 誰のメッセージか特定するデータ
    var whoData: [String] = [
        "自分",
        "母さん",
        "母さん",
        "自分",
        "自分",
    ]
    
    // ランダムな返信データを用意する
    var randomMessage: [String] = [
        "ばかいってないで、早く帰ってきなさい",
        "わたしは、お父さんラブよ♡",
        "(・∀・)ｲｲﾈ!!",
        "今日の晩御飯は、鉄球よ〜",
        "あんた、テストで0点取ったわね（怒）",
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableViewと相談する準備その2
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
        // xibを呼んでくる
        let myXib = UINib(nibName: "MyTableViewCell", bundle: nil)
        let otherXib = UINib(nibName: "OtherTableViewCell", bundle: nil)
        // tableViewにxibファイルを登録する
        self.chatTableView.register(myXib, forCellReuseIdentifier: "myCell")
        self.chatTableView.register(otherXib, forCellReuseIdentifier: "otherCell")
    }
    
    // tableViewとの相談↓
    // セクションの数どうするぅ？
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セルの数どうするぅ？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
    // 各行のセルの中身どうするぅ？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // もし、メッセージが自分だったら、"myCell"という名前のカスタムセルを使ってね
        // それ以外だったら、"otherCell"という名前のカスタムセルを使ってね
        if self.whoData[indexPath.row] == "自分" {
            // カスタムセルは、as!で正体を保証する
            let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
            cell.messageLabel.text = self.messageData[indexPath.row]
            return cell
        }
        else {
            // カスタムセルは、as!で正体を保証する
            let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! OtherTableViewCell
            cell.messageLabel.text = self.messageData[indexPath.row]
            return cell
        }
    }
    
    //各行のセルの高さどうするぅ？
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! MyTableViewCell
//        cell.messageLabel.text = self.messageData[indexPath.row]
//        cell.messageLabel.sizeToFit()
//        cell.layoutIfNeeded()
//        return cell.messageLabel.frame.size.height + 40
    }
    
    // 送信ボタン押したらどうするぅ？
    @IBAction func tapSendButton(_ sender: Any) {
        // 入力したメッセージを取得
        let message = self.chatTextField.text
        // messageDataの配列にデータを追加する
        self.messageData.append(message!)
        // 誰がメッセージを送ったかの配列 whoDataにもデータを追加する
        self.whoData.append("自分")
        // tableViewと相談し直す
        self.chatTableView.reloadData()
        // 下までスクロール
        self.chatTableView.scrollToRow(at: IndexPath(row: self.messageData.count-1, section: 0), at: .bottom, animated: true)
        // 一秒後に返信が来るようにする
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            // 乱数を生成する（0〜4）
            let random = arc4random() % 5
            // 乱数からランダムデータのどれで返信するか決める
            let reply = self.randomMessage[Int(random)]
            // messageDataの配列にデータを追加する
            self.messageData.append(reply)
            // 誰がメッセージを送ったかの配列 whoDataにもデータを追加する
            self.whoData.append("他人")
            // tableViewと相談し直す
            self.chatTableView.reloadData()
            // 下までスクロール
            self.chatTableView.scrollToRow(at: IndexPath(row: self.messageData.count-1, section: 0), at: .bottom, animated: true)
        }
        // テキストフィールドを空にする
        self.chatTextField.text = ""
        // キーボードを閉じる
        self.chatTextField.endEditing(true)
    }
}








