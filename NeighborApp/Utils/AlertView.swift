//
//  AppDelegate.swift
//  NeighborApp
//
//  Created by Nitesh on 11/28/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit

struct Macros
{
    static func getColorFromRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor
    {
        return getColorFromRGBA(red, green: green, blue: blue, alpha: 1)
    }
    
    static func getColorFromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

struct alertProps {
    static let textFont = UIFont(name: "Avenir-Medium", size: 14)
    static let boldFont = UIFont(name: "Avenir-Heavy", size: 14)
    static let view_Wdth:CGFloat = 280
    
    static let titleBoxBg = Macros.getColorFromRGB(218, green: 247, blue: 244)
    static let normalBoxBg = Macros.getColorFromRGB(255, green: 255, blue: 255)
    static let buttonBoxBg = Macros.getColorFromRGB(13, green: 52, blue: 85)
    static let destructiveBoxBg = Macros.getColorFromRGB(236, green: 90, blue: 73)
    
    static let destructiveTxt = Macros.getColorFromRGB(255, green: 255, blue: 255)
    static let normalTxt = Macros.getColorFromRGB(13, green: 52, blue: 85)
    
    static let lblInset = UIEdgeInsetsMake(10,10,10,10)
    static let titleInset = UIEdgeInsetsMake(5,10,5,10)
    
    static let noBtnBg = Macros.getColorFromRGB(13, green: 52, blue: 85)
    static let yesBtnBg = Macros.getColorFromRGB(13, green: 52, blue: 85)
    
    static let btnNoTag = 200;
    static let btnYesTag = 201;
}


class AlertViewController: UIViewController
{
    var alertView: AlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = alertView!
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIApplication.sharedApplication().statusBarStyle
    }
}

class AlertView: UIView {
    
    private var alertTitle: String?
    private var alertBody: String?
    
    var animationType: Int?
    
    private var isNoAvailable: Bool?
    private var isYesAvailable: Bool?
    var isDestructive: Bool?
    
    var alertView: UIView?
    var alertWindow: UIWindow?
    
    
    var yesAction: (() -> Void)?
    var noAction: (() -> Void)?
    
    
    func showAlertWithYesNo(title: String, body:String, onYes:(() -> Void)?, onNo:(() -> Void)?)
    {
        isYesAvailable = true
        isNoAvailable = true
        alertTitle = title
        alertBody = body
        
        showAlert(onYes, onNo: onNo)
    }
    func showAlertWithYes(title:String, body:String, onYes:(() -> Void)?)
    {
        isYesAvailable = true
        isNoAvailable = false
        alertTitle = title
        alertBody = body
        
        showAlert(onYes, onNo: nil)
    }
    func showAlert(title:String, body:String)
    {
        isYesAvailable = false
        isNoAvailable = false
        alertTitle = title
        alertBody = body
        showAlert(nil, onNo: nil)
    }
    
    private func showAlert(onYes:(() -> Void)?, onNo:(() -> Void)?)
    {
        yesAction = onYes
        noAction = onNo
        
        self.backgroundColor = Macros.getColorFromRGBA(0, green: 0, blue: 0, alpha: 0.7)
        
        alertView = UIView(frame: CGRectMake(0, 0, alertProps.view_Wdth, 0))
        alertView?.backgroundColor = Macros.getColorFromRGBA(255, green: 255, blue: 255, alpha: 0.9)
        self.addSubview(alertView!)
        
        //alert title
        var titleView = UIView(frame: CGRectMake(0, 0, alertProps.view_Wdth, 0))
        titleView.backgroundColor = alertProps.normalBoxBg
        if(isDestructive == true)
        {
            titleView.backgroundColor = alertProps.destructiveBoxBg
        }
        alertView?.addSubview(titleView)
        
        var titleLbl = UILabel(frame: CGRectMake(alertProps.titleInset.left, alertProps.titleInset.top, titleView.frame.size.width-(alertProps.titleInset.left+alertProps.titleInset.right), 0))
        titleLbl.text = alertTitle
        titleLbl.backgroundColor = UIColor.clearColor()
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.numberOfLines = 0
        
        titleLbl.font = alertProps.textFont
        titleLbl.textColor = alertProps.normalTxt
        if(isDestructive == true)
        {
            titleLbl.font = alertProps.boldFont
            titleLbl.textColor = alertProps.destructiveTxt
        }
        
        titleLbl.frame = CGRectMake(alertProps.titleInset.left, alertProps.titleInset.top, titleLbl.frame.size.width, getTextHt(titleLbl))
        titleView.addSubview(titleLbl)
        
        titleView.frame = CGRectMake(0, 0, titleView.frame.size.width, titleLbl.frame.size.height + (alertProps.titleInset.top + alertProps.titleInset.bottom));
        var dHeight = titleView.frame.size.height + 1;
        
        
        //alert body
        var bodyView = UIView(frame: CGRectMake(0, dHeight, alertProps.view_Wdth, 0))
        bodyView.backgroundColor = alertProps.normalBoxBg
        if(isDestructive == true)
        {
            bodyView.backgroundColor = alertProps.destructiveBoxBg
        }
        alertView?.addSubview(bodyView)
        
        var bodyLbl = UILabel(frame: CGRectMake(alertProps.lblInset.left, alertProps.lblInset.top, bodyView.frame.size.width-(alertProps.lblInset.left+alertProps.lblInset.right), 0))
        bodyLbl.text = alertBody
        bodyLbl.backgroundColor = UIColor.clearColor()
        bodyLbl.textAlignment = NSTextAlignment.Center
        bodyLbl.numberOfLines = 0
        
        bodyLbl.font = alertProps.textFont
        bodyLbl.textColor = alertProps.normalTxt
        if(isDestructive == true)
        {
            bodyLbl.font = alertProps.boldFont
            bodyLbl.textColor = alertProps.destructiveTxt
        }
        
        bodyLbl.frame = CGRectMake(alertProps.lblInset.left, alertProps.lblInset.top, titleLbl.frame.size.width, getTextHt(bodyLbl))
        bodyView.addSubview(bodyLbl)
        
        bodyView.frame = CGRectMake(0, dHeight, bodyView.frame.size.width, bodyLbl.frame.size.height + (alertProps.lblInset.top + alertProps.lblInset.bottom));
        dHeight += bodyView.frame.size.height+1;
        
        
        if(isNoAvailable == false && isYesAvailable == false)
        {
            var activityIndi = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, bodyView.frame.size.height))
            activityIndi.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            activityIndi.startAnimating()
            bodyView.addSubview(activityIndi)
        }
        
        //adding NO button
        if(isNoAvailable == true)
        {
            var btnNo = UIButton(frame: CGRectMake(0, dHeight, alertProps.view_Wdth/2.0 - 1, 40))
            btnNo.backgroundColor = alertProps.buttonBoxBg
            btnNo.setImage(UIImage(named: "close"), forState:UIControlState.Normal)
            btnNo.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchDown)
            btnNo.tag = alertProps.btnNoTag
            alertView!.addSubview(btnNo)
        }
        
        if(isYesAvailable == true)
        {
            var btnYes = UIButton(frame: CGRectMake(alertProps.view_Wdth/2.0 + 1, dHeight, alertProps.view_Wdth/2.0 - 1, 40))
            
            if(isNoAvailable == false)
            {
                btnYes.frame = CGRectMake(0, dHeight, alertProps.view_Wdth, 40)
            }
            
            btnYes.backgroundColor = alertProps.buttonBoxBg
            btnYes.setImage(UIImage(named: "check"), forState:UIControlState.Normal)
            btnYes.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchDown)
            btnYes.tag = alertProps.btnYesTag
            alertView!.addSubview(btnYes)
            
            dHeight += 40;
        }
        
        alertView!.frame = CGRectMake(0, 0, alertProps.view_Wdth, dHeight);
        
        //alert added to window
        var viewController = AlertViewController()
        viewController.view = self;
        
        if (alertWindow == nil)
        {
            var window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,  UIViewAutoresizing.FlexibleHeight]
            window.opaque = false
            window.windowLevel = UIWindowLevelAlert
            window.rootViewController = viewController
            alertWindow = window
            
            self.frame = window.frame;
            alertView!.center = window.center;
        }
        alertWindow!.makeKeyAndVisible()
        
        showAnimation()
    }
    
    private func showAnimation()
    {
        var rect = alertView!.frame
        var ptCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        self.alpha = 0
        
        alertView!.center = CGPointMake(self.bounds.size.width/2, -self.bounds.size.height/2)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alpha = 1
            self.alertView!.center = ptCenter
        })
    }
    
    private func hideAnimation()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alertView!.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 + self.bounds.size.height);
            self.alpha = 0
            }) { (finished) -> Void in
                self.removeAlert()
        }
    }
    
    private func removeAlert()
    {
        self.removeFromSuperview()
        alertWindow!.removeFromSuperview()
        alertWindow = nil;
    }
    func hideAlert()
    {
        hideAnimation()
    }
    
    private func getTextHt(var lbl: UILabel) -> CGFloat
    {
        let attributes = [NSFontAttributeName : lbl.font]
        let rect = (lbl.text)!.boundingRectWithSize(CGSizeMake(lbl.frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    func buttonClicked(sender: UIButton)
    {
        hideAnimation()
        if(sender.tag == alertProps.btnNoTag)
        {
            noAction!()
        }
        else if(sender.tag == alertProps.btnYesTag)
        {
            yesAction!()
        }
    }
    
    
}
