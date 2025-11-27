import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalmanagement/core/utils/extensions/localization_extension.dart';
import 'package:rentalmanagement/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rentalmanagement/core/widgets/buttons/custom_button.dart';
import 'package:rentalmanagement/core/widgets/custom_textfield.dart';
import 'package:rentalmanagement/core/widgets/logo/app_logo_widget.dart';

import '../../../core/navigation/app_route.dart';
import '../../../core/widgets/custom_loader_widget.dart';
import '../controllers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneController = TextEditingController();

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    super.dispose();
  }

  final bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final forgetPassword = ref.watch(forgetPasswordStateProvider);
    return Scaffold(
      appBar: AppBarWidget(title: context.l10n.recoverPasswordTitle),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(60.h),
                  AppLogoWidget(width: 220),

                  Gap(24.h),
                  Text(
                    context.l10n.resetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gap(8.h),
                  Text(
                    context.l10n.resetPasswordDescription,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Gap(24.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.l10n.phoneNumberOrEmailHeading,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff24262D),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Gap(4.h),
                  CustomTextFieldWithHeading(
                    textFieldName: 'contact',
                    hintText: context.l10n.passwordHint,

                    controller: emailOrPhoneController,
                  ),

                  Gap(24.h),
                  ref.watch(forgetPasswordStateProvider)
                      ? const CustomLoaderWidget()
                      : CustomButton(
                          text: context.l10n.submitButton,
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              await ref
                                  .read(forgetPasswordStateProvider.notifier)
                                  .forgetPassword(
                                    contact: emailOrPhoneController.text,
                                  )
                                  .then((response) {
                                    if (response.isSuccess) {
                                      if (context.mounted) {
                                        context.go(
                                          Routes.createpass,
                                          extra: emailOrPhoneController.text,
                                        );
                                      }
                                    }
                                  });
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
