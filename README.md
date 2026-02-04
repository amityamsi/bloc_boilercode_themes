# Flutter Bloc Boilerplate

A comprehensive Flutter boilerplate project using **Flutter Bloc** for state management, featuring authentication, themes, multi-language support with RTL, custom widgets, and a complete development foundation.

## 🚀 Features

- **State Management**: Flutter Bloc with proper separation of concerns
- **Authentication**: Complete auth flow (Login, Signup, Forgot Password) with validation
- **Theme Management**: Light/Dark theme support with persistence
- **Multi-Language**: Support for 9 languages with comprehensive RTL support
- **RTL Support**: Full Right-to-Left layout support for Arabic, Hebrew, Persian, and Urdu
- **Custom Widgets**: Reusable UI components with theme integration
- **Routing**: Go Router with path parameters and query parameters
- **API Service**: HTTP client with interceptors and token management
- **Form Validation**: Comprehensive form validation with localized messages
- **Responsive Design**: Mobile-first responsive design
- **Localization System**: Custom localization with RTL-aware layouts
- **Utility Functions**: File picking, image selection, screenshots, and more

## 📁 Project Structure

```
lib/
├── core/
│   ├── blocs/
│   │   ├── theme/
│   │   │   └── theme_bloc.dart
│   │   └── language/
│   │       └── language_bloc.dart
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── image_constants.dart
│   ├── localization/
│   │   ├── app_localizations.dart
│   │   └── translations/
│   │       ├── en.dart
│   │       ├── ar.dart
│   │       ├── he.dart
│   │       ├── fa.dart
│   │       ├── ur.dart
│   │       ├── es.dart
│   │       ├── fr.dart
│   │       ├── de.dart
│   │       └── hi.dart
│   ├── routes/
│   │   └── app_router.dart
│   ├── services/
│   │   └── api_service.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── app_utils.dart
│   │   └── rtl_utils.dart
│   └── widgets/
│       ├── animated_wrappers.dart
│       ├── app_button.dart
│       ├── app_card.dart
│       └── app_text_field.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── auth_request_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── auth_bloc.dart
│   │       └── pages/
│   │           ├── login_page.dart
│   │           ├── signup_page.dart
│   │           └── forgot_password_page.dart
│   └── demo/
│       └── presentation/
│           └── pages/
│               ├── demo_page.dart
│               └── rtl_demo_page.dart
└── main.dart
```

## 🏗️ Architecture

### Bloc Pattern Implementation

The project follows the **Bloc Pattern** with clear separation of concerns:

- **Events**: Define what can happen
- **States**: Define the possible states of the application
- **Blocs**: Handle the business logic and emit states

### Feature-Based Structure

Each feature is organized in its own directory with:
- `data/`: Models, repositories, and data sources
- `presentation/`: UI components, blocs, and pages

### Clean Architecture Principles

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Data sources and repositories

## 🔧 Setup & Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_bloc_boilerplate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for JSON serialization)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Authentication Flow

The authentication module includes complete localization and RTL support:

### Login Page
- Email and password validation with localized messages
- Form validation with error messages in multiple languages
- Loading states with localized text
- RTL-aware layout and navigation
- Navigation to signup and forgot password

### Signup Page
- Full name, email, phone (optional), password fields
- Password confirmation with validation
- Comprehensive form validation with localized messages
- Loading states with RTL support
- Responsive design for all screen sizes

### Forgot Password Page
- Email validation with localized messages
- Success/error feedback in user's language
- RTL-aware navigation back to login
- Consistent theming across all auth pages

## 🎨 Theme System

The theme system supports:
- Light and dark themes with persistent selection
- Automatic theme switching with Bloc state management
- Custom color schemes with proper contrast
- Theme-aware custom widgets
- Dynamic color adaptation based on theme mode

## 🌍 Multi-Language Support

### Supported Languages
- **English** (en) - Default language
- **Arabic** (ar) - Full RTL support
- **Hebrew** (he) - Full RTL support
- **Persian** (fa) - Full RTL support
- **Urdu** (ur) - Full RTL support
- **Spanish** (es)
- **French** (fr)
- **German** (de)
- **Hindi** (hi)

### RTL Support Features
- **Text Direction**: Automatic RTL/LTR switching
- **Layout Alignment**: Dynamic alignment for rows and columns
- **Icon Direction**: Proper icon placement for RTL languages
- **Padding/Margin**: Automatic flipping of asymmetric spacing
- **Navigation**: RTL-aware navigation elements
- **Form Layouts**: Proper form field positioning

### Localization Usage
```dart
// Get translation
context.tr('login')

// Check RTL status
context.isRTL

// Get RTL-aware alignment
context.alignment
context.mainAxisAlignment
context.crossAxisAlignment

// Get text direction
context.textDirection
```

## 🧩 Custom Widgets

### AppButton
- Multiple button styles (primary, secondary, outlined)
- Loading states with localized text
- Customizable colors and sizes
- Theme-aware styling
- RTL support for button content

### AppTextField
- Various input types with validation
- Form validation with localized error messages
- Prefix/suffix icons with RTL support
- Custom styling with theme integration
- Password visibility toggle

### AppCard
- Consistent card design across the app
- Shadow and border options
- Responsive layout with RTL support
- Theme-aware background colors

## 🔌 API Service

The API service provides:
- HTTP methods (GET, POST, PUT, PATCH, DELETE)
- Automatic token management with SharedPreferences
- Comprehensive error handling
- Request/response interceptors
- Timeout configuration
- JSON serialization support

## 🛠️ Utility Functions

### AppUtils
- **File Operations**: File picking, image selection, video selection
- **Screenshots**: Capture widget screenshots
- **Dialogs**: Success, error, warning, info dialogs
- **Snackbars**: Localized snackbar messages
- **Loading**: Loading indicators with localized text
- **Validation**: Form validation helpers
- **Device Info**: Device information utilities
- **Clipboard**: Copy to clipboard functionality

### RTLUtils
- **Layout Helpers**: RTL-aware padding, margin, alignment
- **Text Direction**: Text direction utilities
- **Icon Helpers**: RTL-aware icon selection
- **Widget Wrappers**: RTL-aware widget containers

## 🧪 Testing

The project includes comprehensive testing setup:
- `bloc_test` for bloc testing
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for complete flows

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc`: State management
- `equatable`: Value equality
- `go_router`: Navigation with parameters
- `http`: HTTP client
- `shared_preferences`: Local storage
- `json_annotation`: JSON serialization
- `image_picker`: Image selection
- `file_picker`: File selection
- `quickalert`: Custom dialogs

### Development Dependencies
- `build_runner`: Code generation
- `json_serializable`: JSON serialization
- `bloc_test`: Bloc testing
- `flutter_lints`: Code linting

## 🚀 Getting Started

### Creating a New Feature

1. **Create the bloc**:
   ```dart
   class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
     MyFeatureBloc() : super(MyFeatureInitial()) {
       on<MyFeatureEvent>((event, emit) {
         // Handle events
       });
     }
   }
   ```

2. **Create the page with localization**:
   ```dart
   class MyFeaturePage extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return BlocProvider(
         create: (context) => MyFeatureBloc(),
         child: BlocBuilder<MyFeatureBloc, MyFeatureState>(
           builder: (context, state) {
             return Scaffold(
               appBar: AppBar(
                 title: Text(context.tr('my_feature_title')),
               ),
               body: Column(
                 crossAxisAlignment: context.crossAxisAlignment,
                 children: [
                   Text(context.tr('my_feature_description')),
                   // Your UI components
                 ],
               ),
             );
           },
         ),
       );
     }
   }
   ```

3. **Add routing with parameters**:
   ```dart
   GoRoute(
     path: '/my-feature/:id',
     name: 'my-feature',
     builder: (context, state) {
       final id = state.pathParameters['id']!;
       return MyFeaturePage(id: id);
     },
   ),
   ```

### Adding New Translations

1. **Add translation keys to all language files**:
   ```dart
   // In en.dart
   'my_feature_title': 'My Feature',
   'my_feature_description': 'This is my feature description',
   
   // In ar.dart
   'my_feature_title': 'ميزتي',
   'my_feature_description': 'هذا وصف ميزتي',
   ```

2. **Use in your widgets**:
   ```dart
   Text(context.tr('my_feature_title'))
   ```

## 🌐 RTL Implementation

### RTL-Aware Layouts
```dart
// Use RTL-aware alignment
Row(
  mainAxisAlignment: context.mainAxisAlignment,
  children: [
    Icon(Icons.arrow_back),
    Text(context.tr('back')),
  ],
)

// Use RTL-aware padding
Container(
  padding: RTLUtils.getPadding(
    left: 16,
    right: 8,
    languageState: context.watch<LanguageBloc>().state,
  ),
  child: Text(context.tr('content')),
)
```

### RTL Utilities
```dart
// Check if current language is RTL
if (context.isRTL) {
  // Handle RTL-specific logic
}

// Get RTL-aware icon
Icon(RTLUtils.getIcon(
  ltrIcon: Icons.arrow_forward,
  rtlIcon: Icons.arrow_back,
  languageState: context.watch<LanguageBloc>().state,
))
```

## 🔄 State Management Examples

### Theme Management
```dart
// Toggle theme
context.read<ThemeBloc>().add(ToggleTheme());

// Listen to theme changes
BlocBuilder<ThemeBloc, ThemeState>(
  builder: (context, state) {
    final isDarkMode = state is ThemeLoaded ? state.isDarkMode : false;
    return Container(
      color: AppColors.getBackgroundColor(isDarkMode),
      child: Text('Content'),
    );
  },
)
```

### Language Management
```dart
// Change language
context.read<LanguageBloc>().add(
  ChangeLanguage(languageCode: 'ar', countryCode: 'SA'),
);

// Listen to language changes
BlocBuilder<LanguageBloc, LanguageState>(
  builder: (context, languageState) {
    return Text(
      context.tr('welcome'),
      textAlign: languageState.getTextAlign(),
    );
  },
)
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes with proper localization support
4. Add tests if applicable
5. Ensure RTL support for new UI components
6. Update translations for all supported languages
7. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Bloc library maintainers for state management
- Go Router team for navigation solution
- All contributors to the localization and RTL support

## 📞 Support

If you have any questions or need help with the boilerplate:
- Create an issue on GitHub
- Check the demo pages for usage examples
- Review the localization system for RTL implementation



# bloc_boilercode_themes
