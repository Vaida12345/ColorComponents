//
//  Color + Creation.swift
//  ColorComponents
//
//  Created by Vaida on 2026-08-10.
//

extension ColorComponents {
    
    /// Opaque black in sRGB.
    public static let black = ColorComponents(red: 0, green: 0, blue: 0, alpha: 1)
    
    /// Opaque white in sRGB.
    public static let white = ColorComponents(red: 1, green: 1, blue: 1, alpha: 1)
    
    /// Fully transparent black in sRGB.
    public static let clear = ColorComponents(red: 0, green: 0, blue: 0, alpha: 0)
    
}

extension ColorComponents {
    
    /// Creates a color component with a set of `UInt8`.
    @inlinable
    public init(_ number: UInt8Number, red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        self.init(SIMD4(Double(red) / 255, Double(green) / 255, Double(blue) / 255, Double(alpha) / 255))
    }
    
    /// Creates a color component with a set of `Double`.
    @inlinable
    public init(_ number: FloatNumber = .float, red: Double, green: Double, blue: Double, alpha: Double) {
        self.init(SIMD4(red, green, blue, alpha))
    }
    
    /// Creates a color component from a `0xRRGGBB` integer and optional alpha byte.
    @inlinable
    public init(rgb: UInt32, alpha: UInt8 = 255) {
        self.init(
            .uint8,
            red: UInt8((rgb >> 16) & 0xff),
            green: UInt8((rgb >> 8) & 0xff),
            blue: UInt8(rgb & 0xff),
            alpha: alpha
        )
    }
    
    /// Creates a color component from a `0xRRGGBBAA` integer.
    @inlinable
    public init(rgba: UInt32) {
        self.init(
            .uint8,
            red: UInt8((rgba >> 24) & 0xff),
            green: UInt8((rgba >> 16) & 0xff),
            blue: UInt8((rgba >> 8) & 0xff),
            alpha: UInt8(rgba & 0xff)
        )
    }
    
    /// Creates a color component from a hex string in `RGB`, `RGBA`, `RRGGBB`, or `RRGGBBAA` form.
    public init?(hex: String) {
        var text = hex
        if text.hasPrefix("#") {
            text.removeFirst()
        }
        
        guard [3, 4, 6, 8].contains(text.count) else { return nil }
        
        if text.count == 3 || text.count == 4 {
            text = text.map { String(repeating: String($0), count: 2) }.joined()
        }
        
        guard let value = UInt32(text, radix: 16) else { return nil }
        
        if text.count == 6 {
            self.init(rgb: value)
        } else {
            self.init(rgba: value)
        }
    }
    
    /// Returns a hex string in `#RRGGBB` or `#RRGGBBAA` form.
    public func hexString(includeAlpha: Bool = false) -> String {
        let red = Self.byteString(for: self.red)
        let green = Self.byteString(for: self.green)
        let blue = Self.byteString(for: self.blue)
        let alpha = Self.byteString(for: self.alpha)
        
        if includeAlpha {
            return "#\(red)\(green)\(blue)\(alpha)"
        } else {
            return "#\(red)\(green)\(blue)"
        }
    }
    
    /// Converts a normalized component into a two-character uppercase hex byte.
    private static func byteString(for component: Double) -> String {
        let byte = Swift.min(Swift.max(Int((component * 255).rounded()), 0), 255)
        let string = String(byte, radix: 16, uppercase: true)
        
        if string.count == 1 {
            return "0\(string)"
        } else {
            return string
        }
    }
    
    /// A marker used to select the `UInt8` component initializer.
    public enum UInt8Number {
        case uint8
    }
    
    /// A marker used to select the floating-point component initializer.
    public enum FloatNumber {
        case float
    }
    
}
