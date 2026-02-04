import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppTextFieldType {
  text,
  email,
  password,
  number,
  phone,
  multiline,
  search,
  url,
  date,
  time,
}

enum AppTextFieldDesign {
  outlined,
  filled,
  underlined,
  rounded,
}

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final AppTextFieldType type;
  final AppTextFieldDesign design;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool showCounter;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool autofocus;
  final bool expands;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? errorColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final TextStyle? counterStyle;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final bool showCursor;
  final bool enableInteractiveSelection;
  final bool enableIMEPersonalizedLearning;
  final ScrollPhysics? scrollPhysics;
  final bool autovalidateMode;
  final bool isDense;
  final bool filled;
  final bool alignLabelWithHint;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final UndoHistoryController? undoController;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableTapToRetry;
  final bool enableDragSelection;
  final TextSelectionControls? selectionControls;
  final BuildContext? contextMenuBuilder;
  final bool canUsePrimaryPaste;
  final MouseCursor? mouseCursor;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final Clip clipBehavior;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.type = AppTextFieldType.text,
    this.design = AppTextFieldDesign.outlined,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.inputFormatters,
    this.validator,
    this.autofocus = false,
    this.expands = false,
    this.width,
    this.height,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.labelColor,
    this.hintColor,
    this.errorColor,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.counterStyle,
    this.prefixStyle,
    this.suffixStyle,
    this.showCursor = true,
    this.enableInteractiveSelection = true,
    this.enableIMEPersonalizedLearning = true,
    this.scrollPhysics,
    this.autovalidateMode = false,
    this.isDense = false,
    this.filled = false,
    this.alignLabelWithHint = false,
    this.floatingLabelBehavior,
    this.restorationId,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableTapToRetry = false,
    this.enableDragSelection = true,
    this.selectionControls,
    this.contextMenuBuilder,
    this.canUsePrimaryPaste = true,
    this.mouseCursor,
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _buildTextField(),
    );
  }

  Widget _buildTextField() {
    final textFieldType = _getTextFieldType();
    final design = _getDesign();

    switch (design) {
      case AppTextFieldDesign.outlined:
        return _buildOutlinedTextField(textFieldType);
      case AppTextFieldDesign.filled:
        return _buildFilledTextField(textFieldType);
      case AppTextFieldDesign.underlined:
        return _buildUnderlinedTextField(textFieldType);
      case AppTextFieldDesign.rounded:
        return _buildRoundedTextField(textFieldType);
    }
  }

  Widget _buildOutlinedTextField(TextInputType textFieldType) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: textFieldType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.maxLength,
      showCursor: widget.showCursor,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      scrollPhysics: widget.scrollPhysics,
      autofocus: widget.autofocus,
      expands: widget.expands,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        counterText: widget.showCounter ? null : '',
        prefix: widget.prefix,
        suffix: _buildSuffix(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        contentPadding: widget.contentPadding ?? _getContentPadding(),
        border: widget.border ?? _getOutlinedBorder(),
        enabledBorder: widget.enabledBorder ?? _getOutlinedBorder(),
        focusedBorder: widget.focusedBorder ?? _getFocusedOutlinedBorder(),
        errorBorder: widget.errorBorder ?? _getErrorOutlinedBorder(),
        focusedErrorBorder: widget.focusedErrorBorder ?? _getFocusedErrorOutlinedBorder(),
        fillColor: widget.fillColor,
        filled: widget.filled,
        labelStyle: widget.labelStyle ?? _getLabelStyle(),
        hintStyle: widget.hintStyle ?? _getHintStyle(),
        errorStyle: widget.errorStyle ?? _getErrorStyle(),
        helperStyle: widget.helperStyle ?? _getHelperStyle(),
        counterStyle: widget.counterStyle ?? _getCounterStyle(),
        prefixStyle: widget.prefixStyle ?? _getPrefixStyle(),
        suffixStyle: widget.suffixStyle ?? _getSuffixStyle(),
        isDense: widget.isDense,
        alignLabelWithHint: widget.alignLabelWithHint,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        
      ),
    );
  }

  Widget _buildFilledTextField(TextInputType textFieldType) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: textFieldType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      showCursor: widget.showCursor,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      scrollPhysics: widget.scrollPhysics,
      autofocus: widget.autofocus,
      expands: widget.expands,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        counterText: widget.showCounter ? null : '',
        prefix: widget.prefix,
        suffix: _buildSuffix(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        contentPadding: widget.contentPadding ?? _getContentPadding(),
        border: widget.border ?? _getFilledBorder(),
        enabledBorder: widget.enabledBorder ?? _getFilledBorder(),
        focusedBorder: widget.focusedBorder ?? _getFocusedFilledBorder(),
        errorBorder: widget.errorBorder ?? _getErrorFilledBorder(),
        focusedErrorBorder: widget.focusedErrorBorder ?? _getFocusedErrorFilledBorder(),
        fillColor: widget.fillColor ?? AppColors.inputBackground,
        filled: true,
        labelStyle: widget.labelStyle ?? _getLabelStyle(),
        hintStyle: widget.hintStyle ?? _getHintStyle(),
        errorStyle: widget.errorStyle ?? _getErrorStyle(),
        helperStyle: widget.helperStyle ?? _getHelperStyle(),
        counterStyle: widget.counterStyle ?? _getCounterStyle(),
        prefixStyle: widget.prefixStyle ?? _getPrefixStyle(),
        suffixStyle: widget.suffixStyle ?? _getSuffixStyle(),
        isDense: widget.isDense,
        alignLabelWithHint: widget.alignLabelWithHint,
        floatingLabelBehavior: widget.floatingLabelBehavior,
      ),
    );
  }

  Widget _buildUnderlinedTextField(TextInputType textFieldType) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: textFieldType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      showCursor: widget.showCursor,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      scrollPhysics: widget.scrollPhysics,
      autofocus: widget.autofocus,
      expands: widget.expands,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        counterText: widget.showCounter ? null : '',
        prefix: widget.prefix,
        suffix: _buildSuffix(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        contentPadding: widget.contentPadding ?? _getContentPadding(),
        border: widget.border ?? _getUnderlinedBorder(),
        enabledBorder: widget.enabledBorder ?? _getUnderlinedBorder(),
        focusedBorder: widget.focusedBorder ?? _getFocusedUnderlinedBorder(),
        errorBorder: widget.errorBorder ?? _getErrorUnderlinedBorder(),
        focusedErrorBorder: widget.focusedErrorBorder ?? _getFocusedErrorUnderlinedBorder(),
        fillColor: widget.fillColor,
        filled: widget.filled,
        labelStyle: widget.labelStyle ?? _getLabelStyle(),
        hintStyle: widget.hintStyle ?? _getHintStyle(),
        errorStyle: widget.errorStyle ?? _getErrorStyle(),
        helperStyle: widget.helperStyle ?? _getHelperStyle(),
        counterStyle: widget.counterStyle ?? _getCounterStyle(),
        prefixStyle: widget.prefixStyle ?? _getPrefixStyle(),
        suffixStyle: widget.suffixStyle ?? _getSuffixStyle(),
        isDense: widget.isDense,
        alignLabelWithHint: widget.alignLabelWithHint,
        floatingLabelBehavior: widget.floatingLabelBehavior,
      ),
    );
  }

  Widget _buildRoundedTextField(TextInputType textFieldType) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: textFieldType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      showCursor: widget.showCursor,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      scrollPhysics: widget.scrollPhysics,
      autofocus: widget.autofocus,
      expands: widget.expands,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        counterText: widget.showCounter ? null : '',
        prefix: widget.prefix,
        suffix: _buildSuffix(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        contentPadding: widget.contentPadding ?? _getContentPadding(),
        border: widget.border ?? _getRoundedBorder(),
        enabledBorder: widget.enabledBorder ?? _getRoundedBorder(),
        focusedBorder: widget.focusedBorder ?? _getFocusedRoundedBorder(),
        errorBorder: widget.errorBorder ?? _getErrorRoundedBorder(),
        focusedErrorBorder: widget.focusedErrorBorder ?? _getFocusedErrorRoundedBorder(),
        fillColor: widget.fillColor ?? AppColors.inputBackground,
        filled: true,
        labelStyle: widget.labelStyle ?? _getLabelStyle(),
        hintStyle: widget.hintStyle ?? _getHintStyle(),
        errorStyle: widget.errorStyle ?? _getErrorStyle(),
        helperStyle: widget.helperStyle ?? _getHelperStyle(),
        counterStyle: widget.counterStyle ?? _getCounterStyle(),
        prefixStyle: widget.prefixStyle ?? _getPrefixStyle(),
        suffixStyle: widget.suffixStyle ?? _getSuffixStyle(),
        isDense: widget.isDense,
        alignLabelWithHint: widget.alignLabelWithHint,
        floatingLabelBehavior: widget.floatingLabelBehavior,
      ),
    );
  }

  Widget? _buildSuffix() {
    if (widget.type == AppTextFieldType.password) {
      return InkWell(
        
        child: Icon(
          !_obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.textSecondary,
          size: 24,
        ),
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffix;
  }

  TextInputType _getTextFieldType() {
    if (widget.keyboardType != null) return widget.keyboardType!;
    
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.password:
        return TextInputType.visiblePassword;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.search:
        return TextInputType.text;
      case AppTextFieldType.url:
        return TextInputType.url;
      case AppTextFieldType.date:
        return TextInputType.datetime;
      case AppTextFieldType.time:
        return TextInputType.datetime;
      case AppTextFieldType.text:
        return TextInputType.text;
    }
  }

  AppTextFieldDesign _getDesign() {
    return widget.design;
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (widget.design) {
      case AppTextFieldDesign.outlined:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
      case AppTextFieldDesign.filled:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
      case AppTextFieldDesign.underlined:
        return const EdgeInsets.symmetric(horizontal: 0, vertical: 16);
      case AppTextFieldDesign.rounded:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }

  // Border styles
  InputBorder _getOutlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.border),
    );
  }

  InputBorder _getFocusedOutlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    );
  }

  InputBorder _getErrorOutlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.error),
    );
  }

  InputBorder _getFocusedErrorOutlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    );
  }

  InputBorder _getFilledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }

  InputBorder _getFocusedFilledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    );
  }

  InputBorder _getErrorFilledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.error),
    );
  }

  InputBorder _getFocusedErrorFilledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    );
  }

  InputBorder _getUnderlinedBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
    );
  }

  InputBorder _getFocusedUnderlinedBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    );
  }

  InputBorder _getErrorUnderlinedBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
    );
  }

  InputBorder _getFocusedErrorUnderlinedBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.error, width: 2),
    );
  }

  InputBorder _getRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    );
  }

  InputBorder _getFocusedRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    );
  }

  InputBorder _getErrorRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.error),
    );
  }

  InputBorder _getFocusedErrorRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    );
  }

  // Text styles
  TextStyle _getLabelStyle() {
    return AppTextStyles.bodyMedium.copyWith(
      color: widget.labelColor ?? AppColors.textPrimary,
    );
  }

  TextStyle _getHintStyle() {
    return AppTextStyles.bodyMedium.copyWith(
      color: widget.hintColor ?? AppColors.textSecondary,
    );
  }

  TextStyle _getErrorStyle() {
    return AppTextStyles.bodySmall.copyWith(
      color: widget.errorColor ?? AppColors.error,
    );
  }

  TextStyle _getHelperStyle() {
    return AppTextStyles.bodySmall.copyWith(
      color: AppColors.textSecondary,
    );
  }

  TextStyle _getCounterStyle() {
    return AppTextStyles.bodySmall.copyWith(
      color: AppColors.textSecondary,
    );
  }

  TextStyle _getPrefixStyle() {
    return AppTextStyles.bodyMedium.copyWith(
      color: AppColors.textSecondary,
    );
  }

  TextStyle _getSuffixStyle() {
    return AppTextStyles.bodyMedium.copyWith(
      color: AppColors.textSecondary,
    );
  }
}

// Predefined text field styles
class AppTextFields {
  // Basic text field
  static AppTextField basic({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      label: label,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      design: design,
    );
  }

  // Email field
  static AppTextField email({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Email',
      hint: hint ?? 'Enter your email',
      controller: controller,
      onChanged: onChanged,
      validator: validator ?? _emailValidator,
      design: design,
      type: AppTextFieldType.email,
      prefixIcon: const Icon(Icons.email),
    );
  }

  // Password field
  static AppTextField password({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Password',
      hint: hint ?? 'Enter your password',
      controller: controller,
      onChanged: onChanged,
      validator: validator ?? _passwordValidator,
      design: design,
      type: AppTextFieldType.password,
      prefixIcon: const Icon(Icons.lock),
    );
  }

  // Search field
  static AppTextField search({
    Key? key,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      hint: hint ?? 'Search...',
      controller: controller,
      onChanged: onChanged,
      design: design,
      type: AppTextFieldType.search,
      prefixIcon: const Icon(Icons.search),
    );
  }

  // Phone field
  static AppTextField phone({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Phone',
      hint: hint ?? 'Enter your phone number',
      controller: controller,
      onChanged: onChanged,
      validator: validator ?? _phoneValidator,
      design: design,
      type: AppTextFieldType.phone,
      prefixIcon: const Icon(Icons.phone),
    );
  }

  // Number field
  static AppTextField number({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      label: label,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      design: design,
      type: AppTextFieldType.number,
    );
  }

  // Multiline field
  static AppTextField multiline({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
    int? maxLines,
    int? minLines,
  }) {
    return AppTextField(
      key: key,
      label: label,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      design: design,
      type: AppTextFieldType.multiline,
      maxLines: maxLines ?? 3,
      minLines: minLines ?? 3,
    );
  }

  // URL field
  static AppTextField url({
    Key? key,
    String? label,
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    AppTextFieldDesign design = AppTextFieldDesign.outlined,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'URL',
      hint: hint ?? 'Enter URL',
      controller: controller,
      onChanged: onChanged,
      validator: validator ?? _urlValidator,
      design: design,
      type: AppTextFieldType.url,
      prefixIcon: const Icon(Icons.link),
    );
  }

  // Validators
  static String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?[\d\s-]+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? _urlValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    if (!RegExp(r'^https?:\/\/.*').hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }
}   