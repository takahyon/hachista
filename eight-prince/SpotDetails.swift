//
//  spotDetails.swift
//  eight-prince
//
//  Created by taka on 2019/06/17.
//  Copyright © 2019 takapc. All rights reserved.
//

import UIKit

class SpotDetails: UIViewController {

    
    @IBOutlet weak var SpotName: UILabel!
    @IBOutlet weak var SpotAddress: UILabel!
    @IBOutlet weak var SpotDescription: UILabel!
    @IBOutlet weak var SpotPrice: UILabel!
    @IBOutlet weak var SpotImage: UIImageView!
    var varSpotName:String! = ""
    var varSpotAddress:String! = ""
    var varSpotDescription:String! = ""
    var varSpotPrice:String! = ""
    var varSpotImage:UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        SpotName.text = varSpotName
        SpotAddress.text = varSpotAddress
        SpotDescription.text = varSpotDescription
        SpotPrice.text = varSpotPrice
        SpotImage.image = varSpotImage
        SpotImage.contentMode = UIView.ContentMode.scaleAspectFit

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
