//
//  UIView_Extension.swift
//  AnimationAPI
//
//  Created by Derrick Ho on 12/10/16.
//  Copyright © 2016 Derrick Ho. All rights reserved.
//

import UIKit

// MARK: - UIKit Extension
extension UIKit.UIView {

	public struct Animator {
		fileprivate var animatorBlock: ((@escaping () -> (), @escaping (Bool) -> ()) -> ())
		fileprivate var animations: () -> () = { _ in }
		
		public init(animatorBlock: @escaping ((@escaping () -> (), @escaping (Bool) -> ()) -> ())) {
			self.animatorBlock = animatorBlock
		}
		
		public func animations(_ animations: @escaping () -> ()) -> Animator {
			var a = self
			a.animations = animations
			return a
		}
		
		public func completion(_ completion: @escaping (Bool) -> ()) {
			animatorBlock(animations, completion)
		}
	}

	public static func animate(withDuration duration: TimeInterval) -> Animator {
		return Animator(animatorBlock: {
			UIView.animate(withDuration: duration, animations: $0, completion: $1)
		})
	}
	
	public static func animate(withDuration duration: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions) -> Animator {
		return Animator(animatorBlock: {
			UIView.animate(withDuration: duration, delay: delay, options: options, animations: $0, completion: $1)
		})
	}
	
	public static func animate(withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIViewAnimationOptions ) -> Animator {
		return Animator(animatorBlock: {
			UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animations: $0, completion: $1)
		})
	}
	
	public static func animateKeyframes(withDuration duration: TimeInterval, delay: TimeInterval, options: UIViewKeyframeAnimationOptions) -> Animator {
		return Animator(animatorBlock: {
			UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: $0, completion: $1)
		})
	}
	
}







