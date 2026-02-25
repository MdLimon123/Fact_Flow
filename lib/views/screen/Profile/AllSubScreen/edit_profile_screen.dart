import 'package:fact_flow/controllers/profile_controller.dart';
import 'package:fact_flow/services/api_constant.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_network_image.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _profileController = Get.put(ProfileController());

  final nameController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.fetchUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = _profileController.userInfo.value.name ?? "";

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Color(0xFF0D1C12)),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTextColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () =>
                              _profileController.userProfileImage.value != null
                              ? Container(
                                  height: 160,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(
                                        _profileController
                                            .userProfileImage
                                            .value!,
                                      ),

                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : CustomNetworkImage(
                                  imageUrl:
                                      "${ApiConstant.baseUrl}${_profileController.userInfo.value.avatar}",
                                  height: 160,
                                  boxShape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.borderColor,
                                  ),
                                  width: 160,
                                ),
                        ),

                        Positioned(
                          child: InkWell(
                            onTap: () {
                              _profileController.pickUserProfileImage();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/image_fram.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      isEmail: true,
                      controller: nameController,
                      prefixIcon: Container(
                        height: 24,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00A4BB),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/fill.svg'),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    Obx(
                      () => CustomButton(
                        loading: _profileController.uploadProfileLoading.value,
                        onTap: () {
                          if (nameController.text.isEmpty) {
                            nameController.text =
                                _profileController.userInfo.value.name ?? "";
                          }

                          _profileController.updateProfile(
                            imagePath:
                                _profileController.userProfileImage.value !=
                                    null
                                ? _profileController
                                      .userProfileImage
                                      .value!
                                      .path
                                : "",
                            name: nameController.text.trim(),
                          );
                        },
                        text: "Save",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
