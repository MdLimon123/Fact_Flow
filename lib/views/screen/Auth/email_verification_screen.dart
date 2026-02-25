import 'package:fact_flow/controllers/auth_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _authController = Get.put(AuthController());

  @override
  void initState() {
    _authController.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFE6E6E6)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: .04),

            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/image/app_logo.png', width: 50, height: 50),
              SizedBox(height: 32),
              Text(
                "Check Your \nInbox",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF413E3E),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We've sent a 6-digit code ending in 56",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 40),

              Pinput(
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: Color(0xFFFCFCFB),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withValues(alpha: 0.4),

                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                onCompleted: (pin) {
                  _authController.otp.value = pin;
                },
              ),

              SizedBox(height: 20),

              Center(
                child: Obx(() {
                  return _authController.showResendButton.value
                      ? TextButton(
                          onPressed: () {
                            _authController.resendCode(email: widget.email);
                          },
                          child: Text(
                            "Resend Code",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00A4BB),
                            ),
                          ),
                        )
                      : Text.rich(
                          TextSpan(
                            text: 'Resend code after ',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${_authController.secondsRemaining.value}s',
                                style: TextStyle(
                                  color: Color(0xFF00A4BB),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                }),
              ),

              SizedBox(height: 100),
              Obx(
                () => CustomButton(
                  loading: _authController.isVerifyLoading.value,
                  onTap: () {
                    _authController.accountVeryfy(email: widget.email);
                  },
                  text: "Verify Code",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
