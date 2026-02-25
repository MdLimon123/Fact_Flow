import 'package:fact_flow/controllers/profile_controller.dart';
import 'package:fact_flow/helpers/prefs_helper.dart';
import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/services/api_constant.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/utils/app_constants.dart';
import 'package:fact_flow/views/base/custom_loading.dart';
import 'package:fact_flow/views/base/custom_network_image.dart';
import 'package:fact_flow/views/screen/History/history_screen.dart';
import 'package:fact_flow/views/screen/Profile/AllSubScreen/about_us_screen.dart';
import 'package:fact_flow/views/screen/Profile/AllSubScreen/change_password_screen.dart';
import 'package:fact_flow/views/screen/Profile/AllSubScreen/edit_profile_screen.dart';
import 'package:fact_flow/views/screen/Profile/AllSubScreen/report_problem_screen.dart';
import 'package:fact_flow/views/screen/Profile/AllSubScreen/terms_of_service_screen.dart';
import 'package:fact_flow/views/screen/Profile/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileController = Get.put(ProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.fetchUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("avater =======> ${_profileController.userInfo.value.avatar}");
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: Obx(() {
        if (_profileController.isLaoding.value) {
          return Center(child: CustomLoading());
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Color(0xFF0D1C12)),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTextColor,
                      ),
                    ),
                    Spacer(),

                    InkWell(
                      onTap: () {
                        Get.to(() => HistoryScreen());
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.backgroundColor,
                          border: Border.all(color: Color(0xFFE6EBF0)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withValues(alpha: 0.10),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/icons/clock.svg'),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl:
                          "${ApiConstant.baseUrl}${_profileController.userInfo.value.avatar}",
                      boxShape: BoxShape.circle,
                      height: 50,
                      width: 50,
                    ),

                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _profileController.userInfo.value.name ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTextColor,
                          ),
                        ),
                        Text(
                          _profileController.userInfo.value.email ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subTextColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(() => EditProfileScreen());
                      },
                      child: SvgPicture.asset("assets/icons/edit.svg"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F6F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fact Flow Pro",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTextColor,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Your Subscription is active and renews on 14 Nov, 2025",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.subTextColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 36,
                            width: 86,
                            decoration: BoxDecoration(
                              color: Color(0xFF33B6C9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Manage",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F6F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _customListTile(
                        onTap: () {
                          Get.to(() => ChangePasswordScreen());
                        },
                        leading: "assets/icons/lock.svg",
                        title: "Change Password",
                      ),
                      _customListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFF335D83),

                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Are you sure you want to delete your account?',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await _profileController
                                                .deleteAccount();

                                            await PrefsHelper.remove(
                                              AppConstants.bearerToken,
                                            );
                                          },
                                          child: Container(
                                            width: 81,
                                            height: 52,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color(0xFFFFFFFF),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            height: 52,
                                            width: 125,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              );
                            },
                          );
                        },
                        leading: "assets/icons/delete.svg",
                        title: "Delete my account",
                      ),
                      _customListTile(
                        onTap: () {
                          Get.to(() => ReportProblemScreen());
                        },
                        leading: "assets/icons/report.svg",
                        title: "Report a Problem",
                      ),
                      _customListTile(
                        onTap: () {
                          Get.to(() => TermsOfServiceScreen());
                        },
                        leading: "assets/icons/info_empty.svg",
                        title: "Terms of service",
                      ),
                      _customListTile(
                        onTap: () {
                          Get.to(() => PrivacyPolicyScreen());
                        },
                        leading: "assets/icons/security_safe.svg",
                        title: "Privacy Policy",
                      ),
                      _customListTile(
                        onTap: () {
                          Get.to(() => AboutUsScreen());
                        },
                        leading: "assets/icons/about.svg",
                        title: "About us",
                      ),

                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFF335D83),

                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Are you sure you want to logout your account?',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await PrefsHelper.remove(
                                              AppConstants.bearerToken,
                                            );
                                            Get.offAllNamed(
                                              AppRoutes.loginScreen,
                                            );
                                          },
                                          child: Container(
                                            width: 81,
                                            height: 52,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color(0xFFFFFFFF),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            height: 52,
                                            width: 125,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              );
                            },
                          );
                        },
                        leading: SvgPicture.asset(
                          "assets/icons/log_out.svg",
                          color: AppColors.textColor,
                        ),
                        title: Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF002547),
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  ListTile _customListTile({
    required String leading,
    required String title,
    required Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(leading, color: AppColors.textColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),
      ),
      trailing: Icon(Icons.navigate_next_outlined),
    );
  }
}
