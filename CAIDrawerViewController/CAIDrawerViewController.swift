//
//  CAIDrawerViewController.swift
//  CAIDrawerViewController
//
//  Created by 李玉峰 on 14-10-14.
//  Copyright (c) 2014年 CAI. All rights reserved.
//

import UIKit

enum CAIMainSate : Int{
    case closed
    case open
    case openWide
}

class CAIDrawerViewController: UIViewController {

    //私有变量


    //私有属性
    private var _mainView:UIView! //存放主界面的View
    private var _leftView:UIView! //用于存放左边ViewController.view
    private var _rightView:UIView! //存放右边的ViewController.view

    private var _leftViewController:UIViewController?
    private var _mainViewController:UIViewController?
    private var _rightViewController:UIViewController?


    //setter And getter
    var mainView:UIView?{
        get{
            return _mainView
        }
        set{
            _mainView.removeFromSuperview()
            _mainView = newValue;
        }
    }

    var leftViewController:UIViewController?{
        get{
            return _leftViewController
        }
        set{
            self.replaceViewController(_leftViewController, newViewController: newValue, containerViewController: self, containerView: self.view) { () -> () in
                self._leftViewController = newValue;
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }

    var mainViewController:UIViewController? {
        get{
            return _mainViewController
        }
        set{
            self.replaceViewController(_mainViewController, newViewController: newValue, containerViewController: self, containerView: self.view) { () -> () in
                self._mainViewController = newValue
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }

    var rightViewController:UIViewController? {
        get{
            return _rightViewController
        }
        set{
            self.replaceViewController(_rightViewController, newViewController: newValue, containerViewController: self, containerView: self.view) { () -> () in
                self._rightViewController = newValue
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //公开方法
    func setMainViewController(mainViewController:UIViewController? ,animated :Bool ,completion:(()->())?){
        if !animated {
            self.mainViewController = mainViewController
            completion!()
        }else if _mainViewController !== mainViewController {
            //用动画完成切换
        }
    }


}

// 重写方法
extension CAIDrawerViewController {

}

// 功能
extension CAIDrawerViewController {
//    - (void)setPaneState:(MSDynamicsDrawerPaneState)paneState animated:(BOOL)animated allowUserInterruption:(BOOL)allowUserInterruption completion:(void (^)(void))completion
//    {
//    // If the drawer is getting opened and there's more than one possible direction enforce that the directional eqivalent is used
//    MSDynamicsDrawerDirection direction;
//    if ((paneState != MSDynamicsDrawerPaneStateClosed) && (self.currentDrawerDirection == MSDynamicsDrawerDirectionNone)) {
//    NSAssert(MSDynamicsDrawerDirectionIsCardinal(self.possibleDrawerDirection), @"Unable to set the pane to an open state with multiple possible drawer directions, as the drawer direction to open in is indeterminate. Use `setPaneState:inDirection:animated:allowUserInterruption:completion:` instead.");
//    direction = self.possibleDrawerDirection;
//    } else {
//    direction = self.currentDrawerDirection;
//    }
//    [self setPaneState:paneState inDirection:direction animated:animated allowUserInterruption:allowUserInterruption completion:completion];
//    }
    func setMainState(mainState:CAIMainSate ,animated:Bool ,allowInterruption:Bool ,completion:()->()){
    }
}

// 私有方法
extension CAIDrawerViewController {

    //替换childViewController
    private func replaceViewController(existingViewController:UIViewController? ,newViewController :UIViewController? , containerViewController:UIViewController! ,containerView:UIView! , completion:(()->())?)
    {
        if (existingViewController==nil && newViewController != nil){
            newViewController?.willMoveToParentViewController(containerViewController)
            newViewController?.beginAppearanceTransition(true, animated: false)
            self.addChildViewController(newViewController!)
            newViewController?.view.frame = containerView.bounds
            containerView.addSubview((newViewController?.view)!)
            newViewController?.didMoveToParentViewController(containerViewController)
            newViewController?.endAppearanceTransition()
            if (completion != nil) {
                completion!()
            }
        }else if (!(existingViewController==nil) && newViewController == nil) {
            existingViewController?.willMoveToParentViewController(nil);
            existingViewController?.beginAppearanceTransition(false, animated: false)
            existingViewController?.view.removeFromSuperview()
            existingViewController?.removeFromParentViewController()
            existingViewController?.didMoveToParentViewController(nil)
            existingViewController?.endAppearanceTransition()
            if (completion != nil) {
                completion!()
            }
        }else if !(existingViewController==nil) && !(newViewController==nil) {
            newViewController?.willMoveToParentViewController(containerViewController)
            existingViewController?.willMoveToParentViewController(nil)
            existingViewController?.beginAppearanceTransition(false, animated: false)
            existingViewController?.view.removeFromSuperview()
            existingViewController?.removeFromParentViewController()
            existingViewController?.didMoveToParentViewController(nil)
            existingViewController?.endAppearanceTransition()
            newViewController?.beginAppearanceTransition(true, animated: false)
            self.addChildViewController(newViewController!)
            newViewController?.view.frame = containerView.bounds
            containerView.addSubview((newViewController?.view)!)
            newViewController?.didMoveToParentViewController(containerViewController)
            newViewController?.endAppearanceTransition()
            if (completion != nil) {
                completion!()
            }
        }
    }

}