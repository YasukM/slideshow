//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Yasuko Matsubara on 2017/12/02.
//  Copyright © 2017年 yasuko.matsubara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var saiseiButton: UIButton!
    @IBOutlet weak var susumuButton: UIButton!
    @IBOutlet weak var modoruButton: UIButton!
    
    @IBAction func modoru(_ sender: Any) {
        ImageNo -= 1
        displayImage()
        //戻るボタン
    }
    @IBAction func susumu(_ sender: Any) {
        ImageNo += 1
        displayImage()
        //進むボタン
    }
    @IBAction func saisei(_ sender: Any) {
        if timer == nil {
            //スライド開始
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            //戻る・進むボタンをタップ不可にする
            susumuButton.isEnabled = false
            modoruButton.isEnabled = false
            
            //再生ボタンを「停止」に
            saiseiButton.setTitle("停止", for: .normal)
        }
        else{
            //スライド停止
            timer.invalidate()
            timer = nil
            
            //戻る・進むボタンをタップ可にする
            susumuButton.isEnabled = true
            modoruButton.isEnabled = true
            
            //再生ボタンを「再生」に
            saiseiButton.setTitle("再生", for: .normal)
        }
        //再生停止ボタン
    }
    
    // 一定の間隔で処理を行うためのタイマー
    var timer: Timer!
    
    // 表示している画像の番号
    var ImageNo: Int  = 0
    
    // 表示している画像の番号を元に画像を表示する
    func displayImage() {
        let images: [String] = ["IMG_1.JPG","IMG_2.JPG","IMG_3.JPG"]
        
        // 範囲より下を指している場合、最後の画像を表示
        if ImageNo < 0 {
            ImageNo = 2
        }
        
        // 範囲より上を指している場合、最初の画像を表示
        if ImageNo > 2 {
            ImageNo = 0
        }
        
        // 表示している画像の番号から名前を取り出し
        let name = images[ImageNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageView?.image = image
        
    }
    
    
    func updateTimer(timer: Timer) {
        ImageNo += 1
        displayImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if timer != nil {
            saisei(sender)
        }
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言している image に値を代入して渡す
        resultViewController.image = self.imageView?.image
    }
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
}

