import 'package:apicalling/core/constants/app_colors.dart';
import 'package:apicalling/core/constants/app_constants.dart';
import 'package:apicalling/core/navigation/app_route.dart';
import 'package:apicalling/core/utils/global_function.dart';
import 'package:apicalling/core/utils/theme_extension.dart';
import 'package:apicalling/core/widgets/app_bar/app_bar_widget.dart';
import 'package:apicalling/core/widgets/buttons/custom_button.dart';
import 'package:apicalling/core/widgets/custom_loader_widget.dart';
import 'package:apicalling/core/widgets/custom_textfield.dart';
import 'package:apicalling/features/auth/controllers/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


import '../../../core/widgets/logo/app_logo_widget.dart';
import '../models/sign_up_model.dart';
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
      appBar: AppBarWidget(title: 'Create Account'),
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
              //  AppLogoWidget(width: 220),

                Gap(24.h),
                Text(
                  'fggff',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Gap(8.h),
                Text(
                  'Please fill the form to create an account',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Gap(24.h),

                CustomTextFieldWithHeading(
                  textFieldName: 'name',
                 
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
                  hintText: '************',
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: AppConstants.required,
                    ),
                    FormBuilderValidators.minLength(
                      8,
                      errorText: 'Password must be at least 8 characters long', 
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
                
                  
                  ],
                ),

                Gap(24.h),
                ref.watch(registrationStateProvider)
                    ? const CustomLoaderWidget()
                    : CustomButton(
                        text: 'Sign Up',
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formkey.currentState!.validate()) {
                            if (!isCheckTerm) {
                              GlobalFunction.showCustomSnackbar(
                                message:
                                    'You must agree to the terms and conditions',
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
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
