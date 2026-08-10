//
//  Color + Integration.swift
//  ColorComponents
//
//  Created by Vaida on 2026-08-10.
//

import SwiftUI


extension Color {
    
    /// Creates a color using color components.
    @inlinable
    public init(components: ColorComponents) {
        self.init(.sRGB, red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
    
}


extension ColorComponents {
    
#if canImport(UIKit)
    /// Creates a UIKit color using these sRGB components.
    @inlinable
    public var uiColor: UIColor {
        // on iOS 10 and later, this initializer is for sRGB
        UIColor(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
    }
#endif
    
#if canImport(Cocoa)
    /// Creates an AppKit color using these sRGB components.
    @inlinable
    public var nsColor: NSColor {
        NSColor(srgbRed: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
    }
#endif
    
#if canImport(CoreGraphics)
    /// Creates a Core Graphics color using these sRGB components.
    @inlinable
    public var cgColor: CGColor {
        CGColor(srgbRed: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
    }
#endif
    
}


#if canImport(UIKit)
extension UIColor {
    
    public var components: ColorComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return ColorComponents(SIMD4(r, g, b, a))
        } else {
            let color = self.cgColor.converted(to: CGColorSpace(name: CGColorSpace.sRGB)!, intent: .defaultIntent, options: nil)!
            let components = color.components!
            return ColorComponents(SIMD4(components[0], components[1], components[2], components[3]))
        }
    }
    
}
#endif

#if canImport(AppKit)
extension NSColor {
    
    public var components: ColorComponents {
        let color = self.usingColorSpace(.sRGB)!
        var components = SIMD4<Double>.zero
        withUnsafeMutableBytes(of: &components) { pointer in
            pointer.withMemoryRebound(to: CGFloat.self) { buffer in
                color.getComponents(buffer.baseAddress!)
            }
        }
        return ColorComponents(components)
    }
}
#endif

extension Color {
    
    /// The components of the color.
    ///
    /// Layout in `[red, green, blue, alpha]`.
    @inlinable
    public var components: ColorComponents {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        NSColor(self).components
#elseif canImport(UIKit)
        UIColor(self).components
#endif
    }
    
}
