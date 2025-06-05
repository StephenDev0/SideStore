import SwiftUI

struct HomeView: View {
    private enum Tab: Hashable {
        case news, sources, browse, myApps, settings
    }

    @State private var selectedTab: Tab = .news

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("News")
                .tabItem { Label("News", systemImage: "newspaper") }
                .tag(Tab.news)

            Text("Sources")
                .tabItem { Label("Sources", systemImage: "tray.full") }
                .tag(Tab.sources)

            Text("Browse")
                .tabItem { Label("Browse", systemImage: "bag") }
                .tag(Tab.browse)

            Text("My Apps")
                .tabItem { Label("My Apps", systemImage: "apps.iphone") }
                .tag(Tab.myApps)

            Text("Settings")
                .tabItem { Label("Settings", systemImage: "gear") }
                .tag(Tab.settings)
        }
        .onReceive(NotificationCenter.default.publisher(for: AppDelegate.openPatreonSettingsDeepLinkNotification)) { _ in
            selectedTab = .settings
        }
        .onReceive(NotificationCenter.default.publisher(for: AppDelegate.importAppDeepLinkNotification)) { _ in
            selectedTab = .myApps
        }
        .onReceive(NotificationCenter.default.publisher(for: AppDelegate.addSourceDeepLinkNotification)) { _ in
            selectedTab = .sources
        }
        .onReceive(NotificationCenter.default.publisher(for: AppDelegate.exportCertificateNotification)) { _ in
            selectedTab = .settings
        }
        .onReceive(NotificationCenter.default.publisher(for: ToastView.openErrorLogNotification)) { _ in
            selectedTab = .settings
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
