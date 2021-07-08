//
//  ViewController.swift
//  DrawCircle
//
//  Created by Leon Kang on 2019/7/16.
//  Copyright © 2019 Leon Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var startPoint : Int = 0
    private var endPoint : Int = 0
    private var shapeLayer : CAShapeLayer?
    private var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.center = self.view.center
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        self.view.addSubview(button)
        
        drawCircle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    private func drawCircle() {
        startPoint = 0
        endPoint = 0
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let circlePath = UIBezierPath(ovalIn: rect)
        
        if let shapeLayer = self.shapeLayer {
            shapeLayer.removeFromSuperlayer()
        }
        shapeLayer = CAShapeLayer()
        shapeLayer!.frame = rect
        shapeLayer!.strokeColor = UIColor.blue.cgColor
        shapeLayer!.path = circlePath.cgPath
        shapeLayer!.lineWidth = 5.0
        shapeLayer!.lineJoin = .round
        shapeLayer!.lineCap = .round
        shapeLayer!.fillColor = UIColor.clear.cgColor
        shapeLayer!.position = self.view.center
        
        shapeLayer!.strokeStart = CGFloat(startPoint) / 10.0
        shapeLayer!.strokeEnd = CGFloat(endPoint) / 10.0
        
        self.view.layer.addSublayer(shapeLayer!)
    }

    @objc func updateLayer() {
        if startPoint == 0 && endPoint < 10 {
            endPoint += 1
        } else if startPoint < 10 && endPoint == 10 {
            startPoint += 1
        } else {
            drawCircle()
            return
        }
        shapeLayer?.strokeStart = CGFloat(startPoint) / 10.0
        shapeLayer?.strokeEnd = CGFloat(endPoint) / 10.0
    }
    
    @objc private func clickButton() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateLayer), userInfo: nil, repeats: true)
        }
//        updateLayer()
    }
}

