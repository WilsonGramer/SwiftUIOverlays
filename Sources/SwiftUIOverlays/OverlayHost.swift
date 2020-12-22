import SwiftUI

internal class OverlayWindow: UIWindow {}

internal class OverlayHostingController<Content: View>: UIHostingController<OverlayContainerView<Content>>, OverlayViewController {
    var overlayState: OverlayState!
}

internal struct OverlayContainerView<Content: View>: View {
    let hostingController: () -> OverlayViewController
    let animationDuration: Double
    let animation: Animation
    let content: Content

    @State private var showContent = false

    var body: some View {
        Group {
            if self.showContent {
                self.content.environment(\.dismissOverlay) {
                    guard let window = self.hostingController().view.window else { return }

                    window.isUserInteractionEnabled = false

                    withAnimation(self.animation) {
                        self.showContent = false
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                        self.hostingController().dismissOverlay()
                    }
                }
            }
        }
        .onAppear {
            withAnimation(self.animation) {
                self.showContent = true
            }
        }
    }
}
