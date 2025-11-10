# ExpenseTrackerPro

A modern iOS expense tracking application built with SwiftUI and SwiftData that helps you manage your personal finances effortlessly.

## Features

- **Real-time Balance Tracking**: Monitor your current balance and total spending at a glance
- **Expense Management**: Add, view, and delete expenses with ease
- **Category Filtering**: Organize and filter expenses by categories
- **Custom Starting Balance**: Set your initial balance during onboarding
- **Persistent Storage**: All data is stored locally using SwiftData
- **Intuitive UI**: Clean and modern interface built with SwiftUI
- **Onboarding Flow**: Smooth first-time user experience
- **Currency Support**: Formatted for Indian Rupee (₹) with proper localization

## Screenshots

<!-- Add screenshots here when available -->

## Technologies Used

- **Swift**: Primary programming language
- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Data persistence and management
- **Xcode**: Development environment

## Requirements

- iOS 17.0+
- Xcode 15.0+
- macOS 14.0+ (for development)

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/ExpenseTrackerPro.git
```

2. Open the project in Xcode
```bash
cd ExpenseTrackerPro
open ExpenseTrackerPro.xcodeproj
```

3. Build and run the project
- Select your target device or simulator
- Press `Cmd + R` to build and run

## Project Structure

```
ExpenseTrackerPro/
├── ExpenseTrackerPro/
│   ├── ExpenseTrackerProApp.swift    # App entry point
│   ├── ContentView.swift             # Main view with expense list
│   ├── AddExpenseView.swift          # Add new expense screen
│   ├── OnboardingView.swift          # First-time user onboarding
│   ├── SettingsView.swift            # App settings
│   ├── FilterView.swift              # Category filter view
│   ├── BalanceCardView.swift         # Balance display card
│   ├── ExpenseRowView.swift          # Individual expense row
│   ├── Expense.swift                 # Expense data model
│   ├── Category.swift                # Category model
│   └── AppSettings.swift             # Settings data model
├── ExpenseTrackerProTests/
└── ExpenseTrackerProUITests/
```

## Usage

1. **First Launch**: Set your starting balance during the onboarding process
2. **Add Expense**: Tap the '+' button to add a new expense with amount, category, date, and optional notes
3. **Filter Expenses**: Use the search icon to filter expenses by category
4. **Delete Expense**: Swipe left on any expense or use Edit mode
5. **View Settings**: Tap the gear icon to access app settings

## Key Components

### Models
- **Expense**: Core data model for expense entries
- **Category**: Categorization system for expenses
- **AppSettings**: User preferences and configuration

### Views
- **ContentView**: Main dashboard displaying balance and expense list
- **BalanceCardView**: Visual representation of current balance and total spent
- **AddExpenseView**: Form for creating new expenses
- **OnboardingView**: Initial setup experience
- **SettingsView**: Configuration and preferences

### Screenshots

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 53 08" src="https://github.com/user-attachments/assets/ad945a32-a42a-469b-b1fd-ccaf70611abf" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 52 16" src="https://github.com/user-attachments/assets/30190d2c-d0c3-4b1f-ad45-086c58724423" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 51 43 #2" src="https://github.com/user-attachments/assets/8b88692c-bd0f-4284-bbb8-aadbad95f40b" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 51 43" src="https://github.com/user-attachments/assets/3c182151-270f-482e-990b-027fefb54601" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 53 35" src="https://github.com/user-attachments/assets/d9f3cd50-06ba-4f6e-ab03-ac97b6c5e7d1" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 53 26" src="https://github.com/user-attachments/assets/a53b9313-1bca-4287-8ee8-92cc0dcb1095" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-01 at 18 53 20" src="https://github.com/user-attachments/assets/dcaa7e73-637a-46a8-8792-84de9e17b189" />

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is available for personal and educational use.

## Contact

Shalinth Adithyan - https://www.linkedin.com/in/shalinth-adithyan/

Project Link: https://github.com/shalinth-adith/ExpenseTrackerPro

## Acknowledgments

- Built with SwiftUI and SwiftData
- Inspired by modern personal finance apps
- Icons from SF Symbols

---

Made with ❤️ by Shalinth Adithyan
