//
//  Image+Filter.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/31.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import CoreImage
import UIKit

public extension UIImage {
	public var ci:CIImage? {
		guard let cgImage = self.cgImage else { return nil }
		let ciImage = CIImage(cgImage: cgImage)
		return ciImage
	}
}

public extension CIImage {
	public var ui:UIImage? {
		let ciContext = CIContext()
		guard let oCgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
		return UIImage(cgImage: oCgImage, scale: UIScreen.main.scale, orientation: .up)
	}
	
	public func sizedImage(size:CGSize) -> UIImage? {
		let ciContext = CIContext()
		guard let oCgImage = ciContext.createCGImage(self, from: CGRect(origin:CGPoint(), size: size)) else { return nil }
		return UIImage(cgImage: oCgImage, scale: UIScreen.main.scale, orientation: .up)
	}
}

public extension CIImage {
	typealias ColorComponents = (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)
	
	public func boxBlur(radius:CGFloat = 10.0) -> CIImage? {
		let filter = CIFilter(name: "CIBoxBlur", withInputParameters: [
			"inputImage": self, "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public func discBlur(radius:CGFloat = 8.0) -> CIImage? {
		let filter = CIFilter(name: "CIDiscBlur", withInputParameters: [
			"inputImage": self, "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public func gaussianBlur(radius:CGFloat = 8.0) -> CIImage? {
		let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [
			"inputImage": self, "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public func medianFilter() -> CIImage? {
		let filter = CIFilter(name: "CIMedianFilter", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func motionBlur(radius:CGFloat = 20.0, angle:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIMotionBlur", withInputParameters: [
			"inputImage": self, "inputRadius": radius, "inputAngle": angle ])
		return filter?.outputImage
	}
	
	public func noiseReduction(noiseLevel:CGFloat = 0.02, sharpness:CGFloat = 0.4) -> CIImage? {
		let filter = CIFilter(name: "CINoiseReduction", withInputParameters: [
			"inputImage": self, "inputNoiseLevel": noiseLevel, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	public func zoomBlur(center:CGPoint = CGPoint(x: 150.0, y: 150.0), amount:CGFloat = 20.0) -> CIImage? {
		let filter = CIFilter(name: "CIZoomBlur", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputAmount": amount ])
		return filter?.outputImage
	}
	
	public func colorClamp(minComponents:ColorComponents = (0, 0, 0, 0), maxComponents:ColorComponents = (0, 0, 0, 0)) -> CIImage? {
		let filter = CIFilter(name: "CIColorClamp", withInputParameters: [
			"inputImage": self, "inputMinComponents": CIVector(componets: minComponents), "inputMaxComponents": CIVector(componets: maxComponents) ])
		return filter?.outputImage
	}
	
	public func colorControls(brightness:CGFloat, saturation:CGFloat = 1.0, contrast:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CINoiseReduction", withInputParameters: [
			"inputImage": self, "inputSaturation": saturation, "inputBrightness": brightness, "inputContrast": contrast ])
		return filter?.outputImage
	}
	
	public func colorMatrix(redVector:ColorComponents = (1, 0, 0, 0), greenVector:ColorComponents = (0, 1, 0, 0), blueVector:ColorComponents = (0, 0, 1, 0), alpahVector:ColorComponents = (0, 0, 0, 1), biasVector:ColorComponents = (0, 0, 0, 0)) -> CIImage? {
		let filter = CIFilter(name: "CIColorClamp", withInputParameters: [
			"inputImage": self, "inputRVector": CIVector(componets: redVector), "inputGVector": CIVector(componets: greenVector), "inputBVector": CIVector(componets: blueVector), "inputAVector": CIVector(componets: alpahVector), "inputBiasVector": CIVector(componets: biasVector) ])
		return filter?.outputImage
	}
	
	public func colorPolynomial(redVector:ColorComponents = (1, 0, 0, 0), greenVector:ColorComponents = (0, 1, 0, 0), blueVector:ColorComponents = (0, 0, 1, 0), alpahVector:ColorComponents = (0, 0, 0, 1), biasVector:ColorComponents = (0, 0, 0, 0)) -> CIImage? {
		let filter = CIFilter(name: "CIColorPolynomial", withInputParameters: [
			"inputImage": self, "inputRedCoefficients": CIVector(componets: redVector), "inputGreenCoefficients": CIVector(componets: greenVector), "inputBlueCoefficients": CIVector(componets: blueVector), "inputAlphaCoefficients": CIVector(componets: alpahVector) ])
		return filter?.outputImage
	}
	
	public func exposureAdjust(ev:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIExposureAdjust", withInputParameters: [
			"inputImage": self, "inputEV": ev ])
		return filter?.outputImage
	}
	
	public func gammaAdjust(ev:CGFloat = 0.75) -> CIImage? {
		let filter = CIFilter(name: "CIGammaAdjust", withInputParameters: [
			"inputImage": self, "inputPower": ev ])
		return filter?.outputImage
	}
	
	public func hueAdjust(ev:CGFloat = 0.75) -> CIImage? {
		let filter = CIFilter(name: "CIHueAdjust", withInputParameters: [
			"inputImage": self, "inputAngle": ev ])
		return filter?.outputImage
	}
	
	public func linearToSRGBToneCurve(ev:CGFloat = 0.75) -> CIImage? {
		let filter = CIFilter(name: "CILinearToSRGBToneCurve", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func SRGBToneCurveToLinear(ev:CGFloat = 0.75) -> CIImage? {
		let filter = CIFilter(name: "CISRGBToneCurveToLinear", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func temperatureAndTint(neutral:(temp:CGFloat, tint:CGFloat) = (6500, 0), targetNeutral:(temp:CGFloat, tint:CGFloat) = (6500, 0)) -> CIImage? {
		let filter = CIFilter(name: "CITemperatureAndTint", withInputParameters: [
			"inputImage": self, "inputNeutral": CIVector(x: neutral.temp, y: neutral.tint), "inputTargetNeutral": CIVector(x:targetNeutral.temp, y: targetNeutral.tint) ])
		return filter?.outputImage
	}
	
	public func toneCurve(point0:CGPoint = CGPoint(x: 0, y: 0), point1:CGPoint = CGPoint(x: 0.25, y: 0.25), point2:CGPoint = CGPoint(x: 0.5, y: 0.5), point3:CGPoint = CGPoint(x: 0.75, y: 0.75), point4:CGPoint = CGPoint(x: 1, y: 1)) -> CIImage? {
		let filter = CIFilter(name: "CIToneCurve", withInputParameters: [
			"inputImage": self, "inputPoint0": CIVector(x: point0.x, y: point0.y), "inputPoint1": CIVector(x: point1.x, y: point1.y), "inputPoint2": CIVector(x: point2.x, y: point2.y), "inputPoint3": CIVector(x: point3.x, y: point3.y), "inputPoint4": CIVector(x: point4.x, y: point4.y) ])
		return filter?.outputImage
	}
	
	public func vibrance(amount:CGFloat) -> CIImage? {
		let filter = CIFilter(name: "CIVibrance", withInputParameters: [
			"inputImage": self, "inputAmount" : amount ])
		return filter?.outputImage
	}
	
	public func whitePointAdjust(color:UIColor) -> CIImage? {
		let filter = CIFilter(name: "CIWhitePointAdjust", withInputParameters: [
			"inputImage": self, "inputColor" : color.ciColor ])
		return filter?.outputImage
	}
	
	public func colorCrossPolynomial(red:ColorCoefficients = ColorCoefficients(r: 1, g: 0, b: 0, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0), green:ColorCoefficients = ColorCoefficients(r: 0, g: 1, b: 0, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0), blue:ColorCoefficients = ColorCoefficients(r: 0, g: 0, b: 1, rr: 0, gg: 0, bb: 0, rg: 0, gb: 0, br: 0, add: 0)) -> CIImage? {
		let filter = CIFilter(name: "CIColorCrossPolynomial", withInputParameters: [
			"inputImage": self, "inputRedCoefficients" : red.vector, "inputGreenCoefficients" : green.vector, "inputBlueCoefficients" : blue.vector ])
		return filter?.outputImage
	}
	
	//....
	public func colorCube(data:Data, dimension:CGFloat = 2.0) -> CIImage? {
		let filter = CIFilter(name: "CIColorCube", withInputParameters: [
			"inputImage": self, "inputCubeDimension" : dimension, "inputCubeData": data ])
		return filter?.outputImage
	}
	
	public func colorCubeWithColorSpace(data:Data, colorSpace:CGColorSpace, dimension:CGFloat = 2.0) -> CIImage? {
		let filter = CIFilter(name: "CIColorCubeWithColorSpace", withInputParameters: [
			"inputImage": self, "inputCubeDimension" : dimension, "inputCubeData": data, "inputColorSpace": colorSpace ])
		return filter?.outputImage
	}
	
	public func colorInvert() -> CIImage? {
		let filter = CIFilter(name: "CIColorInvert", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func colorMap(gradientImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIColorMap", withInputParameters: [
			"inputImage": self, "inputGradientImage": gradientImage ])
		return filter?.outputImage
	}
	
	public func colorMonochrome(color:UIColor, intensity:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CIColorMonochrome", withInputParameters: [
			"inputImage": self, "inputColor": color.ciColor, "inputIntensity": intensity ])
		return filter?.outputImage
	}
	
	public func colorPosterize(levels:CGFloat) -> CIImage? {
		let filter = CIFilter(name: "CIColorPosterize", withInputParameters: [
			"inputImage": self, "inputLevels": levels ])
		return filter?.outputImage
	}
	
	public func flaseColor(color0:UIColor, color1:UIColor) -> CIImage? {
		let filter = CIFilter(name: "CIFalseColor", withInputParameters: [
			"inputImage": self, "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
		return filter?.outputImage
	}
	
	public func maskToAlpha() -> CIImage? {
		let filter = CIFilter(name: "CIMaskToAlpha", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func maximumComponent() -> CIImage? {
		let filter = CIFilter(name: "CIMaximumComponent", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func minimumComponent() -> CIImage? {
		let filter = CIFilter(name: "CIMinimumComponent", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectChrome() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectChrome", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectFade() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectFade", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectInstant() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectInstant", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectMono() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectMono", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectNoir() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectNoir", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectProcess() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectProcess", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectTonal() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectTonal", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func photoEffectTransfer() -> CIImage? {
		let filter = CIFilter(name: "CIPhotoEffectTransfer", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func sepiaTone(intensity:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CISepiaTone", withInputParameters: [
			"inputImage": self, "inputIntensity": intensity ])
		return filter?.outputImage
	}
	
	public func vignette(radius:CGFloat = 1.0, intensity:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIVignette", withInputParameters: [
			"inputImage": self, "inputIntensity": intensity, "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public func vignetteEffect(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 0.0, intensity:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CIVignetteEffect", withInputParameters: [
			"inputImage": self, "inputIntensity": intensity, "inputRadius": radius, "inputCenter": CIVector(cgPoint: center) ])
		return filter?.outputImage
	}
	
	public func additionCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIAdditionCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func colorBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIColorBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func colorBurnBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIColorBurnBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func colorDodgeBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIColorDodgeBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func darkenBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIDarkenBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func differenceBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIDifferenceBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func divideBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIDivideBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func exclusionBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIExclusionBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func hardLightBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIHardLightBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func hueBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIHueBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func lightenBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CILightenBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func linearBurnBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CILinearBurnBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func linearDodgeBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CILinearDodgeBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func luminosityBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CILuminosityBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func maximumCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIMaximumCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func minimumCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIMinimumCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func multiplyBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIMultiplyBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func multiplyCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIMultiplyCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func overlayBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIOverlayBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func pinLightBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIPinLightBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func saturationBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISaturationBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func screenBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIScreenBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func softLightBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISoftLightBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func sourceAtopCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISourceAtopCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func sourceInCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISourceInCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func sourceOutCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISourceOutCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func sourceOverCompositing(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func subtractBlendMode(backgroudImage:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CISubtractBlendMode", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroudImage ])
		return filter?.outputImage
	}
	
	public func bumpDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, scale:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIBumpDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius, "inputScale": scale ])
		return filter?.outputImage
	}
	
	public func bumpDistortionLinear(center:CGPoint = CGPoint(x: 300, y: 300), radius:CGFloat = 300.0, angle:CGFloat = 0, scale:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIBumpDistortionLinear", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius, "inputScale": scale, "inputAngle" : angle ])
		return filter?.outputImage
	}
	
	public func circleSplashDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0) -> CIImage? {
		let filter = CIFilter(name: "CICircleSplashDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public func circularWrap(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0, angle:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CICircularWrap", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint: center), "inputRadius": radius, "inputAngle": angle ])
		return filter?.outputImage
	}
	
	public func droste(insetPoint0:CGPoint = CGPoint(x: 200, y: 200), insetPoint1:CGPoint = CGPoint(x: 400, y: 400), strand:CGFloat = 1.0, periodicity:CGFloat = 1.0, rotation:CGFloat = 0.0, zoom:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CIDroste", withInputParameters: [
			"inputImage": self, "inputInsetPoint0": CIVector(cgPoint: insetPoint0), "inputInsetPoint1": CIVector(cgPoint: insetPoint1), "inputStrands": strand, "inputPeriodicity": periodicity, "inputRotation": rotation, "inputZoom": zoom ])
		return filter?.outputImage
	}
	
	public func displacementDistortion(displacementImage:CIImage, scale:CGFloat = 50.0) -> CIImage? {
		let filter = CIFilter(name: "CIDisplacementDistortion", withInputParameters: [
			"inputImage": self, "inputDisplacementImage": displacementImage, "inputScale":scale ])
		return filter?.outputImage
	}
	
	public func glassDistortion(texture:CIImage, center:CGPoint = CGPoint(x: 150, y:150), scale:CGFloat = 200.0) -> CIImage? {
		let filter = CIFilter(name: "CIGlassDistortion", withInputParameters: [
			"inputImage": self, "inputTexture": texture, "inputCenter":CIVector(cgPoint: center), "inputScale": scale ])
		return filter?.outputImage
	}
	
	public func glassLozenge(point0:CGPoint = CGPoint(x: 150, y: 150), point1:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 100.0, refraction:CGFloat = 1.7) -> CIImage? {
		let filter = CIFilter(name: "CIGlassLozenge", withInputParameters: [
			"inputImage": self, "inputPoint0": CIVector(cgPoint:point0), "inputPoint1":CIVector(cgPoint: point1), "inputRadius": radius, "inputRefraction": refraction ])
		return filter?.outputImage
	}
	
	public func holeDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 150.0) -> CIImage? {
		let filter = CIFilter(name: "CIHoleDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public func lightTunnel(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 0, rotation:CGFloat = 0) -> CIImage? {
		let filter = CIFilter(name: "CILightTunnel", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputRotation": rotation ])
		return filter?.outputImage
	}
	
	public func pinchDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, scale:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIPinchDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputScale": scale ])
		return filter?.outputImage
	}
	
	public func stretchCrop(size:CGSize, cropAmount:Bool, centerStretchAmount:Bool) -> CIImage? {
		let filter = CIFilter(name: "CIStretchCrop", withInputParameters: [
			"inputImage": self, "inputSize": CIVector(x: size.width, y: size.height), "inputCropAmount": cropAmount ? 1 : 0, "inputCenterStretchAmount": centerStretchAmount ? 1 : 0 ])
		return filter?.outputImage
	}
	
	public func torusLensDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 160.0, width:CGFloat = 80.0, refraction:CGFloat = 1.7) -> CIImage? {
		let filter = CIFilter(name: "CITorusLensDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputRefraction": refraction, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func twirlDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, angle:CGFloat = 3.14) -> CIImage? {
		let filter = CIFilter(name: "CITwirlDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputAngle":angle ])
		return filter?.outputImage
	}
	
	public func vortexDistortion(center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 300.0, angle:CGFloat = 56.55) -> CIImage? {
		let filter = CIFilter(name: "CIVortexDistortion", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(cgPoint:center), "inputRadius": radius, "inputAngle":angle ])
		return filter?.outputImage
	}
	
	
	//MARK: generator
	public static func aztecCodeGenerator(data:Data, correctionLevel:CGFloat = 23.0, layers:CGFloat = 0, compactStyle:CGFloat = 0) -> CIImage? {
		let filter = CIFilter(name: "CIAztecCodeGenerator", withInputParameters: [
			"inputMessage": data, "inputCorrectionLevel": correctionLevel, "inputLayers": layers, "inputCompactStyle":compactStyle ])
		return filter?.outputImage
	}
	
	public static func checkerboardGenerato(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), width:CGFloat = 80.0, sharpness:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CICheckerboardGenerator", withInputParameters: [
			"inputCenter": CIVector(cgPoint: center), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor, "inputWidth":width, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	public static func code128BarcodeGenerator(asciiString:String, quietSpace:CGFloat = 7.0) -> CIImage? {
		guard let data = asciiString.data(using: .ascii) else { return nil }
		let filter = CIFilter(name: "CICode128BarcodeGenerator", withInputParameters: [
			"inputMessage": data, "inputQuietSpace": quietSpace ])
		return filter?.outputImage
	}
	
	public static func constantColorGenerator(color:UIColor) -> CIImage? {
		let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: [
			"inputColor": color.ciColor ])
		return filter?.outputImage
	}
	
	public static func lenticularHaloGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), haloRadius:CGFloat = 70.0, haloWidth:CGFloat = 87.0, haloOverlap:CGFloat = 0.77, striationStrenght:CGFloat = 0.5, striationConstrast:CGFloat = 1.0, time:CGFloat = 0) -> CIImage? {
		let filter = CIFilter(name: "CILenticularHaloGenerator", withInputParameters: [
			"inputColor": color.ciColor, "inputCenter":CIVector(cgPoint:center), "inputHaloRadius":haloRadius, "inputHaloWidth":haloWidth, "inputHaloOverlap":haloOverlap, "inputStriationStrength":striationStrenght, "inputStriationContrast":striationConstrast, "inputTime":time ])
		return filter?.outputImage
	}
	
	public enum PDF417CompactionMode:Int {
		case automatic = 0
		case numeric = 1
		case text = 2
		case byte = 3
	}
	
	public static func PDF417BarcodeGenerator(data:Data, minWidth:CGFloat = 0, maxWidth:CGFloat = 0, minHeight:CGFloat = 0, maxHeight:CGFloat = 0, dataColums:CGFloat = 0, rows:CGFloat = 0, preferredAspectRatio:CGFloat = 0, compactionMode:PDF417CompactionMode = .automatic, compactStyle:Bool = false, correctionLevel:CGFloat = 0, alwaysSpecifyCompaction:CGFloat = 0 ) -> CIImage? {
		let filter = CIFilter(name: "CIPDF417BarcodeGenerator", withInputParameters: [
			"inputMessage": data, "inputMinWidth": minWidth, "inputMaxWidth": maxWidth, "inputMinHeight":minHeight, "inputMaxHeight":maxHeight, "inputDataColumns":dataColums, "inputRows":rows, "inputPreferredAspectRatio":preferredAspectRatio , "inputCompactionMode":CGFloat(compactionMode.rawValue), "inputCompactStyle":compactStyle ? 1: 0, "inputCorrectionLevel": correctionLevel, "inputAlwaysSpecifyCompaction":alwaysSpecifyCompaction ])
		return filter?.outputImage
	}
	
	public enum QRCodeCorrectionLevel:String {
		case Low = "L"
		case Medium = "M"
		case Quility = "Q"
		case High = "H"
	}
	
	public static func QRCodeGenerator(data:Data, correctionLevel:QRCodeCorrectionLevel = .Medium) -> CIImage? {
		let filter = CIFilter(name: "CIQRCodeGenerator", withInputParameters: [
			"inputMessage": data, "inputCorrectionLevel": correctionLevel.rawValue ])
		return filter?.outputImage
	}
	
	public static func randomGenerator() -> CIImage? {
		let filter = CIFilter(name: "CIRandomGenerator")
		return filter?.outputImage
	}
	
	public static func starShineGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), radius:CGFloat = 50.0, crossScale:CGFloat = 15.0, crossAngle:CGFloat = 0.6, crossOpacity:CGFloat = -2.0, crossWidth:CGFloat = 2.5, epsilon:CGFloat = -2.0) -> CIImage? {
		let filter = CIFilter(name: "CIStarShineGenerator", withInputParameters: [
			"inputCenter": CIVector(cgPoint:center), "inputColor": color.ciColor, "inputRadius":radius, "inputCrossScale":crossScale, "inputCrossAngle":crossAngle, "inputCrossOpacity":crossOpacity, "inputCrossWidth":crossWidth, "inputEpsilon":epsilon ])
		return filter?.outputImage
	}
	
	public static func stripesGenerator(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), width:CGFloat = 80.0, sharpness:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CIStripesGenerator", withInputParameters: [
			"inputCenter": CIVector(cgPoint:center), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor, "inputWidth":width, "inputSharpness":sharpness ])
		return filter?.outputImage
	}
	
	public static func sunbeamsGenerator(color:UIColor, center:CGPoint = CGPoint(x: 150, y: 150), sunRadius:CGFloat = 40.0, maxStriationRadius:CGFloat = 2.58, striationStrength:CGFloat = 0.5, striationContrast:CGFloat = 1.38, time:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CISunbeamsGenerator", withInputParameters: [
			"inputCenter": CIVector(cgPoint:center), "inputColor": color.ciColor, "inputSunRadius":sunRadius, "inputMaxStriationRadius":maxStriationRadius, "inputStriationStrength":striationStrength, "inputStriationContrast":striationContrast, "inputTime":time ])
		return filter?.outputImage
	}
	
	//MARK: transform
	public func affineTransform(transform:CGAffineTransform) -> CIImage? {
		let filter = CIFilter(name: "CIAffineTransform", withInputParameters: [
			"inputImage": self, "inputTransform": NSValue(cgAffineTransform:transform) ])
		return filter?.outputImage
	}
	
	public func crop(rect:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CICrop", withInputParameters: [
			"inputImage": self, "inputRectangle": CIVector(cgRect:rect) ])
		return filter?.outputImage
	}
	
	public func lanczosScaleTransform(scale:CGFloat = 1.0, aspectRatio:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CILanczosScaleTransform", withInputParameters: [
			"inputImage": self, "inputScale": scale, "inputAspectRatio": aspectRatio ])
		return filter?.outputImage
	}
	
	public func perspectiveCorrection(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
		let filter = CIFilter(name: "CIPerspectiveCorrection", withInputParameters: [
			"inputImage": self, "inputTopLeft": CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight": CIVector(x:topRight.x, y:topRight.y), "inputBottomRight": CIVector(x:bottomRight.x, y:bottomRight.y), "inputBottomLeft": CIVector(x:bottomLeft.x, y:bottomLeft.y) ])
		return filter?.outputImage
	}
	
	public func perspectiveTransform(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
		let filter = CIFilter(name: "CIPerspectiveTransform", withInputParameters: [
			"inputImage": self, "inputTopLeft": CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight": CIVector(x:topRight.x, y:topRight.y), "inputBottomRight": CIVector(x:bottomRight.x, y:bottomRight.y), "inputBottomLeft": CIVector(x:bottomLeft.x, y:bottomLeft.y) ])
		return filter?.outputImage
	}
	
	public func perspectiveTransformWithExtent(extent:CGAffineTransform, topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
		let filter = CIFilter(name: "CIPerspectiveTransformWithExtent", withInputParameters: [
			"inputImage": self, "inputTopLeft": CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight": CIVector(x:topRight.x, y:topRight.y), "inputBottomRight": CIVector(x:bottomRight.x, y:bottomRight.y), "inputBottomLeft": CIVector(x:bottomLeft.x, y:bottomLeft.y), "inputExtent":NSValue(cgAffineTransform:extent) ])
		return filter?.outputImage
	}
	
	public func straightenFilter(angle:CGFloat) -> CIImage? {
		let filter = CIFilter(name: "CIStraightenFilter", withInputParameters: [
			"inputImage": self, "inputAngle": angle ])
		return filter?.outputImage
	}
	
	//MARK:Grandient
	public static func gaussianGradient(color0:UIColor, color1:UIColor, center:CGPoint = CGPoint(x:150, y:150), radius:CGFloat = 300.0) -> CIImage? {
		let filter = CIFilter(name: "CIGaussianGradient", withInputParameters: [
			"inputCenter": CIVector(x: center.x, y: center.y), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor, "inputRadius": radius ])
		return filter?.outputImage
	}
	
	public static func linearGradient(color0:UIColor, color1:UIColor, center:CGPoint, radius0:CGFloat, radius1:CGFloat) -> CIImage? {
		let filter = CIFilter(name: "CILinearGradient", withInputParameters: [
			"inputCenter": CIVector(x: center.x, y: center.y), "inputRadius0": radius0, "inputRadius1": radius1, "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
		return filter?.outputImage
	}
	
	public static func linearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint) -> CIImage? {
		let filter = CIFilter(name: "CILinearGradient", withInputParameters: [
			"inputPoint0": CIVector(x: point0.x, y: point0.y), "inputPoint1": CIVector(x: point1.x, y: point1.y), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
		return filter?.outputImage
	}
	
	public static func smoothLinearGradient(color0:UIColor, color1:UIColor, point0:CGPoint, point1:CGPoint) -> CIImage? {
		let filter = CIFilter(name: "CISmoothLinearGradient", withInputParameters: [
			"inputPoint0": CIVector(x: point0.x, y: point0.y), "inputPoint1": CIVector(x: point1.x, y: point1.y), "inputColor0": color0.ciColor, "inputColor1": color1.ciColor ])
		return filter?.outputImage
	}
	
	//MARK:Half tone
	public func circularScreen(center:CGPoint, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
		let filter = CIFilter(name: "CICircularScreen", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputWidth": width, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	public func CMYKHalftone(center:CGPoint, width:CGFloat = 6.0, angle:CGFloat = 0.0, sharpness:CGFloat = 0.7, GCR:CGFloat = 1.0, UCR:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CICMYKHalftone", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputWidth": width, "inputWidth": angle, "inputSharpness": sharpness, "inputGCR":GCR, "inputUCR":UCR ])
		return filter?.outputImage
	}
	
	public func dotScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
		let filter = CIFilter(name: "CIDotScreen", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputAngle": angle, "inputWidth": width, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	public func hatchedScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
		let filter = CIFilter(name: "CIHatchedScreen", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputAngle": angle, "inputWidth": width, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	public func lineScreen(center:CGPoint, angle:CGFloat = 0.0, width:CGFloat = 6.0, sharpness:CGFloat = 0.7) -> CIImage? {
		let filter = CIFilter(name: "CILineScreen", withInputParameters: [
			"inputImage": self, "inputCenter": CIVector(x:center.x, y:center.y), "inputAngle": angle, "inputWidth": width, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	
	public func areaAverage(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIAreaAverage", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func areaHistogram(extent:CGRect, count:CGFloat, scale:CGFloat) -> CIImage? {
		let filter = CIFilter(name: "CIAreaHistogram", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent), "inputCount":count, "inputScale":scale ])
		return filter?.outputImage
	}
	
	public func rowAverage(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIRowAverage", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func columnAverage(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIColumnAverage", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func histogramDisplayFilter(height:CGFloat = 100.0, highLimit:CGFloat = 1.0, lowLimit:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIHistogramDisplayFilter", withInputParameters: [
			"inputImage": self, "inputHeight": height, "inputHighLimit":highLimit, "inputLowLimit":lowLimit ])
		return filter?.outputImage
	}
	
	public func areaMaximum(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIAreaMaximum", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func areaMinimum(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIAreaMinimum", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func areaMaximumAlpha(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIAreaMaximumAlpha", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func areaMinimumAlpha(extent:CGRect) -> CIImage? {
		let filter = CIFilter(name: "CIAreaMinimumAlpha", withInputParameters: [
			"inputImage": self, "inputExtent": CIVector(cgRect: extent) ])
		return filter?.outputImage
	}
	
	public func sharpenLuminance(sharpness:CGFloat = 0.4) -> CIImage? {
		let filter = CIFilter(name: "CISharpenLuminance", withInputParameters: [
			"inputImage": self, "inputSharpness": sharpness ])
		return filter?.outputImage
	}
	
	public func unsharpMask(radius:CGFloat = 2.5, intensity:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIUnsharpMask", withInputParameters: [
			"inputImage": self, "inputRadius": radius, "inputIntensity": intensity ])
		return filter?.outputImage
	}
	
	public func blendWithAlphaMask(backgroud:CIImage, mask:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIBlendWithAlphaMask", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroud, "inputMaskImage": mask ])
		return filter?.outputImage
	}
	
	public func blendWithMask(backgroud:CIImage, mask:CIImage) -> CIImage? {
		let filter = CIFilter(name: "CIBlendWithMask", withInputParameters: [
			"inputImage": self, "inputBackgroundImage": backgroud, "inputMaskImage": mask ])
		return filter?.outputImage
	}
	
	public func bloom(radius:CGFloat = 10.0, intensity:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIBloom", withInputParameters: [
			"inputImage": self, "inputRadius": radius, "inputIntensity": intensity ])
		return filter?.outputImage
	}
	
	public func comicEffect() -> CIImage? {
		let filter = CIFilter(name: "CIComicEffect", withInputParameters: [
			"inputImage": self ])
		return filter?.outputImage
	}
	
	public func convolution3X3(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIConvolution3X3", withInputParameters: [
			"inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
		return filter?.outputImage
	}
	
	public func convolution5X5(matrix:Matrix5X5, bios:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIConvolution5X5", withInputParameters: [
			"inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
		return filter?.outputImage
	}
	
	public func convolution7X7(matrix:Matrix7X7, bios:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIConvolution7X7", withInputParameters: [
			"inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
		return filter?.outputImage
	}
	
	public func convolution9Horizontal(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIConvolution9Horizontal", withInputParameters: [
			"inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
		return filter?.outputImage
	}
	
	public func convolution9Vertical(matrix:Matrix3X3, bios:CGFloat = 0.0) -> CIImage? {
		let filter = CIFilter(name: "CIConvolution9Vertical", withInputParameters: [
			"inputImage": self, "inputWeights":matrix.vector, "inputBias":bios ])
		return filter?.outputImage
	}
	
	public func crystallize(center:CGPoint = CGPoint(x:150.0, y:150.0), radius:CGFloat = 20.0) -> CIImage? {
		let filter = CIFilter(name: "CICrystallize", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputRadius":radius ])
		return filter?.outputImage
	}
	
	public func depthOfField(point0:CGPoint, point1:CGPoint, saturation:CGFloat, unsharpMaskRadius:CGFloat, unsharpMaskIntensity:CGFloat, radius:CGFloat) -> CIImage? {
		let filter = CIFilter(name: "CIDepthOfField", withInputParameters: [
			"inputImage": self, "inputPoint0":CIVector(x:point0.x, y:point0.y), "inputPoint1":CIVector(x:point1.x, y:point1.y), "inputRadius":radius, "inputSaturation":saturation, "inputUnsharpMaskRadius":unsharpMaskRadius, "inputUnsharpMaskIntensity":unsharpMaskIntensity ])
		return filter?.outputImage
	}
	
	public func edges(intensity:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CIEdges", withInputParameters: [
			"inputImage": self, "inputIntensity":intensity ])
		return filter?.outputImage
	}
	
	public func edgeWork(intensity:CGFloat = 3.0) -> CIImage? {
		let filter = CIFilter(name: "CIEdgeWork", withInputParameters: [
			"inputImage": self, "inputIntensity":intensity ])
		return filter?.outputImage
	}
	
	public func gloom(radius:CGFloat = 10.0, intensity:CGFloat = 0.5) -> CIImage? {
		let filter = CIFilter(name: "CIGloom", withInputParameters: [
			"inputImage": self, "inputRadius":radius, "inputIntensity":intensity ])
		return filter?.outputImage
	}
	
	public func heightFieldFromMask(radius:CGFloat = 10.0) -> CIImage? {
		let filter = CIFilter(name: "CIHeightFieldFromMask", withInputParameters: [
			"inputImage": self, "inputRadius":radius ])
		return filter?.outputImage
	}
	
	public func hexagonalPixellate(center:CGPoint = CGPoint(x:150, y:150), scale:CGFloat = 8.0) -> CIImage? {
		let filter = CIFilter(name: "CIHexagonalPixellate", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputScale":scale ])
		return filter?.outputImage
	}
	
	public func highlightShadowAdjust(shadowAmount:CGFloat, highlightAmount:CGFloat = 1.0) -> CIImage? {
		let filter = CIFilter(name: "CIHighlightShadowAdjust", withInputParameters: [
			"inputImage": self, "inputHighlightAmount":highlightAmount, "inputShadowAmount":shadowAmount ])
		return filter?.outputImage
	}
	
	public func lineOverlay(NRNoiseLeve:CGFloat = 0.07, NRSharpness:CGFloat = 0.71, edgeIntensity:CGFloat = 1.0, threshold:CGFloat = 0.1, contrast:CGFloat = 50.0) -> CIImage? {
		let filter = CIFilter(name: "CILineOverlay", withInputParameters: [
			"inputImage": self, "inputNRNoiseLevel":NRNoiseLeve, "inputNRSharpness":NRSharpness, "inputEdgeIntensity":edgeIntensity, "inputThreshold":threshold, "inputContrast":contrast ])
		return filter?.outputImage
	}
	
	public func pixellate(center:CGPoint = CGPoint(x:150, y:150), scale:CGFloat = 8.0) -> CIImage? {
		let filter = CIFilter(name: "CIPixellate", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputScale":scale ])
		return filter?.outputImage
	}
	
	public func pointillize(center:CGPoint = CGPoint(x:150, y:150), radius:CGFloat = 20.0) -> CIImage? {
		let filter = CIFilter(name: "CIPointillize", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputRadius":radius ])
		return filter?.outputImage
	}
	
	public func shadedMaterial(shadingImage:CIImage, scale:CGFloat = 10.0) -> CIImage? {
		let filter = CIFilter(name: "CIShadedMaterial", withInputParameters: [
			"inputImage": self, "inputShadingImage":shadingImage, "inputScale":scale ])
		return filter?.outputImage
	}
	
	public func spotColor(spot0:SpotColor, spot1:SpotColor, spot2:SpotColor) -> CIImage? {
		let filter = CIFilter(name: "CISpotColor", withInputParameters: [
			"inputImage": self, "inputCenterColor1":spot0.centerColor.ciColor, "inputReplacementColor1":spot0.centerColor.ciColor,
			"inputCloseness1":spot0.closeness, "inputContrast1":spot0.contrast,
			"inputCenterColor2":spot1.centerColor.ciColor, "inputReplacementColor2":spot1.centerColor.ciColor,
			"inputCloseness2":spot1.closeness, "inputContrast2":spot1.contrast,
			"inputCenterColor3":spot2.centerColor.ciColor, "inputReplacementColor3":spot2.centerColor.ciColor,
			"inputCloseness3":spot2.closeness, "inputContrast3":spot2.contrast])
		return filter?.outputImage
	}
	
	public func spotLight(color:UIColor, lightPosition:Dim3, lightPointsAt:Dim3, brightness:CGFloat = 3.0, concentration:CGFloat = 0.1) -> CIImage? {
		let filter = CIFilter(name: "CISpotLight", withInputParameters: [
			"inputImage": self, "inputLightPosition":lightPosition.vector, "inputLightPointsAt":lightPointsAt.vector, "inputBrightness":brightness, "inputConcentration": concentration, "inputColor":color.ciColor ])
		return filter?.outputImage
	}
	
	public func affineClamp(transform:CGAffineTransform) -> CIImage? {
		let filter = CIFilter(name: "CIAffineClamp", withInputParameters: [
			"inputImage": self, "inputTransform":NSValue(cgAffineTransform:transform) ])
		return filter?.outputImage
	}
	
	public func affineTile(transform:CGAffineTransform) -> CIImage? {
		let filter = CIFilter(name: "CIAffineTile", withInputParameters: [
			"inputImage": self, "inputTransform":NSValue(cgAffineTransform:transform) ])
		return filter?.outputImage
	}
	
	public func eightfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIEightfoldReflectedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func fourfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIFourfoldReflectedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputAcuteAngle":acuteAngle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func fourfoldRotatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIFourfoldRotatedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func fourfoldTranslatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIFourfoldTranslatedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputAcuteAngle":acuteAngle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func glideReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIGlideReflectedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func kaleidoscope(center:CGPoint = CGPoint(x:150, y:150), count:CGFloat = 6, angle:CGFloat = 0) -> CIImage? {
		let filter = CIFilter(name: "CIKaleidoscope", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputCount":count ])
		return filter?.outputImage
	}
	
	public func opTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, scale:CGFloat = 2.8, width:CGFloat = 65.0) -> CIImage? {
		let filter = CIFilter(name: "CIOpTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputScale":scale, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func parallelogramTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, acuteAngle:CGFloat = 1.57, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIParallelogramTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputAcuteAngle":acuteAngle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func perspectiveTile(topLeft:CGPoint, topRight:CGPoint, bottomLeft:CGPoint, bottomRight:CGPoint) -> CIImage? {
		let filter = CIFilter(name: "CIPerspectiveTile", withInputParameters: [
			"inputImage": self, "inputTopLeft":CIVector(x:topLeft.x, y:topLeft.y), "inputTopRight":CIVector(x:topRight.x, y:topRight.y), "inputBottomLeft":CIVector(x:bottomLeft.x, y:bottomLeft.y), "inputBottomRight":CIVector(x:bottomRight.x, y:bottomRight.y) ])
		return filter?.outputImage
	}
	
	public func sixfoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CISixfoldReflectedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func sixfoldRotatedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CISixfoldRotatedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func triangleKaleidoscope(point:CGPoint = CGPoint(x:150, y:150), size:CGFloat = 700, rotation:CGFloat = -0.36, decay:CGFloat = 0.85) -> CIImage? {
		let filter = CIFilter(name: "CITriangleKaleidoscope", withInputParameters: [
			"inputImage": self, "inputPoint":CIVector(x:point.x, y:point.y), "inputSize":size, "inputRotation":rotation, "inputDecay":decay ])
		return filter?.outputImage
	}
	
	public func triangleTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CITriangleTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func twelvefoldReflectedTile(center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 0, width:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CITwelvefoldReflectedTile", withInputParameters: [
			"inputImage": self, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputWidth":width ])
		return filter?.outputImage
	}
	
	public func accordionFoldTransition(target:CIImage, time:CGFloat = 0, bottomHeight:CGFloat = 0, numberOfFolds:CGFloat = 3.0, foldShadowAmount:CGFloat = 0.1) -> CIImage? {
		let filter = CIFilter(name: "CIAccordionFoldTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputBottomHeight":bottomHeight, "inputNumberOfFolds":numberOfFolds, "inputFoldShadowAmount":foldShadowAmount, "inputTime":time ])
		return filter?.outputImage
	}
	
	public func barsSwipeTransition(target:CIImage, time:CGFloat = 0, angle:CGFloat = 3.14, width:CGFloat = 30.0, barOffset:CGFloat = 10.0) -> CIImage? {
		let filter = CIFilter(name: "CIBarsSwipeTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputAngle":angle, "inputWidth":width, "inputBarOffset":barOffset, "inputTime":time ])
		return filter?.outputImage
	}
	
	public func copyMachineTransition(target:CIImage, time:CGFloat = 0, color:UIColor = UIColor.gray, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0.0, width:CGFloat = 30.0, opacity:CGFloat = 1.3) -> CIImage? {
		let filter = CIFilter(name: "CICopyMachineTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputExtent":CIVector(cgRect:extent), "inputColor":color.ciColor, "inputAngle":angle, "inputWidth":width, "inputOpacity":opacity, "inputTime":time ])
		return filter?.outputImage
	}
	
	public func disintegrateWithMaskTransition(target:CIImage, mask:CIImage, time:CGFloat = 0, shadowRadius:CGFloat = 8.0, shadowDesity:CGFloat = 0.65, shadowOffset:CGSize = CGSize(width:0, height:-10)) -> CIImage? {
		let filter = CIFilter(name: "CIDisintegrateWithMaskTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputMaskImage":mask, "inputShadowRadius":shadowRadius, "inputShadowDensity":shadowDesity, "inputShadowOffset":CIVector(x:shadowOffset.width, y:shadowOffset.height) , "inputTime":time ])
		return filter?.outputImage
	}
	
	public func dissolveTransition(target:CIImage, time:CGFloat = 0) -> CIImage? {
		let filter = CIFilter(name: "CIDissolveTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputTime":time ])
		return filter?.outputImage
	}
	
	public func flashTransition(target:CIImage, time:CGFloat = 0, color:UIColor, center:CGPoint = CGPoint(x:150, y:150), extent:CGRect = CGRect(x:0, y:0, width:300, height:300), maxStriationRadius:CGFloat = 2.58, striationStrength:CGFloat = 0.5, striationContrast:CGFloat = 1.38, fadeThreshold:CGFloat = 0.85) -> CIImage? {
		let filter = CIFilter(name: "CIFlashTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputTime":time, "inputCenter":CIVector(x:center.x, y:center.y), "inputExtent":CIVector(cgRect:extent), "inputColor":color.ciColor, "inputMaxStriationRadius":maxStriationRadius, "inputStriationStrength":striationStrength, "inputStriationContrast":striationContrast, "inputFadeThreshold":fadeThreshold ])
		return filter?.outputImage
	}
	
	public func modTransition(target:CIImage, time:CGFloat = 0, center:CGPoint = CGPoint(x:150, y:150), angle:CGFloat = 2.0, radius:CGFloat = 150.0, compression:CGFloat = 300.0) -> CIImage? {
		let filter = CIFilter(name: "CIModTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputTime":time, "inputCenter":CIVector(x:center.x, y:center.y), "inputAngle":angle, "inputRadius":radius, "inputCompression":compression ])
		return filter?.outputImage
	}
	
	public func pageCurlTransition(target:CIImage, backside:CIImage, shading:CIImage, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0, radius:CGFloat = 100.0) -> CIImage? {
		let filter = CIFilter(name: "CIPageCurlTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputTime":time, "inputBacksideImage":backside, "inputShadingImage":shading, "inputExtent":CIVector(cgRect:extent), "inputAngle":angle, "inputRadius":radius ])
		return filter?.outputImage
	}
	
	public func pageCurlWithShadowTransition(target:CIImage, backside:CIImage, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:0, height:0), angle:CGFloat = 0.0, radius:CGFloat = 100.0, shadowSize:CGFloat = 0.5, shadowAmount:CGFloat = 0.7, shadowExtent:CGRect = CGRect(x:0, y:0, width:0, height:0)) -> CIImage? {
		let filter = CIFilter(name: "CIPageCurlWithShadowTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputBacksideImage":backside, "inputTime":time, "inputExtent":CIVector(cgRect:extent), "inputAngle":angle, "inputRadius":radius, "inputShadowSize":shadowSize, "inputShadowAmount":shadowAmount, "inputShadowExtent":CIVector(cgRect:shadowExtent) ])
		return filter?.outputImage
	}
	
	public func rippleTransition(target:CIImage, shading:CIImage, time:CGFloat = 0, center:CGPoint = CGPoint(x:150, y:150), extent:CGRect = CGRect(x:0, y:0, width:300, height:300), width:CGFloat = 100.0, scale:CGFloat = 50.0) -> CIImage? {
		let filter = CIFilter(name: "CIRippleTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputTime":time, "inputShadingImage":shading, "inputCenter":CIVector(x:center.x, y:center.y), "inputExtent":CIVector(cgRect:extent), "inputWidth":width, "inputScale":scale ])
		return filter?.outputImage
	}
	
	public func swipeTransition(target:CIImage, color:UIColor, time:CGFloat = 0, extent:CGRect = CGRect(x:0, y:0, width:300, height:300), angle:CGFloat = 0.0, width:CGFloat = 300.0, opacity:CGFloat = 0) -> CIImage? {
		let filter = CIFilter(name: "CISwipeTransition", withInputParameters: [
			"inputImage": self, "inputTargetImage":target, "inputTime":time, "inputExtent":CIVector(cgRect:extent), "inputColor":color.ciColor, "inputAngle":angle, "inputWidth":width, "inputOpacity":opacity ])
		return filter?.outputImage
	}
}

public struct SpotColor {
	var centerColor:UIColor
	var replacementColor:UIColor
	var closeness:CGFloat = 0.22
	var contrast:CGFloat = 0.98
}

public struct ColorCoefficients {
	var c:[CGFloat]
	
	init(r:CGFloat, g:CGFloat, b:CGFloat, rr:CGFloat, gg:CGFloat, bb:CGFloat, rg:CGFloat, gb:CGFloat, br:CGFloat, add:CGFloat) {
		c = [r, g, b, rr, gg, bb, rg, gb, br, add]
	}
	
	var vector:CIVector {
		return CIVector(values: c, count: 10)
	}
}

public struct Matrix3X3 {
	var c:[CGFloat]
	
	init(n00:CGFloat, n01:CGFloat, n02:CGFloat, n10:CGFloat, n11:CGFloat, n12:CGFloat, n20:CGFloat, n21:CGFloat, n22:CGFloat) {
		c = [n00, n01, n02, n10, n11, n12, n20, n21, n22]
	}
	
	var vector:CIVector {
		return CIVector(values: c, count: 9)
	}
}

public struct Matrix5X5 {
	var c:[CGFloat]
	
	init(n00:CGFloat, n01:CGFloat, n02:CGFloat, n03:CGFloat, n04:CGFloat,
	     n10:CGFloat, n11:CGFloat, n12:CGFloat, n13:CGFloat, n14:CGFloat,
	     n20:CGFloat, n21:CGFloat, n22:CGFloat, n23:CGFloat, n24:CGFloat,
	     n30:CGFloat, n31:CGFloat, n32:CGFloat, n33:CGFloat, n34:CGFloat,
	     n40:CGFloat, n41:CGFloat, n42:CGFloat, n43:CGFloat, n44:CGFloat) {
		c = [n00, n01, n02, n03, n04, n10, n11, n12, n13, n14, n20, n21, n22, n23, n24,
			n30, n31, n32, n33, n34, n40, n41, n42, n43, n44]
	}
	
	var vector:CIVector {
		return CIVector(values: c, count: 25)
	}
}

public struct Matrix7X7 {
	var c:[CGFloat]
	
	init(n00:CGFloat, n01:CGFloat, n02:CGFloat, n03:CGFloat, n04:CGFloat, n05:CGFloat, n06:CGFloat,
	     n10:CGFloat, n11:CGFloat, n12:CGFloat, n13:CGFloat, n14:CGFloat, n15:CGFloat, n16:CGFloat,
	     n20:CGFloat, n21:CGFloat, n22:CGFloat, n23:CGFloat, n24:CGFloat, n25:CGFloat, n26:CGFloat,
	     n30:CGFloat, n31:CGFloat, n32:CGFloat, n33:CGFloat, n34:CGFloat, n35:CGFloat, n36:CGFloat,
	     n40:CGFloat, n41:CGFloat, n42:CGFloat, n43:CGFloat, n44:CGFloat, n45:CGFloat, n46:CGFloat,
	     n50:CGFloat, n51:CGFloat, n52:CGFloat, n53:CGFloat, n54:CGFloat, n55:CGFloat, n56:CGFloat,
	     n60:CGFloat, n61:CGFloat, n62:CGFloat, n63:CGFloat, n64:CGFloat, n65:CGFloat, n66:CGFloat) {
		c = [n00, n01, n02, n03, n04, n05, n06,
			n10, n11, n12, n13, n14, n15, n16,
			n20, n21, n22, n23, n24, n25, n26,
			n30, n31, n32, n33, n34, n35, n36,
			n40, n41, n42, n43, n44, n45, n46,
			n50, n51, n52, n53, n54, n55, n56,
			n60, n61, n62, n63, n64, n65, n66]
	}
	
	var vector:CIVector {
		return CIVector(values: c, count: 49)
	}
}

public struct Dim3 {
	var dx:CGFloat, dy:CGFloat, dz:CGFloat
	
	init(x:CGFloat, y:CGFloat, z:CGFloat) {
		dx = x
		dy = y
		dz = z
	}
	
	var vector:CIVector {
		return CIVector(x: dx, y: dy, z: dz)
	}
}

extension CIVector {
	convenience init(componets:CIImage.ColorComponents) {
		self.init(x: componets.red, y: componets.green, z: componets.blue, w: componets.alpha)
	}
}
