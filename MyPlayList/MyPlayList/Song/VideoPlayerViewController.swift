//
//  VideoPlayerViewController.swift
//  MyPlayList
//
//  Created by Capgemini on 12/4/19.
//  Copyright © 2019 Capgemini. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var songTitle: UILabel!
    
    var video:Video = Video()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        songTitle.text = video.title
        getVideo(videoKey: video.key)
        
    }
    
    func getVideo(videoKey:String) {
        //let vars = ["origin": "http://www.youtube.com"]
        let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")
       // print("url= \(url)")
        let requestObj = URLRequest(url: url! as URL)
        webView.loadRequest(requestObj)
        // webView.loadRequest(URLRequest(url: url!) )
        
    }
    
    
    
}
