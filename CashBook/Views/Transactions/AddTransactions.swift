//
//  AddTransactions.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 5/3/25.
//

import SwiftUI

//struct Category: Identifiable, Hashable {
//    let id = UUID()
//    let name: String
//    let icon: String
//}

let sampleCategories: [Category] = [
    Category(name: "Groceries", icon: "cart.fill"),
    Category(name: "Transport", icon: "car.fill"),
    Category(name: "Food", icon: "fork.knife"),
    Category(name: "Health", icon: "heart.fill"),
    Category(name: "Entertainment", icon: "gamecontroller.fill"),
    Category(name: "Travel", icon: "airplane"),
    Category(name: "Shopping", icon: "bag.fill"),
    Category(name: "Bills", icon: "creditcard.fill"),
    Category(name: "Education", icon: "book.fill"),
    Category(name: "Fitness", icon: "figure.walk"),
    Category(name: "Savings", icon: "banknote.fill"),
    Category(name: "Investments", icon: "chart.bar.xaxis"),
    Category(name: "Clothes", icon: "tshirt.fill"),
    Category(name: "Home", icon: "house.fill"),
    Category(name: "Gifts", icon: "gift.fill"),
    Category(name: "Phone", icon: "iphone.gen2"),
    Category(name: "Utilities", icon: "bolt.fill"),
    Category(name: "Insurance", icon: "shield.fill"),
    Category(name: "Subscriptions", icon: "tv.fill"),
    Category(name: "Baby", icon: "figure.2.and.child.holdinghands"),
    Category(name: "Beauty", icon: "sparkles"),
    Category(name: "Charity", icon: "hands.sparkles.fill"),
    Category(name: "Pets", icon: "pawprint.fill"),
    Category(name: "Rent", icon: "building.columns.fill"),
    Category(name: "Water", icon: "drop.fill"),
    Category(name: "Cleaning", icon: "broom"),
    Category(name: "Repair", icon: "wrench.fill"),
    Category(name: "Parking", icon: "parkingsign.circle.fill"),
    Category(name: "Laundry", icon: "washer.fill"),
    Category(name: "Books", icon: "books.vertical.fill"),
    Category(name: "Internet", icon: "wifi"),
    Category(name: "Gaming", icon: "gamecontroller"),
    Category(name: "Camera", icon: "camera.fill"),
    Category(name: "Music", icon: "music.note"),
    Category(name: "Tools", icon: "hammer.fill"),
    Category(name: "Tickets", icon: "ticket.fill"),
    Category(name: "Hospital", icon: "cross.fill"),
    Category(name: "Fuel", icon: "fuelpump.fill"),
    Category(name: "Donations", icon: "gift.circle.fill"),
    Category(name: "Coffee", icon: "cup.and.saucer.fill"),
    Category(name: "Snacks", icon: "leaf.fill"),
    Category(name: "Doctor", icon: "stethoscope"),
    Category(name: "Salon", icon: "scissors"),
    Category(name: "Debt", icon: "exclamationmark.circle.fill"),
    Category(name: "Income", icon: "dollarsign.circle.fill"),
    Category(name: "Bonus", icon: "star.circle.fill"),
    Category(name: "Freelance", icon: "laptopcomputer"),
    Category(name: "Salary", icon: "briefcase.fill"),
    Category(name: "Other", icon: "ellipsis.circle")
]

struct AddTransactionView: View {
    enum TransactionType: String, CaseIterable {
        case income = "Income"
        case expense = "Expense"
    }

    @State private var selectedCategory: Category?
    @State private var showingCategoryPicker = false
    @State private var selectedDate: Date = .now
    @State private var showingCalendar = false
    @State private var transactionType: TransactionType = .expense
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var category: String = "Select Category"

    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Button(action: {
                    showingCalendar.toggle()
                    print("Open calendar view")
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                        Text("Select Date")
                    }
                    .padding(10)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                }

                Spacer()

                Button(action: {
                    // Action to mark recurring and show calendar (placeholder)
                    print("Set recurring and open recurrence calendar")
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "repeat")
                        Text("Recurring")
                    }
                    .padding(10)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // 1. Income / Expense Toggle
            Picker("Type", selection: $transactionType) {
                ForEach(TransactionType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // 2. Amount Entry Area
            ZStack {
                Text("$\(amount)")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 80)

            // 3. Category Button
            Button(action: {
                showingCategoryPicker = true
            }) {
                HStack {
                    Text(selectedCategory?.name ?? "Select Category")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .sheet(isPresented: $showingCategoryPicker) {
                CategoryPickerView(categories: sampleCategories) { category in
                    self.selectedCategory = category
                }
                .presentationDetents([.medium])
            }

            // 4. Description Field
            TextField("Description", text: $description)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)

            // 5. Custom Number Pad
            Spacer()
            NumberPadView(input: $amount)
                .padding(.bottom)
        }.sheet(isPresented: $showingCalendar) {
            CalendarView(selectedDate: $selectedDate)
                .presentationDetents([.medium])
        }
    }
}

struct CategoryPickerView: View {
    @Environment(\.dismiss) private var dismiss
    let categories: [Category]
    var onSelect: (Category) -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 6)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categories) { category in
                    VStack(spacing: 4) {
                        Button(action: {
                            onSelect(category)
                            dismiss()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.15))
                                    .frame(width: 44, height: 44)
                                Image(systemName: category.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.blue)
                            }
                        }
                        Text(category.name)
                            .font(.caption2)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}



struct NumberPadView: View {
    @Binding var input: String

    let buttons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"]
    ]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            handleInput(item)
                        }) {
                            Text(item)
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private func handleInput(_ value: String) {
        switch value {
        case "⌫":
            if !input.isEmpty {
                input.removeLast()
            }
        case ".":
            if !input.contains(".") {
                input += "."
            }
        default:
            if input.count < 10 {
                input += value
            }
        }
    }
}

struct CalendarDay: Identifiable, Hashable {
    let id = UUID()
    let date: Date?
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss
    
    @State private var displayedMonth: Date = Date()

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 12) {
            
            // Month Navigation
            HStack {
                Button(action: {
                    displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
                }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(displayedMonth, formatter: DateFormatter.monthYear)
                    .font(.headline)

                Spacer()

                Button(action: {
                    displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(canMoveToNextMonth ? .primary : .gray)
                }
                .disabled(!canMoveToNextMonth)
            }
            .padding(.horizontal)

            // Weekday headers
            HStack {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }

            // Date grid
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(generateDays()) { day in
                    if let date = day.date {
                        Button(action: {
                            selectedDate = date
                            dismiss()
                        }) {
                            Text("\(calendar.component(.day, from: date))")
                                .frame(maxWidth: .infinity, minHeight: 36)
                                .foregroundColor(textColor(for: date))
                                .background(
                                    Circle()
                                        .fill(date.isSameDay(as: selectedDate) ? Color.blue : Color.clear)
                                )
                        }
                        .disabled(!calendar.isDateInTodayOrBefore(date))
                    } else {
                        Text("") // Placeholder for empty grid space
                            .frame(maxWidth: .infinity, minHeight: 36)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }

    private func generateDays() -> [CalendarDay] {
        var days: [CalendarDay] = []

        guard let range = calendar.range(of: .day, in: .month, for: displayedMonth),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)) else {
            return days
        }

        let weekday = calendar.component(.weekday, from: firstOfMonth)
        let padding = weekday - calendar.firstWeekday
        let offset = padding < 0 ? padding + 7 : padding

        for _ in 0..<offset {
            days.append(CalendarDay(date: nil)) // Placeholder
        }

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(CalendarDay(date: date))
            }
        }

        return days
    }

    private func textColor(for date: Date) -> Color {
        if date == Date.distantPast {
            return .clear
        }
        if !calendar.isDateInTodayOrBefore(date) {
            return .gray
        }
        return .primary
    }

    private var canMoveToNextMonth: Bool {
        let startOfDisplayedMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!
        let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfDisplayedMonth)!
        return startOfNextMonth <= calendar.startOfDay(for: Date())
    }
}

private extension Date {
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    static func startOfMonth(from date: Date) -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: date))!
    }
}

private extension Calendar {
    func isDateInTodayOrBefore(_ date: Date) -> Bool {
        let today = self.startOfDay(for: Date())
        return date <= today
    }
}

private extension DateFormatter {
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter
    }()
}

#Preview {
    AddTransactionView()
}
