//
//  ViewController.swift
//  AnimationAPI
//
//  Created by Derrick Ho on 12/10/16.
//  Copyright © 2016 Derrick Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		UIView.animate(withDuration: 5)
			.animations {
				self.view.backgroundColor = .red
			}
			.completion { _ in
				self.view.backgroundColor = .white
				
				UIView.animate(withDuration: 5)
					.delay(5)
					.animations {
						self.view.backgroundColor = .green
					}.completion { _ in
						self.view.backgroundColor = .white
						
						let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
						v.backgroundColor = .blue
						self.view.addSubview(v)
						UIView.animate(withDuration: 5)
							.delay(1)
							.usingSpringWithDamping(0.1, initialSpringVelocity: 40)
							.animations {
								v.frame.origin.x = 150
							}.completion({ _ in
								v.frame.origin.x = 0
								
								UIView.animateKeyframes(withDuration: 5
									, delay: 0
									, options: UIViewKeyframeAnimationOptions.calculationModeLinear
									, animations: {
										UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
											v.frame.origin = CGPoint(x: 20, y: 0)
										})
										UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
											v.frame.origin = CGPoint(x: 20, y: 20)
										})
										UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2, animations: {
											v.frame.origin = CGPoint(x: 0, y: 20)
										})
										UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
											v.frame.origin = CGPoint(x: 0, y: 0)
										})
								}, completion: { _ in
									
								})
							})
				}
		}
		
		
		
		

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

