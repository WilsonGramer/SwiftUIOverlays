import SwiftUI
import UIKit

/// Show the provided view controller as an overlay.
///
/// - Parameter interactionEnabled: Set this to `false` to allow touches to pass through this overlay.
public func showOverlay(_ viewController: OverlayViewController, interactionEnabled: Bool = true) {
    var window: OverlayWindow!

    window = OverlayWindow()
    window.rootViewController = viewController
    window.backgroundColor = .clear
    window.isUserInteractionEnabled = interactionEnabled

    let overlayState = OverlayState(
        viewController: viewController,
        dismiss: { window = nil }
    )

    viewController.overlayState = overlayState

    window.makeKeyAndVisible()
}

/// Show the provided view as an overlay.
///
/// - Parameter animationDuration: The duration of the animation used to present this overlay.
/// - Parameter animation: The animation used to present this overlay. Its duration must match `animationDuration`.
/// - Parameter interactionEnabled: Set this to `false` to allow touches to pass through this overlay.
public func showOverlay<Content: View>(animationDuration: Double = 0.55, animation: (_ duration: Double) -> Animation = { .spring(response: $0) }, interactionEnabled: Bool = true, @ViewBuilder content: () -> Content) {
    var hostingController: OverlayViewController!

    hostingController = OverlayHostingController(rootView: OverlayContainerView(
        hostingController: { hostingController },
        animationDuration: animationDuration,
        animation: animation(animationDuration),
        content: content()
    ))

    hostingController!.view.backgroundColor = .clear
    showOverlay(hostingController!, interactionEnabled: interactionEnabled)
}

public extension EnvironmentValues {
    private struct DismissOverlayKey: EnvironmentKey {
        static var defaultValue: (() -> Void)? = nil
    }

    /// Dismiss the presented overlay. Crashes if called on a view that is not presented as an overlay.
    var dismissOverlay: () -> Void {
        get {
            self[DismissOverlayKey.self] ?? {
                fatalError("View is not presented as an overlay")
            }
        }
        set {
            self[DismissOverlayKey.self] = newValue
        }
    }
}
