import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/language/language_bloc.dart';
import '../../../../core/utils/rtl_utils.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_button.dart';

class RTLDemoPage extends StatelessWidget {
  const RTLDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTL Demo'),
        centerTitle: true,
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RTL Status Card
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RTL Status',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildStatusRow('Current Language', languageState is LanguageLoaded ? languageState.getCurrentLanguageName() : 'Loading...'),
                      _buildStatusRow('Text Direction', languageState is LanguageLoaded ? (languageState.isRTL() ? 'RTL' : 'LTR') : 'Loading...'),
                      _buildStatusRow('Is RTL', languageState is LanguageLoaded ? languageState.isRTL().toString() : 'Loading...'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // RTL Text Demo
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RTL Text Demo',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      RTLWidgets.text(
                        languageState: languageState,
                        text: 'This is a sample text that will be aligned based on the current language direction.',
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      RTLWidgets.text(
                        languageState: languageState,
                        text: 'Another example with different alignment',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // RTL Layout Demo
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RTL Layout Demo',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      RTLWidgets.row(
                        languageState: languageState,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Item 1', style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Item 2', style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Item 3', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // RTL Padding Demo
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RTL Padding Demo',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      RTLWidgets.container(
                        languageState: languageState,
                        padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        child: const Text('This container has asymmetric padding that will be flipped in RTL'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // RTL Icon Demo
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RTL Icon Demo',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      RTLWidgets.row(
                        languageState: languageState,
                        children: [
                          RTLWidgets.icon(
                            languageState: languageState,
                            ltrIcon: Icons.arrow_back,
                            rtlIcon: Icons.arrow_forward,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Back/Forward Navigation'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RTLWidgets.row(
                        languageState: languageState,
                        children: [
                          RTLWidgets.icon(
                            languageState: languageState,
                            ltrIcon: Icons.chevron_left,
                            rtlIcon: Icons.chevron_right,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Chevron Navigation'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Language Switcher
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Switch Language',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AppButton(
                            onPressed: () => context.read<LanguageBloc>().add(
                              const ChangeLanguage(languageCode: 'en', countryCode: 'US'),
                            ),
                            text: 'English',
                            type: AppButtonType.outlined,
                          ),
                          AppButton(
                            onPressed: () => context.read<LanguageBloc>().add(
                              const ChangeLanguage(languageCode: 'ar', countryCode: 'SA'),
                            ),
                            text: 'العربية',
                            type: AppButtonType.outlined,
                          ),
                          AppButton(
                            onPressed: () => context.read<LanguageBloc>().add(
                              const ChangeLanguage(languageCode: 'he', countryCode: 'IL'),
                            ),
                            text: 'עברית',
                            type: AppButtonType.outlined,
                          ),
                          AppButton(
                            onPressed: () => context.read<LanguageBloc>().add(
                              const ChangeLanguage(languageCode: 'fa', countryCode: 'IR'),
                            ),
                            text: 'فارسی',
                            type: AppButtonType.outlined,
                          ),
                          AppButton(
                            onPressed: () => context.read<LanguageBloc>().add(
                              const ChangeLanguage(languageCode: 'ur', countryCode: 'PK'),
                            ),
                            text: 'اردو',
                            type: AppButtonType.outlined,
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

  Widget _buildStatusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
} 