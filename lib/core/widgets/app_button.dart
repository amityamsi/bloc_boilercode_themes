import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppButtonType {
  elevated,
  outlined,
  text,
  icon,
  iconText,
}

enum AppButtonSize {
  small,
  medium,
  large,
}

enum AppButtonState {
  enabled,
  disabled,
  loading,
}

class AppButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Widget? prefix;
  final Widget? suffix;
  final AppButtonType type;
  final AppButtonSize size;
  final AppButtonState state;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool fullWidth;
  final bool isLoading;
  final String? loadingText;
  final Widget? loadingWidget;
  final bool enableRipple;
  final FocusNode? focusNode;
  final bool autofocus;

  const AppButton({
    super.key,
    this.text,
    this.icon,
    this.prefix,
    this.suffix,
    this.type = AppButtonType.elevated,
    this.size = AppButtonSize.medium,
    this.state = AppButtonState.enabled,
    this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.padding,
    this.fullWidth = false,
    this.isLoading = false,
    this.loadingText,
    this.loadingWidget,
    this.enableRipple = true,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = state == AppButtonState.disabled;
    final isLoadingState = state == AppButtonState.loading || isLoading;
    final canPress = !isDisabled && !isLoadingState;

    Widget buttonChild = _buildButtonChild();

    if (fullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        child: buttonChild,
      );
    } else if (width != null || height != null) {
      buttonChild = SizedBox(
        width: width,
        height: height,
        child: buttonChild,
      );
    }

    switch (type) {
      case AppButtonType.elevated:
        return ElevatedButton(
          onPressed: canPress ? onPressed : null,
          onLongPress: canPress ? onLongPress : null,
          style: _getElevatedButtonStyle(),
          focusNode: focusNode,
          autofocus: autofocus,
          child: buttonChild,
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: canPress ? onPressed : null,
          onLongPress: canPress ? onLongPress : null,
          style: _getOutlinedButtonStyle(),
          focusNode: focusNode,
          autofocus: autofocus,
          child: buttonChild,
        );
      case AppButtonType.text:
        return TextButton(
          onPressed: canPress ? onPressed : null,
          onLongPress: canPress ? onLongPress : null,
          style: _getTextButtonStyle(),
          focusNode: focusNode,
          autofocus: autofocus,
          child: buttonChild,
        );
      case AppButtonType.icon:
        return IconButton(
          onPressed: canPress ? onPressed : null,
          icon: buttonChild,
          style: _getIconButtonStyle(),
          focusNode: focusNode,
          autofocus: autofocus,
        );
      case AppButtonType.iconText:
        return ElevatedButton.icon(
          onPressed: canPress ? onPressed : null,
          icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
          label: buttonChild,
          style: _getElevatedButtonStyle(),
          focusNode: focusNode,
          autofocus: autofocus,
        );
    }
  }

  Widget _buildButtonChild() {
    if (state == AppButtonState.loading || isLoading) {
      return _buildLoadingChild();
    }

    if (type == AppButtonType.icon) {
      return icon != null ? Icon(icon) : const SizedBox.shrink();
    }

    if (text == null && prefix == null && suffix == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefix != null) ...[
          prefix!,
          const SizedBox(width: 8),
        ],
        if (text != null)
          Flexible(
            child: Text(
              text!,
              style: _getTextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (suffix != null) ...[
          const SizedBox(width: 8),
          suffix!,
        ],
      ],
    );
  }

  Widget _buildLoadingChild() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loadingWidget ?? const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        if (loadingText != null) ...[
          const SizedBox(width: 8),
          Text(
            loadingText!,
            style: _getTextStyle(),
          ),
        ],
      ],
    );
  }

  ButtonStyle _getElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      elevation: _getElevation(),
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      disabledBackgroundColor: AppColors.buttonDisabled,
      disabledForegroundColor: AppColors.textDisabled,
    );
  }

  ButtonStyle _getOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: _getForegroundColor(),
      side: BorderSide(
        color: _getBorderColor(),
        width: 1,
      ),
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      disabledForegroundColor: AppColors.textDisabled,
      disabledBackgroundColor: AppColors.buttonDisabled,
    );
  }

  ButtonStyle _getTextButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: _getForegroundColor(),
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      disabledForegroundColor: AppColors.textDisabled,
    );
  }

  ButtonStyle _getIconButtonStyle() {
    return IconButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      disabledBackgroundColor: AppColors.buttonDisabled,
      disabledForegroundColor: AppColors.textDisabled,
    );
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.labelMedium;
      case AppButtonSize.medium:
        return AppTextStyles.button;
      case AppButtonSize.large:
        return AppTextStyles.titleMedium;
    }
  }

  Color _getBackgroundColor() {
    if (state == AppButtonState.disabled) {
      return AppColors.buttonDisabled;
    }
    return backgroundColor ?? AppColors.buttonPrimary;
  }

  Color _getForegroundColor() {
    if (state == AppButtonState.disabled) {
      return AppColors.textDisabled;
    }
    return foregroundColor ?? Colors.white;
  }

  Color _getBorderColor() {
    if (state == AppButtonState.disabled) {
      return AppColors.border;
    }
    return borderColor ?? AppColors.primary;
  }

  double _getElevation() {
    switch (size) {
      case AppButtonSize.small:
        return 1;
      case AppButtonSize.medium:
        return 2;
      case AppButtonSize.large:
        return 4;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    if (padding != null) return padding!;
    
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    }
  }
}

// Predefined button styles
class AppButtons {
  // Primary button
  static AppButton primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
    Widget? prefix,
    Widget? suffix,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.elevated,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      prefix: prefix,
      suffix: suffix,
    );
  }

  // Secondary button
  static AppButton secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
    Widget? prefix,
    Widget? suffix,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.outlined,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      prefix: prefix,
      suffix: suffix,
    );
  }

  // Text button
  static AppButton text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
    Widget? prefix,
    Widget? suffix,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.text,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      prefix: prefix,
      suffix: suffix,
    );
  }

  // Icon button
  static AppButton icon({
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return AppButton(
      key: key,
      icon: icon,
      onPressed: onPressed,
      type: AppButtonType.icon,
      size: size,
      state: state,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  // Success button
  static AppButton success({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.elevated,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      backgroundColor: AppColors.success,
      foregroundColor: Colors.white,
    );
  }

  // Error button
  static AppButton error({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.elevated,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      backgroundColor: AppColors.error,
      foregroundColor: Colors.white,
    );
  }

  // Warning button
  static AppButton warning({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.elevated,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      backgroundColor: AppColors.warning,
      foregroundColor: Colors.white,
    );
  }

  // Info button
  static AppButton info({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: AppButtonType.elevated,
      size: size,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
      backgroundColor: AppColors.info,
      foregroundColor: Colors.white,
    );
  }

  // Loading button
  static AppButton loading({
    Key? key,
    String? text,
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
    Widget? loadingWidget,
  }) {
    return AppButton(
      key: key,
      text: text,
      type: AppButtonType.elevated,
      size: size,
      state: AppButtonState.loading,
      fullWidth: fullWidth,
      loadingWidget: loadingWidget,
    );
  }

  // Disabled button
  static AppButton disabled({
    Key? key,
    required String text,
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      type: AppButtonType.elevated,
      size: size,
      state: AppButtonState.disabled,
      fullWidth: fullWidth,
      icon: icon,
    );
  }

  // Small button
  static AppButton small({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonType type = AppButtonType.elevated,
    AppButtonState state = AppButtonState.enabled,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: type,
      size: AppButtonSize.small,
      state: state,
      icon: icon,
    );
  }

  // Large button
  static AppButton large({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonType type = AppButtonType.elevated,
    AppButtonState state = AppButtonState.enabled,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      type: type,
      size: AppButtonSize.large,
      state: state,
      fullWidth: fullWidth,
      icon: icon,
    );
  }
} 