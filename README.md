![cozify_logo](README.assets/cozify_logo.png)

Cozify is a collection of extensions that simplify working with swift code.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) automates the distribution of Swift code. To use Cozify with SPM, add a dependency to `https://github.com/RinatAbidullin/Cozify`

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

## URL

```swift
// URLResponse status code
if let statusCode = response.statusCode {
    // do something
}
```

## View

```swift
// The point converted to the window base coordinate system
let point = someView.originPositionRelativeToWindowBaseCoordinates

// The frame converted to the window base coordinate system
let frame = someView.framePositionRelativeToWindowBaseCoordinates
```

## Control Function Executed

```swift
// Throttler:

let workForSelectedItemFromSettingsTable: Throttler = Throttler()

func tableView(
    _ tableView: UITableView, 
    willSelectRowAt indexPath: IndexPath
) -> IndexPath? {
    workForSelectedItemFromSettingsTable.throttle(
        delay: .milliseconds(120)
    ) { [weak self] in
        guard let self = self else { return }
        // do something
    }()
    return nil
}

// Debouncer:

let workForSelectedItemFromSettingsTable: Debouncer = Debouncer()

func tableView(
    _ tableView: UITableView, 
    willSelectRowAt indexPath: IndexPath
) -> IndexPath? {
    workForSelectedItemFromSettingsTable.debounce(
        delay: .milliseconds(120)
    ) { [weak self] in
        guard let self = self else { return }
        // do something
    }()
    return nil
}

// FirstlyThrottler:

// Works like Throttler but not emit last event
// that falls into the delay interval.
// A good example of usage is to avoid multiple click on button
// which starts some user-facing feature like opening new screen
// (which can be delayed because of animation, for example).

let workForSelectedItemFromSettingsTable: FirstlyThrottler = FirstlyThrottler()

func tableView(
    _ tableView: UITableView, 
    willSelectRowAt indexPath: IndexPath
) -> IndexPath? {
    workForSelectedItemFromSettingsTable.throttleFirst(
        delay: .milliseconds(120)
    ) { [weak self] in
        guard let self = self else { return }
        // do something
    }()
    return nil
}
```

## String

```swift
let destinationDirectory = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
)
.first!

// New file path made by appending to the receiver a given string
let destinationPath = destinationDirectory.appending(filePathComponent: "db.sqlite3")
```
