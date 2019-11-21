//
//  PreloaderView.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
//import AngleGradientLayer

public class KVSpinnerView: UIView {
    
    //MARK: - Public Static
    
    
    ///    Customizes KVSpinnerView parameters.
    /// Use it before calling methods of KVSpinnerView.
    public static var settings = KVSpinnerViewSettings()
    
    /// Adds SpinnerView to UIWindow and start animating it
    public static func show() {
        KVSpinnerView.shared.animationTypeIsProgress = false
        KVSpinnerView.shared.startAnimating(onView: nil,
                                            withMessage: nil)
    }
    
    
    /// Adds SpinnerView to your view and start animating it
    /// - Parameter view: use from ViewController (for example: self.view).
    public static func show(on view: UIView) {
        KVSpinnerView.shared.animationTypeIsProgress = false
        KVSpinnerView.shared.startAnimating(onView: view,
                                            withMessage: nil)
    }
    
    /// Adds SpinnerView to UIWindow and start animating it with given progress.
    /// E.g. Use request progress closure (for example Alamofire .downloadProgress(_ progress))
    public static func showProgress() {
        KVSpinnerView.shared.animationTypeIsProgress = true
        KVSpinnerView.shared.startAnimating(onView: nil,
                                            withMessage: nil)
        KVSpinnerView.shared.progressChangesFirstTime = true
        KVSpinnerView.shared.handleProgress(nil, orProgressUnits: 0.05)
    }
    
    /// Adds SpinnerView to your view and start animating it
    /// with message and progress.
    /// - Parameter view: use from ViewController (for example: self.view).
    public static func showProgress(on view: UIView) {
        KVSpinnerView.shared.animationTypeIsProgress = true
        KVSpinnerView.shared.startAnimating(onView: view,
                                            withMessage: nil)
        KVSpinnerView.shared.progressChangesFirstTime = true
        KVSpinnerView.shared.handleProgress(nil, orProgressUnits: 0.05)
    }
    
    /// Handles progress of request.
    /// Use this method in 'downloadProgress' closure
    /// - Parameters:
    ///   - progress: progress that you should call from 'downloadProgress' closure
    public static func handle(progress: Progress) {
        KVSpinnerView.shared.progressChangesFirstTime = false
        KVSpinnerView.shared.handleProgress(progress, orProgressUnits: nil)
    }
    
    /// Handles progress of request units.
    /// You should specify number from 1.0 to 1.1.
    /// - Parameter progressUnits: value from 0.0 to 1.0. Use this value if you can't use value of 'Progress' type.
    public static func handle(progressUnits: CGFloat) {
        KVSpinnerView.shared.progressChangesFirstTime = false
        KVSpinnerView.shared.handleProgress(nil, orProgressUnits: progressUnits)
    }
    
    /// Removes SpinnerView from either UIWindow or ViewController's view
    /// and stops all animations
    public static func dismiss() {
        KVSpinnerView.shared.dismiss()
    }
    
    /// Removes SpinnerView from either UIWindow or ViewController's view
    /// and stops all animations after 'interval' time.
    /// - Parameter interval: incoming progress(use in request progress closure)
    public static func dismiss(after interval: TimeInterval) {
        KVSpinnerView.shared.dismiss(afterDelay: interval)
    }
    
    //MARK: - Private variables
    
    fileprivate static var shared = KVSpinnerView()
    fileprivate var circleLayers = [CircleLayer]()
    fileprivate var progressLayer = ProgressLayer()
    fileprivate var animationTypeIsProgress = false
    fileprivate var progressChangesFirstTime = false
    fileprivate var chosenView: UIView?
    
    fileprivate var isAnimating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    fileprivate var progress: CGFloat = 0.0 {
        didSet {
            progressDidChange()
        }
    }
    
    //MARK: - Private methods
    
    fileprivate func setup() {
        AnimationManager.shared.managerDelegate = self
        
        
        /// Circle layers
        for index in 1 ... KVSpinnerView.settings.linesCount {
            let circleLayer = CircleLayer(index: index)
            circleLayers.append(circleLayer)
            self.layer.addSublayer(circleLayer)
        }
        
        setupLayersPositions()
        tintColorDidChange()
    }
    
    fileprivate func setupLayersPositions() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        for circleLayer in circleLayers {
            circleLayer.position = center
        }
    }
    
    fileprivate func updateAnimation() {
        if animationTypeIsProgress {
            updateProgressAnimation()
            return
        }
        switch KVSpinnerView.settings.animationStyle {
        case .standart:
            updateStandartAnimation()
        case .infinite:
            updateInfiniteAnimation()
        }
    }
    
    fileprivate func updateStandartAnimation() {
        if isAnimating == true {
            circleLayers.forEach({ (circleLayer) in
                circleLayer.add(AnimationManager.shared.strokeEndAnimation,
                                forKey: "strokeEndAnimation")
                circleLayer.add(AnimationManager.shared.strokeStartAnimation,
                                forKey: "strokeStartAnimation")
            })
        }
        else {
            clearAllAnimation()
        }
    }
    
    fileprivate func updateInfiniteAnimation() {
        if isAnimating == true {
            circleLayers.forEach({ (circleLayer) in
                circleLayer.add(AnimationManager.shared.infiniteStrokeEndAnimation,
                                forKey: "infiniteStrokeStartAnimation")
                circleLayer.add(AnimationManager.shared.infiniteStrokeRotateAnimation(isOdd: circleLayer.index % 2 == 0),
                                forKey: "infiniteStrokeRotateAnimation")
            })
        } else {
            clearAllAnimation()
        }
    }
    
    fileprivate func updateProgressAnimation() {
        if isAnimating {
            circleLayers.forEach({ (circleLayer) in
                circleLayer.add(AnimationManager.shared.infiniteStrokeEndAnimation,
                                forKey: "infiniteStrokeStartAnimation")
                circleLayer.add(AnimationManager.shared.infiniteStrokeRotateAnimation(isOdd: circleLayer.index % 2 == 0),
                                forKey: "infiniteStrokeRotateAnimation")
            })
        } else {
            clearAllAnimation()
        }
    }
    
    fileprivate func progressDidChange() {
        let assertion = progress >= 0.0 || progress <= 1.0
        assert(assertion, "Progress value should vary between 0.0 and 1.0")
        if progress == 1.0 {
            clearAllAnimation()
        } else {
            for circleLayer in circleLayers {
                circleLayer.add(AnimationManager.shared.animateStrokeEnd(toValue: progress), forKey: "strokeEndAnimation")
            }
        }
    }
    
    //MARK: - Override
    override public func tintColorDidChange() {
        super.tintColorDidChange()
        for circleLayer in circleLayers {
            circleLayer.strokeColor = KVSpinnerView.settings.tintColor.cgColor
        }
    }
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupLayersPositions()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        fatalError("You have to use 'KVSpinnerView.show()' instead.\n")
    }
}

//MARK: - Private helping methods
fileprivate extension KVSpinnerView {
    
    fileprivate func startAnimating(onView view: UIView?,
                                    withMessage message: String?) {
        clearAllAnimation()
        isAnimating = true
        if let view = view {
            chosenView = view
            addSubViewToParentView(view)
        } else {
            addViewToWindow()
        }
    }
    
    fileprivate func handleProgress(_ progress: Progress?,
                                    orProgressUnits units: CGFloat?) {
        if let progress = progress {
            let completed = CGFloat(progress.fractionCompleted)
            if completed > 0.05 || progressChangesFirstTime{
                self.progress = completed
            }
        }
        if let units = units {
            if  units > 0.05 || progressChangesFirstTime {
                self.progress = units
            }
        }
    }
    
    fileprivate func dismiss() {
        UIView.animate(withDuration: KVSpinnerView.settings.fadeOutDuration,
                       delay: KVSpinnerView.settings.minimumDismissDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.alpha = 0.0
        }, completion: { (success) in
            self.isAnimating = false
            self.progress = 0.0
            self.removeFromSuperview()
        })
    }
    
    fileprivate func dismiss(afterDelay delay: TimeInterval) {
        let minDelay = KVSpinnerView.settings.minimumDismissDelay
        UIView.animate(withDuration: KVSpinnerView.settings.fadeOutDuration,
                       delay: minDelay > delay ? minDelay : delay,
                       options: .curveEaseInOut,
                       animations: {
                        self.alpha = 0.0
        }) { (success) in
            self.isAnimating = false
            self.progress = 0.0
            self.removeFromSuperview()
        }
    }
    
    //MARK: -
    
    fileprivate func addViewToWindow() {
        let window = UIApplication.shared.keyWindow!
        let radius = KVSpinnerView.settings.spinnerRadius
        self.frame = CGRect(x: window.bounds.midX,
                            y: window.bounds.midY,
                            width: radius,
                            height: radius)
        self.center = CGPoint(x: window.bounds.midX,
                              y: window.bounds.midY) // Height of textLayer
        self.alpha = 0.0
        window.addSubview(self)
        UIView.animate(withDuration: KVSpinnerView.settings.fadeInDuration,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.alpha = 1.0
        }, completion: nil)
    }
    
    fileprivate func addSubViewToParentView(_ parentView: UIView) {
        let radius = KVSpinnerView.settings.spinnerRadius
        self.frame = CGRect(x: parentView.bounds.midX,
                            y: parentView.bounds.midY,
                            width: radius,
                            height: radius)
        
        self.center = CGPoint(x: parentView.bounds.midX,
                              y: parentView.bounds.midY)  // Height of textLayer
        self.alpha = 0.0
        parentView.addSubview(self)
        UIView.animate(withDuration: KVSpinnerView.settings.fadeInDuration,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.alpha = 1.0
        }, completion: nil)
    }
    
    fileprivate func clearAllAnimation() {
        circleLayers.forEach({ (circleLayer) in
            circleLayer.removeAllAnimations()
        })
    }
}

//MARK: - AnimationManagerDelegate
extension KVSpinnerView: AnimationManagerDelegate {
    
    func managerDidFinishProgressAnimation(_ animation: CAAnimation, _ manager: AnimationManager) {
        AnimationManager.shared.downloadedProgress = progress
    }
    
}

public struct KVSpinnerViewSettings {
    
    /// Style animation enum
    /// - standart: strokeEnd and strokeStart animations have different start time
    /// - infinite: strokeEnd and strokeStart animations have same start time
    public enum AnimationStyle {
        case standart
        case infinite
    }
    
    /// Style of Animation.
    /// Available: standart(default) and infinite.
    public var animationStyle = AnimationStyle.infinite
    
    /// Radius of KVSpinnerView. Default is 50
    public var spinnerRadius: CGFloat = 44
    
    /// Width of each bezier line. Default is 4.0
    public var linesWidth: CGFloat = 2.0
    
    /// Count of KVSpinnerView lines. Default is 4
    public var linesCount = 2
    
    /// Aplha of KVSpinnerView. Default is 1.0
    public var backgroundOpacity: Float = 1.0
    
    /// Color of KVSpinnerView lines. Default is UIColor.white
    public var tintColor: UIColor = .gray
    
    /// If you change this value then KVSpinnerView definetely will dismiss after given interval or later.
    /// Default is 0.0
    public var minimumDismissDelay = 0.0
    
    /// Period time interval of one animation. Default is 2.0
    public var animationDuration = 2.0
    
    /// Duration of appearing animation. Default is 0.3
    public var fadeInDuration = 0.3
    
    /// Duration of dissappearing animation. Default is 0.3
    public var fadeOutDuration = 0.3
    
    
}

protocol AnimationManagerDelegate: class {
    func managerDidFinishProgressAnimation(_ animation: CAAnimation, _ manager: AnimationManager)
}

class AnimationManager: NSObject {
    
    static var shared = AnimationManager()
    
    weak var managerDelegate: AnimationManagerDelegate?
    
    //MARK: - Variables
    
    internal lazy var strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = KVSpinnerView.settings.animationDuration - 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = KVSpinnerView.settings.animationDuration
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    internal lazy var strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = KVSpinnerView.settings.animationDuration - 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = KVSpinnerView.settings.animationDuration
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    internal lazy var infiniteStrokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = 0.0
        animation.fromValue = 0.0
        animation.toValue = 0.6
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        return animation
    }()
    
    internal func infiniteStrokeRotateAnimation(isOdd: Bool) -> CAAnimation  {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.byValue = isOdd ? M_PI * -2.0 : M_PI * 2.0
        
        let group = CAAnimationGroup()
        group.beginTime = 0.5
        group.duration = 1.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }
    
    internal lazy var fadeInAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 1
        animation.duration = KVSpinnerView.settings.fadeInDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }()
    
    internal lazy var fadeOutAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.repeatCount = 1
        animation.duration = KVSpinnerView.settings.fadeOutDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        return animation
    }()
    
    //MARK: - Functions
    
    internal var downloadedProgress: CGFloat = 0.0
    
    internal func animateStrokeEnd(toValue value: CGFloat) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = downloadedProgress
        animation.toValue = value
        animation.repeatCount = 1
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        
        return animation
    }
}

extension AnimationManager: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        managerDelegate?.managerDidFinishProgressAnimation(anim, self)
    }
}

class CircleLayer: CAShapeLayer {
    
    var index: Int
    
    init(index: Int) {
        self.index = index
        super.init()
        path = bezierPath.cgPath
        lineWidth = KVSpinnerView.settings.linesWidth
        opacity = KVSpinnerView.settings.backgroundOpacity
        fillColor = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bezierPath: UIBezierPath {
        return layerPath()
    }
    
    fileprivate func layerPath() -> UIBezierPath {
        let radius = KVSpinnerView.settings.spinnerRadius
        let linesDistance = radius / 5
        
        let startEvenAngle = CGFloat(-M_PI_2)
        let endEvenAngle = startEvenAngle + CGFloat(M_PI * 2)
        let startOddAngle = CGFloat(0)
        let endOddAngle = startOddAngle + CGFloat(M_PI * 2)
        
        let isIndexEven = index % 2 == 1
        let path = UIBezierPath(
            arcCenter: .zero,
            radius: radius - linesDistance * CGFloat(index),
            startAngle: isIndexEven ? startEvenAngle : startOddAngle,
            endAngle: isIndexEven ? endEvenAngle : endOddAngle,
            clockwise: isIndexEven ? true : false)
        return path
    }
    
}
//
//class CircleLayer: CAShapeLayer {
//
//    var index: Int
//    var startColor: UIColor = .white
//    var endColor:   UIColor = .blue
//
//    init(index: Int) {
//        self.index = index
//        super.init()
//
//        let bezier = bezierPath
//
//        var lineWidth: CGFloat = 3
//        var strokeColor: UIColor = .blue
//        var endAngle: CGFloat = 0
//        var maxAngle: CGFloat = 360
//
//
//        let gradations = 255
//
//        let startAngle = -endAngle + maxAngle
//        let center = CGPoint(x: bounds.midX, y: bounds.midY)
//        let radius = CGFloat(22.0)
//        var angle = startAngle
//
//        bezier.lineWidth = lineWidth
//        bezier.lineCapStyle = CGLineCap.square
//
//        for i in 1 ... gradations {
//            let percent = CGFloat(i) / CGFloat(gradations)
//            let endAngle = startAngle - percent * maxAngle
//            bezier.addArc(withCenter: center, radius: radius, startAngle: angle, endAngle: endAngle, clockwise: true)
//            strokeColor.withAlphaComponent(percent).setStroke()
//            bezier.stroke()
//            angle = endAngle
//        }
//
//
//        path = bezier.cgPath
//
//        lineWidth = KVSpinnerView.settings.linesWidth
//        opacity = KVSpinnerView.settings.backgroundOpacity
//        fillColor = nil
//
//    }
//
//    private let gradientLayer: CAGradientLayer = {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.type = CAGradientLayerType.radial
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        return gradientLayer
//    }()
//
//
//
//    let DefaultGradientBorderColors: [AnyObject] = [
//        UIColor.red.cgColor,
//        UIColor.green.cgColor,
//        UIColor.blue.cgColor,
//        UIColor.red.cgColor, // Repeat the first color to make a smooth transition
//    ]
//    let DefaultGradientBorderWidth: CGFloat = 4
//
//    func getGradient() -> CALayer {
//        let l: AngleGradientBorderLayer = AngleGradientBorderLayer.init(layer: self)
//        l.contentsScale = UIScreen.main.scale
//        l.colors = DefaultGradientBorderColors
//        l.gradientBorderWidth = DefaultGradientBorderWidth
//        return l
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var bezierPath: UIBezierPath = UIBezierPath()
//
//    fileprivate func layerPath() -> UIBezierPath {
//        let radius = KVSpinnerView.settings.spinnerRadius
//        let linesDistance = radius / 5
////
//        let startEvenAngle = CGFloat(-M_PI_2)
//        let endEvenAngle = startEvenAngle + CGFloat(M_PI * 2)
//        let startOddAngle = CGFloat(0)
//        let endOddAngle = startOddAngle + CGFloat(M_PI * 2)
////
//        let isIndexEven = index % 2 == 1
//        let path = UIBezierPath(
//            arcCenter: .zero,
//            radius: radius - linesDistance * CGFloat(index),
//            startAngle: isIndexEven ? startEvenAngle : startOddAngle,
//            endAngle: isIndexEven ? endEvenAngle : endOddAngle,
//            clockwise: isIndexEven ? true : false)
//
//        return path
//    }
//
//
//}
//
//class AngleGradientBorderLayer: AngleGradientLayer {
//
//    // Properties
//    var gradientBorderWidth: CGFloat = 1
//
//    override func draw(in ctx: CGContext!) {
//        let shapePath = UIBezierPath(roundedRect: bounds.insetBy(dx: gradientBorderWidth, dy: gradientBorderWidth), cornerRadius: bounds.height / 2)
//
//        let shapeCopyPath = shapePath.cgPath.copy(strokingWithWidth: gradientBorderWidth, lineCap: CGLineCap.butt, lineJoin: CGLineJoin.bevel, miterLimit: 0)
//
//        ctx.saveGState()
//        ctx.addPath(shapeCopyPath)
//        ctx.clip()
//        super.draw(in: ctx)
//        ctx.restoreGState()
//    }
//}

class ProgressLayer: CATextLayer {
    
    var progress: CGFloat = 0
    
    override init() {
        super.init()
        string = "\(progress)"
        //        foregroundColor = KVSpinnerViewSettings.progressTextColor.cgColor
        frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        fontSize = 24.0
        alignmentMode = CATextLayerAlignmentMode.justified
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//class RainbowCircle: UIView {
//
//    private var radius: CGFloat {
//        return frame.width>frame.height ? frame.height/2 : frame.width/2
//    }
//
//    private var stroke: CGFloat = 10
//    private var padding: CGFloat = 5
//
//    //MARK: - Drawing
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        drawRainbowCircle(outerRadius: radius - padding, innerRadius: radius - stroke - padding, resolution: 1)
//    }
//
//    init(frame: CGRect, lineHeight: CGFloat) {
//        super.init(frame: frame)
//        stroke = lineHeight
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    /*
//     Resolution should be between 0.1 and 1
//     */
//    private func drawRainbowCircle(outerRadius: CGFloat, innerRadius: CGFloat, resolution: Float) {
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        context.saveGState()
//        context.translateBy(x: self.bounds.midX, y: self.bounds.midY) //Move context to center
//
//        let subdivisions:CGFloat = CGFloat(resolution * 512) //Max subdivisions of 512
//
//        let innerHeight = (CGFloat.pi*innerRadius)/subdivisions //height of the inner wall for each segment
//        let outterHeight = (CGFloat.pi*outerRadius)/subdivisions
//
//        let segment = UIBezierPath()
//        segment.move(to: CGPoint(x: innerRadius, y: -innerHeight/2))
//        segment.addLine(to: CGPoint(x: innerRadius, y: innerHeight/2))
//        segment.addLine(to: CGPoint(x: outerRadius, y: outterHeight/2))
//        segment.addLine(to: CGPoint(x: outerRadius, y: -outterHeight/2))
//        segment.close()
//
//
//        //Draw each segment and rotate around the center
//        for i in 0 ..< Int(ceil(subdivisions)) {
//            UIColor(hue: CGFloat(i)/subdivisions, saturation: 1, brightness: 1, alpha: 1).set()
//            segment.fill()
//            //let lineTailSpace = CGFloat.pi*2*outerRadius/subdivisions  //The amount of space between the tails of each segment
//            let lineTailSpace = CGFloat.pi*2*outerRadius/subdivisions
//            segment.lineWidth = lineTailSpace //allows for seemless scaling
//            segment.stroke()
//
//            //Rotate to correct location
//            let rotate = CGAffineTransform(rotationAngle: -(CGFloat.pi*2/subdivisions)) //rotates each segment
//            segment.apply(rotate)
//        }
//
//        context.translateBy(x: -self.bounds.midX, y: -self.bounds.midY) //Move context back to original position
//        context.restoreGState()
//    }
//}
