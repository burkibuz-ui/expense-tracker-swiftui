import SwiftUI

struct LoginView: View {

    @EnvironmentObject var session: SessionManager

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome Back")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                session.login()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
