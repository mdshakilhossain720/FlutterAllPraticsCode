import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalmanagement/core/utils/global_function.dart';
import 'package:rentalmanagement/core/utils/validators.dart';
import 'package:rentalmanagement/core/widgets/buttons/custom_button.dart';
import 'package:rentalmanagement/core/widgets/custom_textfield.dart';

import '../../../core/navigation/app_route.dart';
import '../../../core/widgets/custom_loader_widget.dart';
import '../controllers/auth_provider.dart';

class CreatePasswordScreen extends ConsumerStatefulWidget {
  final String contact;
  const CreatePasswordScreen({required this.contact, super.key});

  @override
  ConsumerState<CreatePasswordScreen> createState() =>
      _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  // final bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Gap(8.w),
                      Text(
                        "Create Password",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),

                  Gap(67.h),
                  Image.asset(
                    'assets/pngs/logo.png',
                    height: 71.h,
                    width: 73.w,
                    fit: BoxFit.cover,
                  ),
                  Gap(24.h),
                  Text(
                    "Create Password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gap(8.h),
                  Text(
                    "Type and confirm a secure new password",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Gap(24.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "New Password",
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
                    hintText: '************',

                    controller: _passwordController,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      _passwordController.text,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  Gap(24.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
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
                    hintText: '************',

                    controller: _confirmPasswordController,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      _passwordController.text,
                    ),
                    textInputAction: TextInputAction.next,
                  ),

                  Gap(24.h),
                  ref.watch(createPasswordStateprovider)
                      ? const CustomLoaderWidget()
                      : CustomButton(
                          text: 'Save',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await ref
                                  .read(createPasswordStateprovider.notifier)
                                  .createPassword(
                                    contact: widget.contact,
                                    password: _passwordController.text,
                                    confirmpassword:
                                        _confirmPasswordController.text,
                                  )
                                  .then((response) {
                                    if (response.isSuccess) {
                                      GlobalFunction.showCustomSnackbar(
                                        isSuccess: true,
                                        message: response.message,
                                      );
                                      if (context.mounted) {
                                        context.go(Routes.login);
                                      }
                                    }
                                  });

                              // Process data.
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
