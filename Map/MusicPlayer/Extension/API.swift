//
//  API.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/9/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class API {
    static let shared: API = API()
    let root = Firestore.firestore()
    
    func userRef(uid: String) -> DocumentReference {
        return root.collection("Users").document(uid)
        
    }
    
    func removeSpots(completion: @escaping () -> Void) {
        Firestore.firestore().collection("Spots").getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
            }
            if let snapshots = snapshot?.documents {
                
                let dispatchGroup = DispatchGroup()
                                
                for snapshot in snapshots {
                    let id = snapshot.data()
                    if let ids = snapshot["id"] as? String {
                        print("\(ids)")
                        
                        dispatchGroup.enter()

                        Firestore.firestore().collection("Spots").document(ids).delete { (err) in
                            print("\(err)")
                            dispatchGroup.leave()
                        }
                        
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion()
                }
            }
        }
        
    }
    
    func removeCities(completion: @escaping () -> Void) {
        Firestore.firestore().collection("Cities").getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
            }
            if let snapshots = snapshot?.documents {
                
                let dispatchGroup = DispatchGroup()
                                
                for snapshot in snapshots {
                    
                    let cityIds = snapshot.documentID
                    print("\(cityIds)")
                    
                    dispatchGroup.enter()

                    Firestore.firestore().collection("Cities").document(cityIds).delete { (err) in
                        print("\(err)")
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion()
                }
            }
        }
        
    }
    
    func updataSpotsAPI(count: Int, completion: @escaping () -> Void) {
        
        
        // 傳入 url, spots 數量 到 getTaiwanSpots , return spots
        getTaiwanSpots(url: "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json", count: count) { (spots) in
            
            
            // 上面拿到的 spots 再傳入 updateSpots(spots: spots)
            if let cityEnumDict = self.postSpots(spots: spots) {
                
                let dispatchGroup = DispatchGroup()
                
                for (key, values) in cityEnumDict {
                    
                    let data = ["cityIds": values]
                    
                    dispatchGroup.enter()
                    
                    // 拿到資料後， 在fireStore setData "Cities"
                    Firestore.firestore().collection("Cities").document(key.rawValue).setData(data) { (err) in
                        if let err = err {
                            print(err)
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion()
                }
            }
            
        }
        
    }
    // 傳入 spots , 回傳  dictionary?
    func postSpots (spots: [Spot]) -> [CityEnum: [String]]? {
        var cityEnumDict : [CityEnum: [String]] = [:]
        
        
        for spot in spots {
            // 把每個 city 轉換成 cityEnum 的型別, 存入cityEnum
            if let city = spot.city, let cityEnum = CityEnum.init(rawValue: city) {
                // 把從 spot.city 拿到資料的 city 加進去 CityEnum ralValue 裡
                // 拉進去 enum 的用意為： 他會幫你偵測你是屬於哪個 value， 類似說
                // 如果我 city 是"台東縣"的話 他就等於是 TTH , 因為 TTH 的 value 是 "台東縣"
                
                // 確定 City 目錄底下有這個 Spot
                Firestore.firestore().collection("Spots").document(spot.id).setData(spot.dictionary()) { (err) in
                    // 重新 創建  spot.dictionary 解析成我 Class Spot 打的樣子
                    // 拿到 spot.id 裡面的 dictionary
                    
                    
                    if let err = err {
                        print(err)
                        return
                    }
                }
                // 假如我 spot.city 有符合 cityEnum 那些縣市名
                // 也就是下面打的 cityEnum != nil (有值的)，
                // 上面創建的 cityenum型別的 dict 會增加 spot.id ,
                // 比如 符合"台東縣"的 ，台東縣的那個 ralvalue 有值 ，
                // 會在"台東縣" 增加 spot.id
                // 沒有的話 ， 我的 cityEnumDict[cityEnum] 會等於 [spot.id] 不太懂
                
                
                if cityEnumDict[cityEnum] != nil {
                    cityEnumDict[cityEnum]!.append(spot.id)
                } else {
                    cityEnumDict[cityEnum] = [spot.id]
                }
            }
        }
        return cityEnumDict
    }
    
    
    // url： 網址 , count: 拿到spots 的數量， completion: 封包( 回傳 spots)
    func getTaiwanSpots(url: String,count: Int, completion: @escaping ([Spot])->Void) {
        
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // 非同步拿取 url 的 data
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
            guard let xmlHead = json["XML_Head"] as? [String:Any] else { return }
            
            guard let infos = xmlHead["Infos"] as? [String:Any] else { return }
            guard let info = infos["Info"] as? [[String: Any]] else { return } 
            
            //  做一個迴圈 , 把 dict 丟進去 info[] 裡
            // 再把他丟到 Class Spot 裡有做好的型別解析轉換，再丟回 spots[] 裡
            // [spots] 裡是 dictionary
            
            var spots: [Spot] = []
            for dict in info[0...count - 1] {
                let spot = Spot(dictionary: dict)
                spots.append(spot)
            }
            completion(spots)
            
        }.resume()
    }
    
}


