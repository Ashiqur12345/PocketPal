import SwiftUI

@main
struct PocketPalApp: App {
    var body: some Scene {
        let context = PersistenceController.shared.viewContext
        WindowGroup {
            HomeScreenView(viewModel: HomeScreenViewModel()).environment(\.managedObjectContext, context)
        }
    }
}
