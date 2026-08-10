//
//  ColorComponents.swift
//  ColorComponents
//
//  Created by Vaida on 2026-08-10.
//


/// A 4-component color.
///
/// This structure does not store color space, but it is expected to work with `sRGB`.
public struct ColorComponents: Hashable, Sendable, Codable, BitwiseCopyable {
    
    @usableFromInline
    internal var components: SIMD4<Double>
    
    /// Creates a color component with a `SIMD4`.
    @inlinable
    public init(_ components: SIMD4<Double>) {
        self.components = components
    }
    
    /// Subscript with the color index.
    /// | index | component |
    /// | ----- | --------- |
    /// |   0   | red       |
    /// |   1   | green     |
    /// |   2   | blue      |
    /// |   3   | alpha     |
    @inlinable
    public subscript(_ index: Int) -> Double {
        get { self.components[index] }
        set { self.components[index] = newValue }
    }
}


extension ColorComponents {
    
    /// The red component.
    @inlinable
    public var red: Double {
        get { self.components[0] }
        set { self.components[0] = newValue }
    }
    
    /// The green component.
    @inlinable
    public var green: Double {
        get { self.components[1] }
        set { self.components[1] = newValue }
    }
    
    /// The blue component.
    @inlinable
    public var blue: Double {
        get { self.components[2] }
        set { self.components[2] = newValue }
    }
    
    /// The alpha component.
    @inlinable
    public var alpha: Double {
        get { self.components[3] }
        set { self.components[3] = newValue }
    }
    
}
