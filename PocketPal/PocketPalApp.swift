import SwiftUI

@main
struct PocketPalApp: App {
    var body: some Scene {
        let context = Persistence.shared.container.viewContext
        WindowGroup {
            HomeScreenView(viewModel: HomeScreenViewModel()).environment(\.managedObjectContext, context)
        }
    }
}
