import 'package:flutter/material.dart';
import '../blocs/language/language_bloc.dart';

class RTLUtils {
  // Get text direction based on language state
  static TextDirection getTextDirection(LanguageState languageState) {
    if (languageState is LanguageLoaded) {
      return languageState.getTextDirection();
    }
    return TextDirection.ltr;
  }

  // Get alignment based on language state
  static Alignment getAlignment(LanguageState languageState) {
    if (languageState is LanguageLoaded) {
      return languageState.getAlignment();
    }
    return Alignment.centerLeft;
  }

  // Get cross alignment based on language state
  static CrossAxisAlignment getCrossAxisAlignment(LanguageState languageState) {
    if (languageState is LanguageLoaded) {
      return languageState.getCrossAxisAlignment();
    }
    return CrossAxisAlignment.start;
  }

  // Get main alignment based on language state
  static MainAxisAlignment getMainAxisAlignment(LanguageState languageState) {
    if (languageState is LanguageLoaded) {
      return languageState.getMainAxisAlignment();
    }
    return MainAxisAlignment.start;
  }

  // Check if current language is RTL
  static bool isRTL(LanguageState languageState) {
    if (languageState is LanguageLoaded) {
      return languageState.isRTL();
    }
    return false;
  }

  // Get padding based on RTL direction
  static EdgeInsets getPadding({
    required LanguageState languageState,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) {
    if (isRTL(languageState)) {
      return EdgeInsets.only(
        left: right,
        right: left,
        top: top,
        bottom: bottom,
      );
    }
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }

  // Get margin based on RTL direction
  static EdgeInsets getMargin({
    required LanguageState languageState,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) {
    if (isRTL(languageState)) {
      return EdgeInsets.only(
        left: right,
        right: left,
        top: top,
        bottom: bottom,
      );
    }
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }

  // Get border radius based on RTL direction
  static BorderRadius getBorderRadius({
    required LanguageState languageState,
    double topLeft = 0.0,
    double topRight = 0.0,
    double bottomLeft = 0.0,
    double bottomRight = 0.0,
  }) {
    if (isRTL(languageState)) {
      return BorderRadius.only(
        topLeft: Radius.circular(topRight),
        topRight: Radius.circular(topLeft),
        bottomLeft: Radius.circular(bottomRight),
        bottomRight: Radius.circular(bottomLeft),
      );
    }
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }

  // Get icon based on RTL direction
  static IconData getIcon({
    required LanguageState languageState,
    required IconData ltrIcon,
    required IconData rtlIcon,
  }) {
    return isRTL(languageState) ? rtlIcon : ltrIcon;
  }

  // Get text alignment based on RTL direction
  static TextAlign getTextAlign(LanguageState languageState) {
    return isRTL(languageState) ? TextAlign.right : TextAlign.left;
  }

  // Get list of RTL languages
  static List<String> getRTLanguages() {
    return ['ar', 'he', 'fa', 'ur'];
  }

  // Check if a specific language code is RTL
  static bool isRTLanguage(String languageCode) {
    return getRTLanguages().contains(languageCode);
  }
}

// RTL-aware widgets
class RTLWidgets {
  // RTL-aware container
  static Widget container({
    required LanguageState languageState,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    Color? color,
    BoxBorder? border,
  }) {
    return Container(
      padding: padding != null ? RTLUtils.getPadding(
        languageState: languageState,
        left: padding.left,
        right: padding.right,
        top: padding.top,
        bottom: padding.bottom,
      ) : null,
      margin: margin != null ? RTLUtils.getMargin(
        languageState: languageState,
        left: margin.left,
        right: margin.right,
        top: margin.top,
        bottom: margin.bottom,
      ) : null,
      decoration: BoxDecoration(
        borderRadius: borderRadius != null ? RTLUtils.getBorderRadius(
          languageState: languageState,
          topLeft: borderRadius.topLeft.x,
          topRight: borderRadius.topRight.x,
          bottomLeft: borderRadius.bottomLeft.x,
          bottomRight: borderRadius.bottomRight.x,
        ) : null,
        color: color,
        border: border,
      ),
      child: child,
    );
  }

  // RTL-aware row
  static Widget row({
    required LanguageState languageState,
    required List<Widget> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? RTLUtils.getMainAxisAlignment(languageState),
      crossAxisAlignment: crossAxisAlignment ?? RTLUtils.getCrossAxisAlignment(languageState),
      mainAxisSize: mainAxisSize,
      children: RTLUtils.isRTL(languageState) ? children.reversed.toList() : children,
    );
  }

  // RTL-aware column
  static Widget column({
    required LanguageState languageState,
    required List<Widget> children,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? RTLUtils.getCrossAxisAlignment(languageState),
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }

  // RTL-aware text
  static Widget text({
    required LanguageState languageState,
    required String text,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style: style,
      textAlign: textAlign ?? RTLUtils.getTextAlign(languageState),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  // RTL-aware icon
  static Widget icon({
    required LanguageState languageState,
    required IconData ltrIcon,
    required IconData rtlIcon,
    double? size,
    Color? color,
  }) {
    return Icon(
      RTLUtils.getIcon(
        languageState: languageState,
        ltrIcon: ltrIcon,
        rtlIcon: rtlIcon,
      ),
      size: size,
      color: color,
    );
  }
} 