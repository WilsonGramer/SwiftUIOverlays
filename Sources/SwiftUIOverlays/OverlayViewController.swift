import UIKit

/// Contains the state for the presented overlay.
public struct OverlayState {
    internal unowned var viewController: OverlayViewController
    internal let dismiss: () -> Void
}

/// Adopt this protocol to dismiss your overlay with the `dismissOverlay()` method.
public protocol OverlayViewController: UIViewController {
    var overlayState: OverlayState! { get set }
}

public extension OverlayViewController {
    /// Dismiss the presented overlay.
    func dismissOverlay() {
        self.overlayState.dismiss()
    }
}
