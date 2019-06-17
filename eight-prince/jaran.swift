//
//  jaran.swift
//  eight-prince
//
//  Created by taka on 2019/06/03.
//  Copyright © 2019 takapc. All rights reserved.
//

import UIKit
import UIKit.UICollectionView
import ESTabBarController_swift


class jaran: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate {


    //
    //  ViewController.swift
    //  eight-prince
    //
    //  Created by taka on 2019/05/13.
    //  Copyright © 2019 takapc. All rights reserved.
    //

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabbar: UITabBar!
    var CurrentSpotName = ""
    var CurrentSpotDesc = ""
    var CurrentSpotAddress = ""
    var CurrentSpotPrice = ""
    var CurrentSpotImage: UIImage? = nil

    func getFileNames() -> [String] {
        let dirs: [String] = ["観光地", "グルメ"]


        //let manager = FileManager.default
        for dir in dirs {
            let a = "/img/" + dir + "/"
            guard let fileNames = try? FileManager.default.contentsOfDirectory(atPath: "/") else {
                return []
            }

            for path in fileNames {
                //print(path as NSString)
            }
        }
        return dirs
    }


    let array: [String] = ["武蔵陵墓地", "高尾トリックアート美術館", "高尾山", "八王子城跡自然公園", "京王高尾山温泉 極楽湯 ", "滝山公園　滝山城跡", "東京富士美術館"]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        tabbar.delegate = self

        getFileNames()


        // Do any additional setup after loading the view.
    }

    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            //昼画面を表示する。
            1 + 2
        case 0:
            //夕方画面を表示する。
            QRRead()

            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "QRRead") as! QRRead

            self.present(resultViewController, animated: true, completion: nil)
        default:
            return
        }
    }

    //Populate Views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotcell", for: indexPath) as! jaranCell
        cell.spotImage.image = UIImage(named: array[indexPath.row] + ".jpg")
        //cell.label.text = array[indexPath.row]
        cell.spotName.text = array[indexPath.row]
        //cell.SpotName.backgroundColor = UIColor(displayP3Red: 0, green: 255, blue: 204, alpha: 1.0)
        let width = cell.frame.width

        var newFrame = cell.frame
        newFrame.size.width = width
        cell.frame = newFrame
        cell.layoutIfNeeded()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        CurrentSpotName = array[indexPath.row]
        CurrentSpotAddress = ""
        CurrentSpotDesc = ""
        CurrentSpotPrice = ""
        CurrentSpotImage = UIImage(named: array[indexPath.row] + ".jpg")!

//        let cons = SpotDetails()
//        cons.SpotName.text = CurrentSpotName
//        cons.SpotAddress.text = CurrentSpotDesc
//        cons.SpotDescription.text = CurrentSpotAdrress
//        cons.SpotPrice.text = CurrentSpotPrice
//        cons.SpotImage.image = CurrentSpotImage
//
        performSegue(withIdentifier: "toDetailController", sender: nil)
    }

    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toDetailController") {
            let subVC: SpotDetails = (segue.destination as? SpotDetails)!

            // SubViewController のselectedImgに選択された画像を設定する
            subVC.varSpotName = CurrentSpotName
            subVC.varSpotAddress = CurrentSpotAddress
            subVC.varSpotDescription = CurrentSpotDesc
            subVC.varSpotPrice = CurrentSpotPrice
            subVC.varSpotImage = CurrentSpotImage!

        }
    }
    @IBAction func backToTop(segue: UIStoryboardSegue) {}
}


/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/


