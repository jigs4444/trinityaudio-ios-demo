//
//  FABViewController.swift
//  TrinityAudioDemo
//
//  Created by Jigar Thakkar on 09/04/2021.
//

import UIKit
import TrinityPlayer

class FABViewController: UIViewController {

    @IBOutlet var playerView: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    
    // Init Trinity Audio Player
    var audio: TrinityAudioProtocol?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTrinityPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // invalidate player on disapper 
        self.audio?.invalidate()
    }
    
    // MARK: - Navigation Action
    @IBAction func swipeBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Helper Methods
    func setupUI() {
        self.descriptionText.text = AppContent.shared.article
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupTrinityPlayer() {
        audio = TrinityAudio.newInstance()
        audio?.delegate = self
        self.showPlayer()
    }

    func showPlayer() {
        if let url = URL(string: TAConstants.shared.contentURL) {
            // Pass nil for non FAB in fabViewTopLeftCoordingates parameter
            audio!.render(parentViewController: self, unitId: TAConstants.shared.unitID, sourceView: self.playerView, fabViewTopLeftCoordinates: nil, contentURL:url, settings: nil)
        }
    }
}

// MARK: - TrinityAudio Delegate Methods
extension FABViewController: TrinityAudioDelegate {
    
    func trinity(service: TrinityAudioProtocol, receiveError: TrinityError) {
        print(receiveError)
    }
    
    func trinity(service: TrinityAudioProtocol, detectUpdateForContentHeight height: Float, inState state: TrinityState) {
        print(state)
    }
    
    func trinity(service: TrinityAudioProtocol, didCheckCookie cookieData: [String : Any]) {
        print(cookieData)
    }
}


