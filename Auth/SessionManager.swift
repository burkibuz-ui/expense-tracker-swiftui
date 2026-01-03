import SwiftUI
import Combine
class SessionManager: ObservableObject {

    @Published var isLoggedIn: Bool = false

    func login() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}
