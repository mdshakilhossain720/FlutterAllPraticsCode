import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalmanagement/core/constants/app_colors.dart';
import 'package:rentalmanagement/core/constants/app_constants.dart';
import 'package:rentalmanagement/core/localization/app_languages.dart';
import 'package:rentalmanagement/core/localization/localization_provider.dart';
import 'package:rentalmanagement/core/navigation/app_route.dart';
import 'package:rentalmanagement/core/services/hive_service.dart';
import 'package:rentalmanagement/core/theme/theme_extensions.dart';
import 'package:rentalmanagement/core/utils/extensions/localization_extension.dart';
import 'package:rentalmanagement/core/widgets/buttons/custom_button.dart';
import 'package:rentalmanagement/core/widgets/custom_loader_widget.dart';
import 'package:rentalmanagement/core/widgets/custom_textfield.dart';
import 'package:rentalmanagement/core/widgets/logo/app_logo_widget.dart';
import 'package:rentalmanagement/features/auth/controllers/auth_provider.dart';

import 'widgets/alreadyaccountwidgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? selectedLanguage;

  bool _isPasswordVisible = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadSavedCredentials();
  }

  Future<void> _loadLanguage() async {
    final langCode = await ref.read(hiveServiceProvider).getSelectedLanguage();
    setState(() => selectedLanguage = langCode);
  }

  Future<void> _loadSavedCredentials() async {
    final data = await ref.read(hiveServiceProvider).getLoginCredentials();

    setState(() {
      _contactController.text = data['contact'] ?? '';
      _passwordController.text = data['password'] ?? '';
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // status bar height
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(20.h + statusBarHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.loginTitle,
                      // "Login",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 84.w,

                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.gray.withValues(alpha: 0.5)
                            : const Color(0xFFF6F7F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: selectedLanguage,

                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: SvgPicture.asset(
                          'assets/svgs/direction-down.svg',
                          height: 18.h,
                          width: 18.w,
                          fit: BoxFit.cover,
                        ),
                        items: AppLanguages.languages.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              AppLanguages.getLanguageLabel(value),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) async {
                          if (newValue == null) return;
                          setState(() => selectedLanguage = newValue);
                          await ref
                              .read(languageProvider.notifier)
                              .changeLanguage(newValue);
                        },
                      ),
                    ),
                  ],
                ),
                Gap(30.h),
                GestureDetector(
                  onTap: () {
                    // _contactController.text = 'tenant9@example.com';
                    // _passwordController.text = 'secret@123';
                  },
                  child: AppLogoWidget(width: 220),
                ),

                Gap(30.h),
                Text(
                  context.l10n.welcomeBack,
                  style: context.textTheme.headlineSmall,
                ),
                Gap(8.h),
                Text(
                  context.l10n.signInToAccount,
                  style: context.textTheme.bodySmall,
                ),
                Gap(24.h),

                CustomTextFieldWithHeading(
                  textFieldName: 'contact',
                  hintText: context.l10n.contactHint,
                  heading: context.l10n.phoneNumberOrEmailHeading,

                  controller: _contactController,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                  ]),
                ),
                Gap(10.h),

                CustomTextFieldWithHeading(
                  obscureText: !_isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset(
                        _isPasswordVisible
                            ? 'assets/svgs/eye.svg'
                            : 'assets/svgs/eye-disable.svg',
                        height: 20.sp,
                        width: 20.sp,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  textFieldName: 'password',
                  heading: context.l10n.passwordHeading,
                  hintText: context.l10n.passwordHint,

                  controller: _passwordController,

                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                  ]),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.push(Routes.forgotpass);
                    },
                    child: Text(
                      context.l10n.forgotPassword,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ),
                Gap(16.h),
                ref.watch(loginStateProvider)
                    ? const CustomLoaderWidget()
                    : CustomButton(
                        text: context.l10n.loginButton,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_formkey.currentState!.saveAndValidate()) {
                            await ref
                                .read(loginStateProvider.notifier)
                                .login(
                                  email: _contactController.text,
                                  password: _passwordController.text,
                                )
                                .then((response) {
                                  if (response.isSuccess) {
                                    if (context.mounted) {
                                      context.go(Routes.bottomNavbar);
                                    }
                                  }
                                });
                          }
                        },
                      ),
                Gap(16.h),
                AlreadyHaveAccountWidget(
                  title: context.l10n.dontHaveAccountPrefix,
                  subtitle: context.l10n.signUpLink,
                  onTap: () {
                    context.push(Routes.signup);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
