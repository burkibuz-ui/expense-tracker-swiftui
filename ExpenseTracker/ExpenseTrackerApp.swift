import SwiftUI

@main
struct ExpenseTrackerApp: App {

    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}
