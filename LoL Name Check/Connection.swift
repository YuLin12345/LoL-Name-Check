//
//  Connection.swift
//  LoL Name Check
//
//  Created by Yu Lin on 8/22/17.
//  Copyright © 2017 Unknown. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Variables.
var profileIconId = Int()       //profileIconID
var summonerName = String()     //summonerName
var summonerLevel = Int()       //summonerLevel
var accountId = Int()           //accountID
var summonerId = Int()          //summonerID
var revisionDate = Int()        //revisionDate - LastPlayed

var statusCode = Int()          //status_code from API

//Test API Key. Get it from developer.riotgames.com
var apiKey = "RGAPI-b37ada3e-ec4c-40c9-9bee-e3074524df6b"

//Get parsed data results.
func getSummonerAPI() {
    Alamofire.request("https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/\(summonerName)?api_key=\(apiKey)", method: .get).responseJSON { response in
        
        if let data = response.result.value {
            let json = JSON(data)
            
            //Parsed summoner profileIconId.
            profileIconId = json["profileIconId"].intValue
            
            //Parsed summoner name.
            summonerName = json["name"].stringValue
            
            //Parsed summoner summonerLevel.
            summonerLevel = json["summonerLevel"].intValue
            
            //Parsed account id.
            accountId = json["accountId"].intValue
            
            //Parsed summoner id.
            summonerId = json["id"].intValue
            
            //Parsed summoner revisionDate.
            revisionDate = json["revisionDate"].intValue
            
            //Parsed summoner statusCode
            statusCode = json["status"]["status_code"].intValue
            
            //Console output for debug.
            print("ProfileIconID: \(profileIconId) SummonerName: \(summonerName) SummonerLevel: \(summonerLevel) AccountID: \(accountId) SummonerID: \(summonerId) RevisionDate: \(revisionDate) StatusCode: \(statusCode)")
        }
    }
}
