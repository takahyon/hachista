//
//  ViewController.swift
//  eight-prince
//
//  Created by taka on 2019/05/13.
//  Copyright © 2019 takapc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    


    func getFileNames () ->[String]{
        let dirs:[String] = ["観光地","グルメ"]
        
        
        //let manager = FileManager.default
        for dir in dirs{
            let a = "/img/"+dir+"/"
            guard let fileNames = try? FileManager.default.contentsOfDirectory(atPath: "/") else {
                return []
            }
            
            for path in fileNames {
                print(path as NSString)
            }
        }
        return dirs
    }
    
    
    let array:[String] = ["武蔵陵墓地","高尾トリックアート美術館","高尾山","八王子城跡自然公園","京王高尾山温泉 極楽湯 ","滝山公園　滝山城跡","東京富士美術館"]


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getFileNames()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        return array.count
    }
    
    //Populate Views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.myImageView.image = UIImage(named: array[indexPath.row]+".jpg")
        //cell.label.text = array[indexPath.row]
        cell.SpotName.text = array[indexPath.row]
        //cell.SpotName.backgroundColor = UIColor(displayP3Red: 0, green: 255, blue: 204, alpha: 1.0)
        let width = cell.frame.width
        
        var newFrame = cell.frame
        newFrame.size.width = width
        cell.frame = newFrame
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //ここに遷移処理を書く
        self.present(jaran(), animated: true, completion: nil)
    }
    
    
}

