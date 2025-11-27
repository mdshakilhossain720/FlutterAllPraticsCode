import 'package:flutter/gestures.dart';
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
import 'package:rentalmanagement/core/navigation/app_route.dart';
import 'package:rentalmanagement/core/utils/extensions/localization_extension.dart';
import 'package:rentalmanagement/core/utils/global_function.dart';
import 'package:rentalmanagement/core/utils/theme_extension.dart';
import 'package:rentalmanagement/core/utils/url_launcher.dart';
import 'package:rentalmanagement/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rentalmanagement/core/widgets/buttons/custom_button.dart';
import 'package:rentalmanagement/core/widgets/custom_loader_widget.dart';
import 'package:rentalmanagement/core/widgets/custom_textfield.dart';
import 'package:rentalmanagement/core/widgets/logo/app_logo_widget.dart';
import 'package:rentalmanagement/features/auth/controllers/auth_provider.dart';
import 'package:rentalmanagement/features/auth/models/sign_up_model.dart';

import 'widgets/alreadyaccountwidgets.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  bool _isPasswordVisible = false;
  bool isCheckTerm = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: context.l10n.signUpTitle),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(16.h),
                AppLogoWidget(width: 220),

                Gap(24.h),
                Text(
                  context.l10n.createAccountTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Gap(8.h),
                Text(
                  context.l10n.joinPlatformDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Gap(24.h),

                CustomTextFieldWithHeading(
                  textFieldName: 'name',
                  hintText: context.l10n.nameHint,
                  heading: context.l10n.nameHeading,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                  ]),
                  textInputAction: TextInputAction.next,
                ),
                Gap(10.h),

                CustomTextFieldWithHeading(
                  textFieldName: 'email',
                  heading: context.l10n.emailHeading,
                  hintText: context.l10n.emailHint,
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                    FormBuilderValidators.email(),
                  ]),
                ),
                Gap(10.h),

                CustomTextFieldWithHeading(
                  textFieldName: 'phone',
                  heading: context.l10n.phoneHeading,
                  hintText: context.l10n.phoneHint,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                    FormBuilderValidators.phoneNumber(),
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
                  textInputAction: TextInputAction.done,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                    FormBuilderValidators.minLength(
                      8,
                      errorText: context.l10n.passwordMinLengthError,
                    ),
                  ]),
                ),

                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.5.w,
                      height: 20.5.w,
                      child: Checkbox(
                        value: isCheckTerm,
                        onChanged: (val) {
                          setState(() {
                            isCheckTerm = val!;
                          });
                        },

                        activeColor: AppColors.primaryColor,
                        side: BorderSide(
                          color: AppColors.gray.withValues(alpha: 0.5),
                          width: 2.w,
                        ),
                        shape: CircleBorder(), // makes it round
                      ),
                    ),
                    Gap(10.w),
                    RichText(
                      text: TextSpan(
                        style: context.textTheme.bodySmall,
                        children: [
                          TextSpan(text: context.l10n.agreeToPrefix),
                          TextSpan(
                            text: context.l10n.termsOfUseLink,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                customLaunchUrl(
                                  AppConstants.termsAndConditions,
                                );
                              },
                          ),
                          TextSpan(text: context.l10n.andSuffix),
                          TextSpan(
                            text: context.l10n.privacyPolicyLink,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                customLaunchUrl(AppConstants.privacyPolicy);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Gap(24.h),
                ref.watch(registrationStateProvider)
                    ? const CustomLoaderWidget()
                    : CustomButton(
                        text: context.l10n.createAccountButton,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formkey.currentState!.validate()) {
                            if (!isCheckTerm) {
                              GlobalFunction.showCustomSnackbar(
                                message:
                                    context.l10n.termsAgreementRequiredMessage,
                                isSuccess: false,
                              );
                              return;
                            }
                            final signupModel = SignUpModel(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              phone: _phoneController.text.trim(),
                              password: _passwordController.text,
                            );
                            ref
                                .read(registrationStateProvider.notifier)
                                .registration(signupModel)
                                .then((response) {
                                  if (response.isSuccess) {
                                    GlobalFunction.showCustomSnackbar(
                                      message: response.message,
                                      isSuccess: true,
                                    );
                                    context.go(Routes.login);
                                  }
                                });
                          }
                        },
                      ),
                Gap(16.h),
                AlreadyHaveAccountWidget(
                  title: context.l10n.alreadyHaveAccountPrefix,
                  subtitle: context.l10n.signInLink,
                  onTap: () {
                    context.go(Routes.login);
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
