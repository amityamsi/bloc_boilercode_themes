import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quickalert/quickalert.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppUtils {
  // Show loading dialog
  static void showLoading(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // Hide loading dialog
  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
  
  // Show success snackbar
  static void showSuccess(BuildContext context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  
  // Show error snackbar
  static void showError(BuildContext context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
  
  // Show warning snackbar
  static void showWarning(BuildContext context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  
  // Show info snackbar
  static void showInfo(BuildContext context, String message, {String? title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Show loading dialog
  static void showLoadingDialog({
    required BuildContext context,
    String? message,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: message,
      backgroundColor: AppColors.scaffoldBackground,
      headerBackgroundColor: AppColors.scaffoldBackground,
      titleColor: AppColors.textPrimary,
      confirmBtnText: 'OK',
      confirmBtnColor: AppColors.primary,
    );
  }

  // Show info dialog
  static void showInfoDialog({
    required BuildContext context,
    required String message,
    String? confirmText,
    String? title,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: title,
      titleColor: AppColors.textPrimary,
      backgroundColor: AppColors.scaffoldBackground,
      widget: Center(
        child: Text(message, style: AppTextStyles.titleMedium,),
      ),
    );
  } 

  // Show success dialog
  static void showSuccessDialog({
    required BuildContext context,
    required String message,
    String? confirmText,
    String? title,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success, 
      title: title,
      titleColor: AppColors.textPrimary,
      backgroundColor: AppColors.scaffoldBackground,
      widget: Center(
        child: Text(message, style: AppTextStyles.titleMedium,),
      ),
      confirmBtnText: confirmText ?? 'OK',
      confirmBtnColor: AppColors.primary,
    );
  }

  // Show error dialog
  static void showErrorDialog({ 
    required BuildContext context,
    required String message,
    String? confirmText,
    String? title,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: title,
      titleColor: AppColors.textPrimary,
      backgroundColor: AppColors.scaffoldBackground,
      widget: Center(
        child: Text(message, style: AppTextStyles.titleMedium,),
      ),
      confirmBtnText: confirmText ?? 'OK',
      confirmBtnColor: AppColors.error,
    );
  }

  // Show warning dialog
  static void showWarningDialog({
    required BuildContext context,
    required String message,
    String? confirmText,
    String? title,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning, 
      title: title,
      titleColor: AppColors.textPrimary,
      backgroundColor: AppColors.scaffoldBackground,
      widget: Center(
        child: Text(message, style: AppTextStyles.titleMedium,),
      ),
      confirmBtnText: confirmText ?? 'OK',
      confirmBtnColor: AppColors.warning,
    );
  }
  
  // Show confirmation dialog
  static Future<bool> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {

   final result = await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: title,
      titleColor: AppColors.textPrimary,
      widget: Center(
        child: Text(message, style: AppTextStyles.titleMedium,),
      ),
      backgroundColor: AppColors.scaffoldBackground,
      confirmBtnText: confirmText,
      cancelBtnText: cancelText,
      onConfirmBtnTap: () => Navigator.of(context).pop(true),
      onCancelBtnTap: () => Navigator.of(context).pop(false),
    );
   
    return result ?? false;
  }
  
  // Show custom dialog
  static Future<dynamic> showCustomDialog({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    String? title,
  }) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        title: title,
        titleColor: AppColors.textPrimary,
        backgroundColor: AppColors.scaffoldBackground,
        barrierDismissible: barrierDismissible,
        widget: child,
      );
  }
  
  // Show bottom sheet
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = false,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) => child,
    );
  }
  
  // Validate email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  // Validate phone number
  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s-()]{10,}$').hasMatch(phone);
  }

  static bool isValidUrl(String url) {
    return Uri.tryParse(url)?.isAbsolute ?? false;
  }
  
  static bool isValidCreditCard(String cardNumber) {
    return RegExp(r'^[0-9]{16}$').hasMatch(cardNumber);
  }
  
  
  // Validate password strength
  static bool isStrongPassword(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password);
  }
  
  // Format date
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    // Simple date formatting - you can use intl package for more complex formatting
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
  
  // Format time
  static String formatTime(DateTime time, {bool includeSeconds = false}) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');
    
    if (includeSeconds) {
      return '$hour:$minute:$second';
    }
    return '$hour:$minute';
  }
  
  // Format currency
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }
  
  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  
  // Get initials from name
  static String getInitials(String name) {
    final names = name.trim().split(' ');
    if (names.isEmpty) return '';
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[names.length - 1][0]}'.toUpperCase();
  }
  
  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  
  // Truncate text
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$suffix';
  }
  
  // Generate random string
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();
    
    for (int i = 0; i < length; i++) {
      buffer.write(chars[random % chars.length]);
    }
    
    return buffer.toString();
  }
  
  // Debounce function
  static Function debounce(Function func, Duration wait) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(wait, () => func());
    };
  }
  
  // Throttle function
  static Function throttle(Function func, Duration wait) {
    DateTime? lastRun;
    return () {
      final now = DateTime.now();
      if (lastRun == null || now.difference(lastRun!) >= wait) {
        lastRun = now;
        func();
      }
    };
  }
  
  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }
  
  // Check if device is phone
  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600;
  }
  
  // Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  // Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  // Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
  
  // Get bottom padding
  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
  
  // Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
  
  // Show keyboard
  static void showKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
  
  // Copy to clipboard
  static Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    showSuccess(context, 'Copied to clipboard');
  }
  
  // Launch URL
  static Future<void> launchUrl(String url) async {
    // You can use url_launcher package here
    // await launchUrl(Uri.parse(url));
    print('Launching URL: $url');
  }
  
  // Share text
  static Future<void> shareText(String text) async {
    // You can use share_plus package here
    // await Share.share(text);
    print('Sharing text: $text');
  }
  
  // Take screenshot
  static Future<Uint8List?> takeScreenshot(GlobalKey key) async {
    try {
      final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      final image = await boundary?.toImage(pixelRatio: 3.0);
      final byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error taking screenshot: $e');
      return null;
    }
  }
  
  // Save image to gallery
  static Future<void> saveImageToGallery(Uint8List bytes) async {
    // You can use image_gallery_saver package here
    // await ImageGallerySaver.saveImage(bytes);
    print('Saving image to gallery');
  }
  
  // Check internet connectivity
  static Future<bool> checkInternetConnectivity() async {
    // You can use connectivity_plus package here
    // final connectivityResult = await Connectivity().checkConnectivity();
    // return connectivityResult != ConnectivityResult.none;
    return true; // Placeholder
  }
  
  // Get device info
  static Map<String, dynamic> getDeviceInfo() {
    return {
      'platform': defaultTargetPlatform.toString(),
      'isWeb': kIsWeb,
      'isAndroid': defaultTargetPlatform == TargetPlatform.android,
      'isIOS': defaultTargetPlatform == TargetPlatform.iOS,
      'isWindows': defaultTargetPlatform == TargetPlatform.windows,
      'isMacOS': defaultTargetPlatform == TargetPlatform.macOS,
      'isLinux': defaultTargetPlatform == TargetPlatform.linux,
    };
  }
  
  // Check if device is mobile
  static bool isMobile() {
    return defaultTargetPlatform == TargetPlatform.android || 
           defaultTargetPlatform == TargetPlatform.iOS;
  }
  
  // Check if device is desktop
  static bool isDesktop() {
    return defaultTargetPlatform == TargetPlatform.windows || 
           defaultTargetPlatform == TargetPlatform.macOS || 
           defaultTargetPlatform == TargetPlatform.linux;
  }
  
  // Check if device is web
  static bool isWeb() {
    return kIsWeb;
  }

  // Date and Time Selection Utilities
  static Future<DateTime?> selectDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? title,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  static Future<TimeOfDay?> selectTime({
    required BuildContext context,
    TimeOfDay? initialTime,
    String? title,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  static Future<DateTimeRange?> selectDateRange({
    required BuildContext context,
    DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
    String? title,
  }) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      initialDateRange: initialDateRange ?? DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  // Image Selection Utilities
  static Future<File?> pickImage({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality ?? 80,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      showError(context, 'Failed to pick image: $e');
      return null;
    }
  }

  static Future<List<File>> pickMultipleImages({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality ?? 80,
      );
      
      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      showError(context, 'Failed to pick images: $e');
      return [];
    }
  }

  static Future<File?> takePhoto({
    required BuildContext context,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    return pickImage(
      context: context,
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
  }

  // File Selection Utilities
  static Future<File?> pickFile({
    required BuildContext context,
    List<String>? allowedExtensions,
    String? dialogTitle,
    bool allowMultiple = false,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: dialogTitle,
        allowMultiple: allowMultiple,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      showError(context, 'Failed to pick file: $e');
      return null;
    }
  }

  static Future<List<File>> pickMultipleFiles({
    required BuildContext context,
    List<String>? allowedExtensions,
    String? dialogTitle,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: dialogTitle,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .toList();
      }
      return [];
    } catch (e) {
      showError(context, 'Failed to pick files: $e');
      return [];
    }
  }

  static Future<File?> pickDocument({
    required BuildContext context,
    List<String>? allowedExtensions,
    String? dialogTitle,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['pdf', 'doc', 'docx', 'txt'],
        dialogTitle: dialogTitle ?? 'Select Document',
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      showError(context, 'Failed to pick document: $e');
      return null;
    }
  }

  static Future<File?> pickVideo({
    required BuildContext context,
    List<String>? allowedExtensions,
    String? dialogTitle,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['mp4', 'avi', 'mov', 'mkv'],
        dialogTitle: dialogTitle ?? 'Select Video',
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      showError(context, 'Failed to pick video: $e');
      return null;
    }
  }

  static Future<File?> pickAudio({
    required BuildContext context,
    List<String>? allowedExtensions,
    String? dialogTitle,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['mp3', 'wav', 'aac', 'm4a'],
        dialogTitle: dialogTitle ?? 'Select Audio',
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      showError(context, 'Failed to pick audio: $e');
      return null;
    }
  }

  // Get app version
  static String getAppVersion() {
    // You can use package_info_plus package here
    return '1.0.0';
  }
  
  // Get build number
  static String getBuildNumber() {
    // You can use package_info_plus package here
    return '1';
  }
  
  // Check if app is in debug mode
  static bool isDebugMode() {
    return kDebugMode;
  }
  
  // Check if app is in release mode
  static bool isReleaseMode() {
    return kReleaseMode;
  }
  
  // Check if app is in profile mode
  static bool isProfileMode() {
    return kProfileMode;
  }
}

// Common widgets
class AppWidgets {
  // Loading widget
  static Widget loading({String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
  
  // Empty state widget
  static Widget emptyState({
    required String message,
    IconData? icon,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.inbox_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
  
  // Error state widget
  static Widget errorState({
    required String message,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
  
  // Divider widget
  static Widget divider({double height = 1, double margin = 16}) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: margin),
      color: AppColors.divider,
    );
  }
  
  // Spacer widget
  static Widget spacer({double height = 16}) {
    return SizedBox(height: height);
  }
  
  // Horizontal spacer widget
  static Widget hSpacer({double width = 16}) {
    return SizedBox(width: width);
  }
}

// Animation enums
enum AnimationType { fast, normal, slow }
enum AnimationCurveType { easeIn, easeOut, easeInOut, bounce, elastic }