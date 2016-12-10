//
//  UIView_Extension.swift
//  AnimationAPI
//
//  Created by Derrick Ho on 12/10/16.
//  Copyright © 2016 Derrick Ho. All rights reserved.
//

import UIKit

// MARK: - Animator properties
public protocol AnimatorComposition_Properties {
	var _duration: TimeInterval { get set }
	var _animations: () -> () { get set }
}

public protocol AnimatorCompositionWithDelay_Properties {
	var _delay: TimeInterval { get set }
}

public protocol AnimatorCompositionWithOptions_Properties: AnimatorComposition_Properties, AnimatorCompositionWithDelay_Properties {
	var _options: UIViewAnimationOptions { get set }
}

public protocol AnimatorCompositionWithSpringVelocity_Properties: AnimatorCompositionWithOptions_Properties {
	var _springDamping: CGFloat { get set }
	var _initialSpringVelocity: CGFloat { get set }
	
}

// MARK: - Animator methods

public protocol AnimatorComposition {
	func duration(_ duration: TimeInterval) -> Self
	func animations(_ animations: @escaping () -> ()) -> Self
	
	func completion(_ completion: @escaping (Bool) -> ())
	
	// transition
	func delay(_ delay: TimeInterval) -> AnimatorCompositionWithOptions
	func options(_ options: UIViewAnimationOptions) -> AnimatorCompositionWithOptions
	func usingSpringWithDamping(_ springWithDamping: CGFloat, initialSpringVelocity: CGFloat) -> AnimatorCompositionWithSpringVelocity
}

public protocol AnimatorCompositionWithDelay {
	func delay(_ delay: TimeInterval) -> Self
}

public protocol AnimatorCompositionWithOptions: AnimatorComposition, AnimatorCompositionWithDelay {
	func options(_ options: UIViewAnimationOptions) -> Self
}

public protocol AnimatorCompositionWithSpringVelocity: AnimatorCompositionWithOptions {
	func usingSpringWithDamping(_ springWithDamping: CGFloat, initialSpringVelocity: CGFloat) -> Self
}

// MARK: - Protocol Extensions

extension AnimatorComposition where Self: AnimatorComposition_Properties {
	public func duration(_ duration: TimeInterval) -> Self {
		var a = self
		a._duration = duration
		return a
	}
	public func animations(_ animations: @escaping () -> ()) -> Self {
		var a = self
		a._animations = animations
		return a
	}
	public func completion(_ completion: @escaping (Bool) -> ()) {
		UIView.animate(withDuration: _duration
			, animations: _animations
			, completion: completion)
	}
	
	// transition
	public func delay(_ delay: TimeInterval) -> AnimatorCompositionWithOptions {
		return (self as! AnimatorCompositionWithOptions).delay(delay)
	}
	public func options(_ options: UIViewAnimationOptions) -> AnimatorCompositionWithOptions {
		return (self as! AnimatorCompositionWithOptions).options(options)
	}
	public func usingSpringWithDamping(_ springWithDamping: CGFloat, initialSpringVelocity: CGFloat) -> AnimatorCompositionWithSpringVelocity {
		return (self as! AnimatorCompositionWithSpringVelocity)
			.usingSpringWithDamping(springWithDamping
				, initialSpringVelocity: initialSpringVelocity)
	}
}

extension AnimatorCompositionWithDelay where Self: AnimatorCompositionWithDelay_Properties {
	public func delay(_ delay: TimeInterval) -> Self {
		var a = self
		a._delay = delay
		return a
	}
}

extension AnimatorCompositionWithOptions where Self: AnimatorCompositionWithOptions_Properties {

	public func options(_ options: UIViewAnimationOptions) -> Self {
		var a = self
		a._options = options
		return a
	}
	public func completion(_ completion: @escaping (Bool) -> ()) {
		UIView.animate(withDuration: _duration
			, delay: _delay
			, options: _options
			, animations: _animations
			, completion: completion)
	}
}

extension AnimatorCompositionWithSpringVelocity where Self: AnimatorCompositionWithSpringVelocity_Properties {
	
	func usingSpringWithDamping(_ springWithDamping: CGFloat, initialSpringVelocity: CGFloat) -> Self {
		var a = self
		a._springDamping = springWithDamping
		a._initialSpringVelocity = initialSpringVelocity
		return a
	}
	
	public func completion(_ completion: @escaping (Bool) -> ()) {
		UIView.animate(
			withDuration: _duration
			, delay: _delay
			, usingSpringWithDamping: _springDamping
			, initialSpringVelocity: _initialSpringVelocity
			, options: _options
			, animations: _animations
			, completion: completion)
	}

}


// MARK: - UIKit Extension
extension UIKit.UIView {
	
	fileprivate struct Animator:
		AnimatorComposition, AnimatorComposition_Properties
		, AnimatorCompositionWithOptions, AnimatorCompositionWithOptions_Properties
		, AnimatorCompositionWithSpringVelocity, AnimatorCompositionWithSpringVelocity_Properties
	{

		var _duration: TimeInterval = 0
		var _animations: () -> () = {}
		
		var _delay: TimeInterval = 0
		var _options: UIViewAnimationOptions = .curveEaseInOut
		
		var _springDamping: CGFloat = 1
		var _initialSpringVelocity: CGFloat = 0
	}

	public static func animate(withDuration duration: TimeInterval) -> AnimatorComposition {
		return Animator().duration(duration)
	}
	
}







