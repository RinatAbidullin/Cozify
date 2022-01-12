![cozify_logo](README.assets/cozify_logo.png)

Cozify is a collection of extensions that simplify working with swift code.

## UIColor

### Convenience init

```swift
// Create color from int representation of rgb
let color: UIColor = UIColor(hex: 0xffffff, alpha: 0.5)

// Create color from string representation of rgb
let color: UIColor? = UIColor(hex: "#ffffff", alpha: 0.5)
```

## Numeric

### Compare

```swift
// Approximate equality for floating-point
let float1 = ...
let float2 = ...
float1.isNearlyEqual(to: float2)
```

## Locale

```swift
// Preferred language code ("ru", "en" ...)
let preferredLanguageCode = Locale.preferredLanguageCode
```

## Environment

```swift
// Determine if the application is installed from the App Store
if Environment.isProduction {
    // do something
}

// or look at the applied configurations
Environment.appliedConfigurations.forEach { configuration in
    switch configuration {
    case .debug: // do something
    case .unitOrUiTest: // do something
    case .simulator: // do something
    case .testflight: // do something
    case .production: // do something
    }
}
```
