import Foundation
import Testing
@testable import ColorComponents

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

@Test func initializesWithDoubleComponents() {
    let components = ColorComponents(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
    
    #expect(components.red == 0.1)
    #expect(components.green == 0.2)
    #expect(components.blue == 0.3)
    #expect(components.alpha == 0.4)
}

@Test func initializesWithUInt8Components() {
    let components = ColorComponents(.uint8, red: 255, green: 128, blue: 0, alpha: 64)
    
    #expect(components.red == 1)
    #expect(components.green == Double(128) / 255)
    #expect(components.blue == 0)
    #expect(components.alpha == Double(64) / 255)
}

@Test func initializesWithRGBAndRGBAIntegers() {
    let rgb = ColorComponents(rgb: 0x336699, alpha: 0x80)
    let rgba = ColorComponents(rgba: 0x33669980)
    
    #expect(rgb == rgba)
    #expect(rgb.hexString(includeAlpha: true) == "#33669980")
}

@Test func initializesWithHexStrings() throws {
    let shorthand = try #require(ColorComponents(hex: "#369C"))
    let rgb = try #require(ColorComponents(hex: "336699"))
    let rgba = try #require(ColorComponents(hex: "336699CC"))
    
    #expect(shorthand.hexString(includeAlpha: true) == "#336699CC")
    #expect(rgb.hexString() == "#336699")
    #expect(rgb.hexString(includeAlpha: true) == "#336699FF")
    #expect(rgba.hexString(includeAlpha: true) == "#336699CC")
    #expect(ColorComponents(hex: "not-a-color") == nil)
}

@Test func exposesStaticColors() {
    #expect(ColorComponents.black == ColorComponents(red: 0, green: 0, blue: 0, alpha: 1))
    #expect(ColorComponents.white == ColorComponents(red: 1, green: 1, blue: 1, alpha: 1))
    #expect(ColorComponents.clear == ColorComponents(red: 0, green: 0, blue: 0, alpha: 0))
}

@Test func mutableCollectionUpdatesComponents() {
    var components = ColorComponents.black
    components[0] = 0.25
    components.green = 0.5
    components.blue = 0.75
    components.alpha = 0.9
    
    #expect(Array(components) == [0.25, 0.5, 0.75, 0.9])
}

@Test func opacityMultipliesAlpha() {
    let components = ColorComponents(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
    
    #expect(components.opacity(0.5) == ColorComponents(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.4))
}

@Test func mixInterpolatesComponents() {
    let first = ColorComponents(red: 0, green: 0.25, blue: 0.5, alpha: 0.75)
    let second = ColorComponents(red: 1, green: 0.75, blue: 0.25, alpha: 0.25)
    
    #expect(first.mix(with: second, by: 0.25) == ColorComponents(red: 0.25, green: 0.375, blue: 0.4375, alpha: 0.625))
}

@Test func codableRoundTripsComponents() throws {
    let components = ColorComponents(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
    let data = try JSONEncoder().encode(components)
    let decoded = try JSONDecoder().decode(ColorComponents.self, from: data)
    
    #expect(decoded == components)
}

#if canImport(CoreGraphics)
@Test func createsCoreGraphicsColor() {
    let components = ColorComponents(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
    let color = components.cgColor
    
    #expect(color.alpha == 0.8)
}
#endif

#if canImport(UIKit)
@Test func createsUIKitColor() {
    let components = ColorComponents(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
    let color = components.uiColor
    
    #expect(color.cgColor.alpha == 0.8)
}
#endif

#if canImport(Cocoa)
@Test func createsAppKitColor() {
    let components = ColorComponents(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
    let color = components.nsColor
    
    #expect(color.alphaComponent == 0.8)
}
#endif
