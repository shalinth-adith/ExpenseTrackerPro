 # ExpenseTrackerPro

  A modern iOS expense tracking application built with SwiftUI and SwiftData that helps you manage your personal finances effortlessly.

  ## Features

  ### Core Functionality
  - **Income & Expense Tracking**: Track both income and expenses with dedicated transaction types
  - **Real-time Balance Calculation**: Automatic balance calculation (Starting Balance + Total Income - Total Expenses)
  - **Smart Balance Card**: Beautiful animated card with layered depth effect displaying current balance, income, and expenses
  - **Collapsible Balance View**: Balance card automatically compacts when scrolling for better screen utilization
  - **Transaction Management**: Add, view, and delete transactions with swipe gestures

  ### Categories & Filtering
  - **Built-in Categories**: Food, Transport, Shopping, Bills, and Other
  - **Smart Custom Categories**: Create custom categories that automatically become permanent after 4 uses
  - **Category Progress Tracking**: Monitor custom category usage (e.g., "3/4" until activation)
  - **Active Category Display**: Custom categories with ≥4 uses appear in the category picker
  - **Category Filtering**: Filter transactions by specific categories for better organization

  ### User Interface
  - **Modern Gradient Design**: Stunning gradient backgrounds with theme-aware color schemes (dark/light mode)
  - **Animated UI Elements**: Smooth animations for balance updates and UI transitions
  - **Empty State Views**: Intuitive guidance when no transactions exist
  - **Progress Visualization**: Visual progress bar showing spending percentage
  - **Indian Rupee Support**: Formatted for ₹ with proper localization (en_IN)

  ### Data & Settings
  - **Persistent Storage**: All data stored locally using SwiftData
  - **Custom Starting Balance**: Set initial balance during onboarding
  - **Comprehensive Settings**: View balance details, transaction count, and custom categories
  - **Transaction History**: Sorted by date (newest first) with detailed information
  - **Notes Support**: Add optional notes to any transaction

  ### User Experience
  - **Smooth Onboarding**: First-time user setup flow
  - **Swipe to Delete**: Quick deletion with swipe gestures
  - **Form Validation**: Input validation with helpful error messages
  - **Transaction Summary**: Total income and expense breakdown at the bottom of transaction list
  - **Theme Support**: Automatic dark mode and light mode adaptation

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
  bash
  git clone https://github.com/yourusername/ExpenseTrackerPro.git

  2. Open the project in Xcode
  cd ExpenseTrackerPro
  open ExpenseTrackerPro.xcodeproj

  3. Build and run the project
  - Select your target device or simulator
  - Press Cmd + R to build and run

  Project Structure

  ExpenseTrackerPro/
  ├── ExpenseTrackerPro/
  │   ├── ExpenseTrackerProApp.swift    # App entry point
  │   ├── ContentView.swift             # Main view with transaction list
  │   ├── AddExpenseView.swift          # Add new transaction screen
  │   ├── OnboardingView.swift          # First-time user onboarding
  │   ├── SettingsView.swift            # App settings
  │   ├── FilterView.swift              # Category filter view
  │   ├── BalanceCardView.swift         # Animated balance display card
  │   ├── ExpenseRowView.swift          # Individual transaction row
  │   ├── Expense.swift                 # Transaction data model
  │   ├── Category.swift                # Category enum
  │   ├── Custom Category.swift         # Custom category model
  │   └── AppSettings.swift             # Settings data model
  ├── ExpenseTrackerProTests/
  └── ExpenseTrackerProUITests/

  Usage

  1. First Launch: Set your starting balance during the onboarding process
  2. Add Transaction: Tap the '+' button to add income or expense with amount, category, date, and optional notes
  3. Toggle Type: Use the segmented control to switch between Income and Expense
  4. Custom Categories: Select "Other" and enter a custom category name. After 4 uses, it becomes permanent
  5. Filter Transactions: Use the filter icon to view transactions by specific category
  6. Delete Transaction: Swipe left on any transaction to delete it
  7. View Settings: Tap the gear icon to access balance details and view custom categories

  Key Components

  Models

  - Expense: Core data model for transaction entries with income/expense type support
  - TransactionType: Enum for distinguishing between income and expense transactions
  - Category: Built-in categorization system (Food, Transport, Shopping, Bills, Other)
  - CustomCategory: User-created categories with usage tracking and auto-activation
  - AppSettings: User preferences and configuration

  Views

  - ContentView: Main dashboard displaying balance card and transaction list with filtering
  - BalanceCardView: Animated card with layered depth effect, showing balance, income, and expenses
  - AddExpenseView: Form for creating new income/expense transactions with validation
  - OnboardingView: Initial setup experience for setting starting balance
  - SettingsView: Configuration panel showing balance details and custom categories
  - FilterView: Category selection for filtering transactions
  - ExpenseRowView: Individual transaction display component

  Screenshots
<img width="400" height="859" alt="Screenshot 2025-11-10 at 3 42 43 PM" src="https://github.com/user-attachments/assets/8e30e448-b71f-428d-98d7-b13a6fc43a64" />
<img width="400" height="859" alt="Screenshot 2025-11-10 at 3 47 51 PM" src="https://github.com/user-attachments/assets/d183cd3d-1536-4855-86d1-356138937c2c" />
<img width="400" height="859" alt="Screenshot 2025-11-10 at 3 47 59 PM" src="https://github.com/user-attachments/assets/20a43127-3e29-4e96-ae45-e8313c3986e7" />
<<img width="400" height="859" alt="Screenshot 2025-11-10 at 3 49 13 PM" src="https://github.com/user-attachments/assets/f2ce84de-f298-45c6-9658-b58a003e980a" />
<<img width="400" height="859" alt="Screenshot 2025-11-10 at 3 49 27 PM" src="https://github.com/user-attachments/assets/f9c6c67e-d145-4df5-9363-9d8ec0ec2291" />


  Contributing

  Contributions are welcome! Please feel free to submit a Pull Request.

  1. Fork the project
  2. Create your feature branch (git checkout -b feature/AmazingFeature)
  3. Commit your changes (git commit -m 'Add some AmazingFeature')
  4. Push to the branch (git push origin feature/AmazingFeature)
  5. Open a Pull Request

  License

  This project is available for personal and educational use.

  Contact

  Shalinth Adithyan - https://www.linkedin.com/in/shalinth-adithyan/

  Project Link: https://github.com/shalinth-adith/ExpenseTrackerPro

  Acknowledgments

  - Built with SwiftUI and SwiftData
  - Inspired by modern personal finance apps
  - Icons from SF Symbols

  ---
  Made with ❤️ by Shalinth Adithyan
