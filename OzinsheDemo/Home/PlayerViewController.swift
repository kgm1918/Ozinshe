//
//  PlayerViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 06.07.2025.
//

import UIKit
import SnapKit
import YouTubePlayer

class PlayerViewController: UIViewController {
    var video_link = ""
        
    let player = {
        let view = YouTubePlayerView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        player.loadVideoID(video_link)
    }


}
