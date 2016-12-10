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
		
		let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		v.backgroundColor = .blue
		self.view.addSubview(v)
		
		UIView.animateKeyframes(withDuration: 5
			, delay: 0
			, options: UIViewKeyframeAnimationOptions.calculationModeLinear)
			.animations {
				UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
					v.frame.origin = CGPoint(x: 20, y: 0)
				}
				UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
					v.frame.origin = CGPoint(x: 20, y: 20)
				}
				UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
					v.frame.origin = CGPoint(x: 0, y: 20)
				}
				UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
					v.frame.origin = CGPoint(x: 0, y: 0)
				}
			}
			.completion {_ in}
		
		
		
		UIView.animate(withDuration: 5)
			.animations {
				self.view.backgroundColor = .red
			}
			.completion { _ in }
		UIView.animate(withDuration: 5, delay: 1, options: UIViewAnimationOptions.curveEaseInOut)
			.animations {
				self.view.layer.borderColor = UIColor.green.cgColor
				self.view.layer.borderWidth = 20
			}.completion { _ in }

				
		let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		v2.backgroundColor = .purple
		self.view.addSubview(v2)
		UIView.animate(withDuration: 5, delay: 1, usingSpringWithDamping: 0.1, initialSpringVelocity: 40, options: UIViewAnimationOptions.curveEaseInOut)
			.animations {
				v2.frame.origin.x = 150
			}.completion({ _ in
				v2.frame.origin.x = 0
			})
		
		
	}
}

