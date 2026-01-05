import SwiftUI

struct AddExpenseView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var category: String = "Genel"

    private let categories = ["Genel", "Yeme-İçme", "Ulaşım", "Eğlence", "Kira", "Diğer"]

    var body: some View {
        NavigationStack {
            Form {

                Section(header: Text("Harcama Bilgileri")) {
                    TextField("Başlık", text: $title)

                    TextField("Tutar", text: $amount)
                        .keyboardType(.decimalPad)

                    Picker("Kategori", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                }
            }
            .navigationTitle("Harcama Ekle")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kaydet") {
                        saveExpense()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }

    // 🔒 Validation
    private var isFormValid: Bool {
        !title.isEmpty && Double(amount) != nil
    }

    // 💾 Save
    private func saveExpense() {
        guard let amountValue = Double(amount) else { return }

        viewModel.addExpense(
            title: title,
            amount: amountValue,
            category: category
        )
        dismiss()
    }
}

#Preview {
    AddExpenseView(viewModel: ExpenseViewModel())
}
