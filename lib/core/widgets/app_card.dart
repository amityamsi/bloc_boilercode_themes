import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppCardType {
  elevated,
  outlined,
  filled,
  flat,
}

enum AppCardPadding {
  none,
  small,
  medium,
  large,
  extraLarge,
}

class AppCard extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? actions;
  final AppCardType type;
  final AppCardPadding padding;
  final double? width;
  final double? height;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showDivider;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool enableRipple;
  final Clip clipBehavior;

  const AppCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.actions,
    this.type = AppCardType.elevated,
    this.padding = AppCardPadding.medium,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.elevation = 2,
    this.backgroundColor,
    this.borderColor,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.showDivider = false,
    this.isLoading = false,
    this.loadingWidget,
    this.enableRipple = true,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = _buildCardContent();

    if (onTap != null || onLongPress != null) {
      cardContent = InkWell(
        onTap: isLoading ? null : onTap,
        onLongPress: isLoading ? null : onLongPress,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      );
    }

    Widget card = Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8),
      child: cardContent,
    );

    switch (type) {
      case AppCardType.elevated:
        return Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: backgroundColor ?? AppColors.cardBackground,
          clipBehavior: clipBehavior,
          child: card,
        );
      case AppCardType.outlined:
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor ?? AppColors.border,
              width: 1,
            ),
          ),
          color: backgroundColor ?? AppColors.cardBackground,
          clipBehavior: clipBehavior,
          child: card,
        );
      case AppCardType.filled:
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: backgroundColor ?? AppColors.inputBackground,
          clipBehavior: clipBehavior,
          child: card,
        );
      case AppCardType.flat:
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.cardBackground,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          clipBehavior: clipBehavior,
          child: card,
        );
    }
  }

  Widget _buildCardContent() {
    if (isLoading) {
      return _buildLoadingContent();
    }

    if (title != null || leading != null || trailing != null) {
      return _buildHeaderCard();
    }

    return _buildSimpleCard();
  }

  Widget _buildLoadingContent() {
    return Container(
      padding: _getPadding(),
      child: loadingWidget ?? const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: _getPadding(),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) title!,
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      subtitle!,
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
        // Divider
        if (showDivider) ...[
          Divider(
            color: AppColors.divider,
            height: 1,
            indent: _getPadding().left,
            endIndent: _getPadding().right,
          ),
        ],
        // Content
        if (child != null) ...[
          Padding(
            padding: _getPadding(),
            child: child!,
          ),
        ],
        // Actions
        if (actions != null && actions!.isNotEmpty) ...[
          if (showDivider) ...[
            Divider(
              color: AppColors.divider,
              height: 1,
              indent: _getPadding().left,
              endIndent: _getPadding().right,
            ),
          ],
          Padding(
            padding: _getPadding(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions!
                  .map((action) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: action,
                      ))
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSimpleCard() {
    return Padding(
      padding: _getPadding(),
      child: child,
    );
  }

  EdgeInsets _getPadding() {
    switch (padding) {
      case AppCardPadding.none:
        return EdgeInsets.zero;
      case AppCardPadding.small:
        return const EdgeInsets.all(8);
      case AppCardPadding.medium:
        return const EdgeInsets.all(16);
      case AppCardPadding.large:
        return const EdgeInsets.all(24);
      case AppCardPadding.extraLarge:
        return const EdgeInsets.all(32);
    }
  }
}

// Predefined card styles
class AppCards {
  // Basic card
  static AppCard basic({
    Key? key,
    required Widget child,
    AppCardPadding padding = AppCardPadding.medium,
    double borderRadius = 12,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      padding: padding,
      borderRadius: borderRadius,
      onTap: onTap,
      child: child,
    );
  }

  // Info card
  static AppCard info({
    Key? key,
    required String title,
    required String message,
    IconData? icon,
    List<Widget>? actions,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      type: AppCardType.filled,
      backgroundColor: AppColors.info.withOpacity(0.1),
      borderColor: AppColors.info,
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.info, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.info,
              ),
            ),
          ),
        ],
      ),
      actions: actions,
      onTap: onTap,
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.info,
        ),
      ),
    );
  }

  // Success card
  static AppCard success({
    Key? key,
    required String title,
    required String message,
    IconData? icon,
    List<Widget>? actions,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      type: AppCardType.filled,
      backgroundColor: AppColors.success.withOpacity(0.1),
      borderColor: AppColors.success,
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.success, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
      actions: actions,
      onTap: onTap,
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.success,
        ),
      ),
    );
  }

  // Warning card
  static AppCard warning({
    Key? key,
    required String title,
    required String message,
    IconData? icon,
    List<Widget>? actions,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      type: AppCardType.filled,
      backgroundColor: AppColors.warning.withOpacity(0.1),
      borderColor: AppColors.warning,
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.warning, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
      actions: actions,
      onTap: onTap,
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.warning,
        ),
      ),
    );
  }

  // Error card
  static AppCard error({
    Key? key,
    required String title,
    required String message,
    IconData? icon,
    List<Widget>? actions,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      type: AppCardType.filled,
      backgroundColor: AppColors.error.withOpacity(0.1),
      borderColor: AppColors.error,
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.error, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
      actions: actions,
      onTap: onTap,
      child: Text(
        message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.error,
        ),
      ),
    );
  }

  // Profile card
  static AppCard profile({
    Key? key,
    required String name,
    required String subtitle,
    String? avatarUrl,
    IconData? avatarIcon,
    List<Widget>? actions,
    VoidCallback? onTap,
  }) {
    return AppCard(
      key: key,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.primary,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
        child: avatarUrl == null
            ? Icon(
                avatarIcon ?? Icons.person,
                color: Colors.white,
                size: 24,
              )
            : null,
      ),
      title: Text(
        name,
        style: AppTextStyles.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      actions: actions,
      onTap: onTap,
    );
  }

  // Stats card
  static AppCard stats({
    Key? key,
    required String title,
    required String value,
    required IconData icon,
    Color? color,
    VoidCallback? onTap,
  }) {
    final cardColor = color ?? AppColors.primary;
    return AppCard(
      key: key,
      type: AppCardType.filled,
      backgroundColor: cardColor.withOpacity(0.1),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: cardColor,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: cardColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Loading card
  static AppCard loading({
    Key? key,
    String? message,
    Widget? loadingWidget,
  }) {
    return AppCard(
      key: key,
      isLoading: true,
      loadingWidget: loadingWidget,
      child: message != null
          ? Text(
              message,
              style: AppTextStyles.bodyMedium,
            )
          : null,
    );
  }
} 