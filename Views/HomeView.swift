import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = ExpenseViewModel()
    @State private var showAddExpense = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 🌫️ Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 20) {

                    // 💳 TOTAL CARD
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Toplam Harcama")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))

                        Text("₺\(viewModel.totalAmount, specifier: "%.2f")")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 6)
                    .padding(.horizontal)

                    // 📦 EXPENSE LIST
                    if viewModel.expenses.isEmpty {
                        // 💤 Empty State
                        VStack(spacing: 12) {
                            Image(systemName: "tray")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)

                            Text("Henüz harcama yok")
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 60)
                    } else {
                        List {
                            ForEach(viewModel.expenses) { expense in
                                ExpenseRowView(expense: expense)
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                            .onDelete(perform: viewModel.removeExpense)
                        }
                        .listStyle(.plain)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Expense Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddExpense = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView()
}

