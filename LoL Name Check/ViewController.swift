//
//  ViewController.swift
//  LoL Name Check
//
//  Created by Yu Lin on 8/21/17.
//  Copyright © 2017 Unknown. All rights reserved.
//

import UIKit

//Variables.
var summonerName = String() //SummonerName

//Removing white space for parsing.
extension String {
    func removingWhitespaces() -> String {
        return
            components(separatedBy: .whitespaces).joined()
    }
}

class ViewController: UIViewController {
    
    //Image.
    @IBOutlet weak var profileImage: UIImageView!
    
    //Labels.
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var estimateLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    
    //Text fields.
    @IBOutlet weak var summonerNameTextField: UITextField!
    
    //Buttons.
    @IBAction func checkButton(_ sender: Any) {
        //Double tap.
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("handleDoubleTap")))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
        
        //Convert millisecond time to date.
        let lastPlayed = Date(timeIntervalSince1970: (TimeInterval(revisionDate / 1000)))
        
        //Summoner level 1 to 6 - 6 months = 15778476000
        let date1to6 = Date(timeIntervalSince1970: (TimeInterval((revisionDate + 15778476000) / 1000)))
        
        //Summoner level 7 to 12 - 1 year = 31556952000
        let date7to12 = Date(timeIntervalSince1970: (TimeInterval((revisionDate + 31556952000) / 1000)))
        
        //Summoner level 13 to 20 - 1 year 8 months = 52594920000
        let date13to20 = Date(timeIntervalSince1970: (TimeInterval((revisionDate + 52594920000) / 1000)))
        
        //Summoner level 21 to 30 - 2 year 6 months = 78892380000
        let date21to30 = Date(timeIntervalSince1970: (TimeInterval((revisionDate + 78892380000) / 1000)))
        
        summonerName = summonerNameTextField.text!.removingWhitespaces()
        
        getResult()
        
        //If ID is not equal 0.
        if(id != 0) {
            profileImage.image = UIImage(named: "\(profileIconId)")
            levelLabel.text! = String(summonerLevel)
            summonerNameLabel.text! = name
            availabilityLabel.text! = String(describing: lastPlayed)
            estimateLabel.text! = "Estimated Summoner Name Expire"
            
            //If summonerLevel between 1-6, 7-12, 13-20, 21-30 calculate the date.
            if(summonerLevel >= 1 && summonerLevel <= 6) {
                expireLabel.text! = String(describing: date1to6)
            }
            else if(summonerLevel >= 7 && summonerLevel <= 12) {
                expireLabel.text! = String(describing: date7to12)
            }
            else if(summonerLevel >= 13 && summonerLevel <= 20) {
                expireLabel.text! = String(describing: date13to20)
            }
            else if(summonerLevel >= 21 && summonerLevel <= 30) {
                expireLabel.text! = String(describing: date21to30)
            }
            unhideLabels()
        }
            //If statusCode equals 404 - Summoner not found or exist.
        else if(statusCode == 404) {
            hideLabels()
            summonerNameLabel.text! = "No summoner name found."
            summonerNameLabel.isHidden = false
        }
            //If statusCode equals 400, 401, 403, 500, 502, 503, 504 there is Riot API error.
        else if(statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 500 || statusCode == 502 || statusCode == 503 || statusCode == 504) {
            hideLabels()
            summonerNameLabel.text! = "API error."
            summonerNameLabel.isHidden = false
        }
            //Else try again.
        else {
            hideLabels()
            summonerNameLabel.text! = "Try again."
            summonerNameLabel.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        hideLabels()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Hide labels.
    func hideLabels() {
        profileImage.isHidden = true
        levelLabel.isHidden = true
        summonerNameLabel.isHidden = true
        availabilityLabel.isHidden = true
        estimateLabel.isHidden = true
        expireLabel.isHidden = true
    }
    
    //Unhide labels.
    func unhideLabels() {
        profileImage.isHidden = false
        levelLabel.isHidden = false
        summonerNameLabel.isHidden = false
        availabilityLabel.isHidden = false
        estimateLabel.isHidden = false
        expireLabel.isHidden = false
    }
}
