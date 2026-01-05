import SwiftUI

struct ExpenseRowView: View {

    let expense: Expense
    @State private var appeared = false
    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 14) {

            // 🎯 CATEGORY ICON
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.18))
                    .frame(width: 44, height: 44)

                Image(systemName: "creditcard")
                    .foregroundColor(categoryColor)
            }

            // 📄 TITLE + CATEGORY
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.headline)

                Text(expense.category)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // 💰 AMOUNT
            Text("₺\(expense.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(categoryColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(
                    color: Color.black.opacity(
                        colorScheme == .dark ? 0.25 : 0.08
                    ),
                    radius: 8,
                    x: 0,
                    y: 5
                )
        )
        .scaleEffect(isPressed ? 0.97 : 1)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 12)
        .animation(.spring(response: 0.45, dampingFraction: 0.85), value: isPressed)
        .animation(.easeOut(duration: 0.35), value: appeared)
        .onAppear {
            appeared = true
        }
        .onLongPressGesture(minimumDuration: 0.01, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
        .padding(.horizontal)
        .padding(.vertical, 4)
    }

    // 🎨 CATEGORY COLOR
    private var categoryColor: Color {
        switch expense.category {
        case "Yeme-İçme":
            return .orange
        case "Ulaşım":
            return .blue
        case "Eğlence":
            return .pink
        case "Kira":
            return .purple
        case "Diğer":
            return .gray
        default:
            return .green
        }
    }

    @Environment(\.colorScheme) private var colorScheme
}

#Preview {
    Group {
        ExpenseRowView(
            expense: Expense(
                id: UUID(),
                title: "Kahve",
                amount: 85,
                category: "Yeme-İçme",
                date: Date()
            )
        )
        .preferredColorScheme(.light)

        ExpenseRowView(
            expense: Expense(
                id: UUID(),
                title: "Kira",
                amount: 7500,
                category: "Kira",
                date: Date()
            )
        )
        .preferredColorScheme(.dark)
    }
}
