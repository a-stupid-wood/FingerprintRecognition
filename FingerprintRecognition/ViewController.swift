//
//  ViewController.swift
//  FingerprintRecognition
//
//  Created by 王凯彬 on 2017/8/17.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        //添加一个按钮
        let fingerPrintBtn = UIButton(type: .custom)
        fingerPrintBtn.backgroundColor = UIColor.orange
        fingerPrintBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        fingerPrintBtn.center = view.center;
        fingerPrintBtn.setTitle("指纹识别", for: .normal)
        view.addSubview(fingerPrintBtn)
        //添加点击方法
        fingerPrintBtn.addTarget(self, action: #selector(fingerPrintBtnClick), for: .touchUpInside)
    }
    
    func fingerPrintBtnClick() {
        FingerPrinterIdentification()
    }
    
    //MARK: 指纹识别方法
    func FingerPrinterIdentification() {
        //判断iOS8及以后的版本
        let systemVersion = UIDevice.current.systemVersion;
        let mainVersion = systemVersion.components(separatedBy: CharacterSet(charactersIn: "."))[0]
        if let version = Double(mainVersion)
        {
            if version >= 8.0 {
                //1.从iPhone5S开始，出现指纹识别技术，所以说在此处可以进一步判断是否是5S以后机型
                //2.创建本地验证上下文对象-->导入LocalAuthentication框架
                let context = LAContext()
                //3.判断是否使用指纹识别
                //Evaluate：评估
                //Policy：策略
                //.deviceOwnerAuthenticationWithBiometrics: 设备拥有者授权 用生物识别技术
                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                    //4.可以使用的前提下就会调用
                    //localizedReason本地原因alert显示
                    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请允许指纹识别", reply: { (success, error) in
                        if success {
                            //在主线程中更新UI
                            DispatchQueue.main.sync {
                                let alertVC = UIAlertController(title: " 提示 ", message: "识别成功", preferredStyle: .alert)
                                alertVC.addAction(UIAlertAction(title: " 确定 ", style: .cancel, handler: { (action) in
                                    
                                }))
                                self.present(alertVC, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }else {
                print("请确保(5S以上机型),TouchID未打开")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


