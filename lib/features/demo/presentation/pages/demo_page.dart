import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/blocs/theme/theme_bloc.dart';
import '../../../../core/routes/app_router.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Page'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded ? themeState.isDarkMode : false;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                AppCard(
                  backgroundColor: AppColors.getCardBackgroundColor(isDarkMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Demo Page',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.getTextPrimaryColor(isDarkMode),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This page demonstrates the custom widgets and features of the Flutter Bloc Boilerplate.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // AppUtils Examples Section
                AppCard(
                  backgroundColor: AppColors.getCardBackgroundColor(isDarkMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AppUtils Examples',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.getTextPrimaryColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // AppUtils Buttons
                                             Wrap(
                         spacing: 8,
                         runSpacing: 8,
                         children: [
                           ElevatedButton(
                             onPressed: () => AppUtils.showSuccess(context, 'Success message!'),
                             child: const Text('Show Success'),
                           ),
                           ElevatedButton(
                             onPressed: () => AppUtils.showError(context, 'Error message!'),
                             child: const Text('Show Error'),
                           ),
                           ElevatedButton(
                             onPressed: () => AppUtils.showWarning(context, 'Warning message!'),
                             child: const Text('Show Warning'),
                           ),
                           ElevatedButton(
                             onPressed: () => AppUtils.showInfo(context, 'Info message!'),
                             child: const Text('Show Info'),
                           ),
                         ],
                       ),
                      const SizedBox(height: 12),
                      
                                             Wrap(
                         spacing: 8,
                         runSpacing: 8,
                         children: [
                           ElevatedButton(
                             onPressed: () async {
                               final confirmed = await AppUtils.showConfirmation(
                                 context: context,
                                 title: 'Confirm Action',
                                 message: 'Are you sure you want to proceed?',
                               );
                               if (confirmed) {
                                 AppUtils.showSuccess(context, 'Action confirmed!');
                               }
                             },
                             child: const Text('Show Confirmation'),
                           ),
                                                        ElevatedButton(
                               onPressed: () {
                                 AppUtils.showInfoDialog(
                                   context: context,
                                   title: 'Information',
                                   message: 'This is an alert dialog.',
                                 );
                               },
                               child: const Text('Show Alert'),
                             ),
                           ElevatedButton(
                             onPressed: () async {
                               // Note: showInputDialog is not implemented in the current AppUtils
                               // You can implement it if needed
                               AppUtils.showInfo(context, 'Input dialog not implemented yet');
                             },
                             child: const Text('Show Input Dialog'),
                           ),
                         ],
                       ),
                      const SizedBox(height: 12),
                      
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                                                     ElevatedButton(
                             onPressed: () {
                               AppUtils.copyToClipboard(context, 'Copied text from demo!');
                             },
                             child: const Text('Copy to Clipboard'),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               AppUtils.showLoading(context, message: 'Processing...');
                               Future.delayed(const Duration(seconds: 2), () {
                                 AppUtils.hideLoading(context);
                                 AppUtils.showSuccess(context, 'Processing completed!');
                               });
                             },
                             child: const Text('Show Loading'),
                           ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Buttons Section
                AppCard(
                  backgroundColor: AppColors.getCardBackgroundColor(isDarkMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Button Examples',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.getTextPrimaryColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                                             // Primary Button
                       AppButton(
                         onPressed: () {
                           AppUtils.showSuccess(context, 'Primary button pressed!');
                         },
                         text: 'Primary Button',
                         fullWidth: true,
                       ),
                       const SizedBox(height: 12),
                       
                       // Secondary Button
                       AppButton(
                         onPressed: () {
                           AppUtils.showSuccess(context, 'Secondary button pressed!');
                         },
                         text: 'Secondary Button',
                         type: AppButtonType.outlined,
                         backgroundColor: AppColors.getSecondaryColor(isDarkMode),
                         fullWidth: true,
                       ),
                       const SizedBox(height: 12),
                       
                       // Outline Button
                       AppButton(
                         onPressed: () {
                           AppUtils.showSuccess(context, 'Outline button pressed!');
                         },
                         text: 'Outline Button',
                         type: AppButtonType.outlined,
                         borderColor: AppColors.getInfo(isDarkMode),
                         foregroundColor: AppColors.getInfo(isDarkMode),
                         fullWidth: true,
                       ),
                       const SizedBox(height: 12),
                       
                       // Loading Button
                       AppButton(
                         onPressed: () async {
                           // Simulate loading
                           await Future.delayed(const Duration(seconds: 2));
                           if (context.mounted) {
                             AppUtils.showSuccess(context, 'Loading completed!');
                           }
                         },
                         text: 'Loading Button',
                         backgroundColor: AppColors.getSuccess(isDarkMode),
                         fullWidth: true,
                       ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Cards Section
                AppCard(
                  backgroundColor: AppColors.getCardBackgroundColor(isDarkMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Examples',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.getTextPrimaryColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Info Card
                      AppCard(
                        backgroundColor: AppColors.getInfo(isDarkMode).withOpacity(0.1),
                        borderColor: AppColors.getInfo(isDarkMode),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.getInfo(isDarkMode),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'This is an info card with custom styling.',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.getTextPrimaryColor(isDarkMode),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Success Card
                      AppCard(
                        backgroundColor: AppColors.getSuccess(isDarkMode).withOpacity(0.1),
                        borderColor: AppColors.getSuccess(isDarkMode),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: AppColors.getSuccess(isDarkMode),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'This is a success card with custom styling.',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.getTextPrimaryColor(isDarkMode),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Warning Card
                      AppCard(
                        backgroundColor: AppColors.getWarning(isDarkMode).withOpacity(0.1),
                        borderColor: AppColors.getWarning(isDarkMode),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_outlined,
                                color: AppColors.getWarning(isDarkMode),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'This is a warning card with custom styling.',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.getTextPrimaryColor(isDarkMode),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Navigation Section
                AppCard(
                  backgroundColor: AppColors.getCardBackgroundColor(isDarkMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Navigation Examples',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.getTextPrimaryColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AppButton(
                            onPressed: () => AppNavigation.goToLogin(context),
                            text: 'Go to Login',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToSignup(context),
                            text: 'Go to Signup',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToForgotPassword(context),
                            text: 'Go to Forgot Password',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToRTLDemo(context),
                            text: 'Go to RTL Demo',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AppButton(
                            onPressed: () => AppNavigation.goToProfile(context, 'user123'),
                            text: 'User Profile',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToProductDetail(context, 'prod456'),
                            text: 'Product Detail',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToCategory(context, 'cat789'),
                            text: 'Category',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AppButton(
                            onPressed: () => AppNavigation.goToProfileWithEdit(context, 'user123'),
                            text: 'Profile (Edit Mode)',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToProductDetailWithCategory(context, 'prod456', 'cat789'),
                            text: 'Product with Category',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                          AppButton(
                            onPressed: () => AppNavigation.goToUserDetailWithTab(context, 'user123', 'posts'),
                            text: 'User with Tab',
                            type: AppButtonType.outlined,
                            fullWidth: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
} 