//
//  PostViewController.swift
//  MusicPlayer
//
//  Created by 嚴啟睿 on 2020/8/26.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let text = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        let url = URL(string: text)
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    if let json = json ,
                        let xmlHead = json["XML_Head"] as? [String:Any],
                        let infos = xmlHead["Infos"] as? [String:Any] ,
                        let info = infos["Info"] as? [Any],
                        let infoArray = info[0] as? [String:Any],
                        let id = infoArray["Id"] as? String ,
                        let name = infoArray["Name"] as? String ,
                        let toldescribe = infoArray["Toldescribe"] as? String ,
                        let tel = infoArray["Tel"] as? String ,
                        let region = infoArray["Region"] as? String ,
                        let town = infoArray["Town"] as? String ,
                        let px = infoArray["Px"] as? Any ,
                        let py = infoArray["Py"] as? Any  ,
                        // Py, Px 原本設INT， print不出來
                        let keyword = infoArray["Keyword"] as? String {
                        print("""
                            Id: \(id),
                            Name: \(name),
                            Toldescribe: \(toldescribe),
                            Tel: \(tel),
                            Region: \(region),
                            Town: \(town),
                            Px: \(px),
                            Py: \(py),
                            Keyword: \(keyword)
                            """)
                    }
                    
                }
            }.resume()
            
        }
        
    }
    
}
