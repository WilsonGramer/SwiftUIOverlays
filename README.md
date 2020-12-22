# SwiftUIOverlays

In SwiftUI, presenting overlay views using `.overlay` (or `.sheet`, etc.) requires holding a `State` value in all of your views to track the overlay's visibility. Sometimes, though, you need to show an overlay from an arbitrary place in your app without having access to a view, like with error reporting or status notifications. SwiftUIOverlays allows you to present an overlay from anywhere like so:

```swift
showOverlay {
    MyOverlay()
}

struct MyOverlay: View {
    @Environment(\.dismissOverlay) var dismissOverlay

    var body: some View {
        Button(action: self.dismissOverlay) {
            Text("Dismiss overlay")
        }
    }
}
```

Animations work out of the box, and it also works with UIKit view controllers if needed.

## Limitations

SwiftUIOverlays creates a new `UIWindow` containing your view and presents it at the top level. This means that, currently, apps using scenes are not supported — if you're using a SwiftUI `App` value to manage your app's lifecycle, you need to switch to an `AppDelegate`, and multiple window scenes are not supported. This limitation will be lifted in the future if possible.
