//
//  CustomSideMenuController.swift
//  MAlada
//
//  Created by Maahi on 13/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import SideMenuController



class CustomSideMenuController: SideMenuController {

    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        if DeviceType.IS_IPHONE_5{
            SideMenuController.preferences.drawing.sidePanelWidth = 270
        }else{
            SideMenuController.preferences.drawing.sidePanelWidth = 300
        }
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        call()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func call()  {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
        performSegue(withIdentifier: "containSideMenu", sender: nil)
    }
    
    /*  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
     if motion == .motionShake {
     dismiss(animated: true, completion: {
     if self.presentedViewController != nil {
     self.dismiss(animated: true, completion: nil)
     }
     })
     }
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /* if segue.identifier == "showAreaOfInterest" {
         let nextScene =  segue.destination as! AreaOfIntrestVC
         nextScene.Status = 1
         }*/
        
    }
    
    
    
    
    
    
    
    
    enum UIUserInterfaceIdiom : Int
    {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }

    
    
}
