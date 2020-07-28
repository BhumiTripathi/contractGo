//
//  QGSharedClasses.swift
//  QuoteGuru
//
//  Created by indianic on 17/04/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import MBProgressHUD
let strToReplaceCharacterInDb = "*@!"

class QGSharedClasses: NSObject {
    
    
    typealias completionBlock = (Bool) -> Void
    
    
    
    // MARK : Activity Controller
    func presentActivityController(_ parentVC : UIViewController ,sender:UIButton,items : [Any] , completion : @escaping completionBlock ) {
        
        if items.isEmpty{
            completion(false)
            return
        }
        
        if IS_IPHONE {
            
            let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
            controller.completionWithItemsHandler = { activity, success, items, error in
                
                if (success){ completion(true)}
                else{completion(false) }
            }
            
            parentVC.present(controller, animated: true, completion: nil)
        }
        else {
            let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
           // activityViewController.popoverPresentationController?.sourceView = parentVC.view
             activityViewController.popoverPresentationController?.sourceView = sender.superview
             //activityViewController.popoverPresentationController?.sourceRect = sender.frame
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.origin.x + 40, y: sender.frame.origin.y, width: sender.frame.size.width, height: sender.frame.size.height)

            
            activityViewController.popoverPresentationController?.permittedArrowDirections = .right
            
            activityViewController.completionWithItemsHandler = { activity, success, items, error in
                
                if (success){ completion(true)}
                else{completion(false) }
                
            }

            parentVC.present(activityViewController, animated: true, completion: nil)
        }        
    }
    
    
    //Mark: Alert
    func showAlert(_ controller : UIViewController, aStrTitle : String , aStrMessage :String ,style : UIAlertController.Style , aCancelBtn :String? ,aDistrutiveBtn : String?, otherButtonArr : Array<String>?, completion : @escaping (Int)->()) -> Void {
        
        print("style:",style)
//        
//        let attributedString = NSAttributedString(string: "Sync", attributes: [
//            NSFontAttributeName : kRoboto_Regular(size: 20.0),
//            NSForegroundColorAttributeName : colorWithHexString(hexString: colorCodes(colornum: 1), alpha: 1.0)
//            ])
//        
//        let alert = UIAlertController.init(title: "" , message: aStrMessage, preferredStyle: style)
//        
//        alert.setValue(attributedString, forKey: "attributedTitle")
        
        var strTitle:String!
        
        if style == .actionSheet
        {
            strTitle = kSortTitle

            if aStrTitle != ""
            {
                strTitle = aStrTitle

            }
        }
        else{
            strTitle = kAppTitle
        }
        
        let attributedStringTitle = NSAttributedString(string:strTitle, attributes: [
            NSAttributedString.Key.font : kRoboto_Regular(size: 20.0),
            NSAttributedString.Key.foregroundColor : colorWithHexString(hexString: colorCodes(colornum: 1), alpha: 1.0)
            ])
        
        let attributedStringMsg = NSAttributedString(string:aStrMessage, attributes: [
            NSAttributedString.Key.font : kRoboto_Regular(size: 13.0),
            NSAttributedString.Key.foregroundColor : colorWithHexString(hexString: colorCodes(colornum: 1), alpha: 1.0)
            ])
        
        let alert = UIAlertController.init(title: "", message: "", preferredStyle: style)
        alert.setValue(attributedStringTitle, forKey: "attributedTitle")
        alert.setValue(attributedStringMsg, forKey: "attributedMessage")
        
        if style == .actionSheet
        {
            alert.view.tintColor = colorWithHexString(hexString: colorCodes(colornum: 1), alpha: 1.0)
        }
        
        
        
        if let arr = otherButtonArr {
            
            for (index, value) in arr.enumerated() {
                
                alert.addAction(UIAlertAction.init(title: value, style: .default, handler: { (UIAlertAction) in
                    
                    completion(index)
                    
                }))
                
            }
        }
        
        if let strCancelBtn = aCancelBtn {
            
            alert.addAction(UIAlertAction.init(title: strCancelBtn, style: .cancel, handler: { (UIAlertAction) in
                
                completion(otherButtonArr != nil ? otherButtonArr!.count : 0)
                
            }))
        }
        if let strDistrutiveBtn = aDistrutiveBtn {
            
            alert.addAction(UIAlertAction.init(title: strDistrutiveBtn, style: .destructive, handler: { (UIAlertAction) in
                
                completion(otherButtonArr != nil ? otherButtonArr!.count : 0)
                
            }))
        }
        
        
      // let attString = NSAttributedString.init(string: "Hello", attributes: [NSFontAttributeName:kRoboto_Regular(size: 13), NSForegroundColorAttributeName:colorWithHexString(hexString: colorCodes(colornum: 1), alpha: 1.0)])
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    //Plist Directory Path

     func plistDirectoryPath(getPlist:NSString) -> String {
        
        //Get Directory Path
        let docsDir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dirPath: URL = docsDir.appendingPathComponent(getPlist as String)
        var strPath: String  = dirPath.path
        let fileManager: FileManager   = FileManager.default
        
        let strFilename = getPlist.deletingPathExtension
        let strExtension = getPlist.pathExtension
        
        if  fileManager.fileExists(atPath: strPath) {
            
            print("Path does not Exists")
        }
        else{
            
            strPath = Bundle.main.path(forResource: strFilename, ofType: strExtension)!
        }
        
        return strPath
        
    }
    
    //Trim all the values of Textfield
     func removeWhiteSpace(_ str:String) -> String {
        
        return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
    }
    
    //Button Properties
    
    func setBtnProperty(sender:UIButton,title:String,bgImg:UIImage,controlState:UIControl.State,font:UIFont) {
        
        if IS_IPHONE{
        
        if title == "Create New" || title == "Get Help"{
            sender.setBackgroundImage(bgImg, for: controlState)
        }
        else{
            sender.setImage(bgImg, for: controlState)
        }
        }
        else{
            sender.setImage(bgImg, for: controlState)
        }
      
        sender.layer.cornerRadius = 20.0
        sender.setTitle(title, for: .normal)
        sender.clipsToBounds = true
        sender.titleLabel?.font = font
        sender.setTitleColor(colorWithHexString(hexString: colorCodes(colornum:0), alpha: 1.0), for: .normal)
        
    }
    
    
    //Indicator
    func showIndicator(){
        
        DispatchQueue.main.async {
            
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
            let progess = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            progess.label.text = "Loading..."
            progess.isUserInteractionEnabled = false
        }
    }
    
    func hideIndicator() {
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
        }
    }
    
    //Popover
    func setPopoverView(getVC:UIViewController,getPopupView:UIView,getSourceView:Any,getSourceRect:CGRect,getDirection:UIPopoverArrowDirection,bgColor:UIColor) -> UIViewController {
        
        let aControllerObject = UIViewController()
        
        aControllerObject.view.addSubview(getPopupView)
        
        aControllerObject.preferredContentSize = getPopupView.frame.size
       
        aControllerObject.modalPresentationStyle = .popover
        if let currentPopoverpresentioncontroller = aControllerObject.popoverPresentationController{
            
            currentPopoverpresentioncontroller.delegate = getVC as? UIPopoverPresentationControllerDelegate
            
            currentPopoverpresentioncontroller.backgroundColor = bgColor
            currentPopoverpresentioncontroller.sourceView = getSourceView as? UIView
            currentPopoverpresentioncontroller.sourceRect = getSourceRect
            currentPopoverpresentioncontroller.permittedArrowDirections = getDirection
            
            
        }
        
        getVC.present(aControllerObject, animated: true, completion: nil)
        return aControllerObject
    }
    
    // check string contains strToReplaceCharacterInDb 
    
    func checkStringContainsSpecialCharacter(strValue : String) -> String
    {
        var strNewValue = strValue

        if strValue.range(of:strToReplaceCharacterInDb) != nil{
            strNewValue = strNewValue.replacingOccurrences(of: strToReplaceCharacterInDb, with: "'")
        }
        
        return strNewValue
    }

    func setShadow(getView:UIView) {
        
        getView.layer.masksToBounds = false
        getView.layer.shadowColor = UIColor.black.cgColor
        getView.layer.shadowOffset = CGSize(width:0.0, height: 0.0)
        getView.layer.shadowOpacity = 0.5
        getView.layer.shouldRasterize = true

    }
   
    
    
}
