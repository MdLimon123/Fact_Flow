import 'package:fact_flow/controllers/data_controller.dart';
import 'package:fact_flow/controllers/home_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/screen/History/history_screen.dart';
import 'package:fact_flow/views/screen/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(HomeController());

  final textController = TextEditingController();

  final _dataController = Get.put(DataController());

  String activeSection = '';

  @override
  initState() {
    _dataController.loadUserData();

    super.initState();
  }

  Widget buildCard({
    required String title,
    required String icon,
    required VoidCallback onTap,
    bool isActive = false,
    double width = 180,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: 130,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFE6F6F8) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFFE6EBF0).withValues(alpha: 0.50),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Color(0xFFB0E3EA) : Colors.white,
                border: Border.all(
                  color: isActive
                      ? Colors.transparent
                      : Color(0xFFE6EBF0).withValues(alpha: 0.50),
                ),
              ),
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Color(0xFF005A67) : AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({required String hint}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFB0E3EA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: textController,
        maxLines: 4,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0xFF8A8A8A),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildPdfCard() {
    return InkWell(
      onTap: _homeController.pickPdf,
      child: Obx(() {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFB0E3EA)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFE6F6F8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    _homeController.pdfName.value.isNotEmpty
                        ? "assets/icons/demoPdf.svg"
                        : "assets/icons/upload.svg",
                  ),
                ),
              ),

              SizedBox(height: 8),
              Text(
                _homeController.pdfName.value.isNotEmpty
                    ? _homeController.pdfName.value
                    : "Tap to select file",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildImageCard() {
    return Obx(
      () => InkWell(
        onTap: () => _homeController.pickImageGellary(),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFB0E3EA)),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFE6F6F8),
                ),
                child: _homeController.pickImage.value == null
                    ? Icon(Icons.image, size: 36)
                    : Image.file(_homeController.pickImage.value!),
              ),
              const SizedBox(height: 8),
              Text(
                _homeController.pickImage.value == null
                    ? "Tap to select file"
                    : "Selected: ${_homeController.pickImage.value!.path.split('/').last}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/image/app_logo.png',
                    width: 50,
                    height: 50,
                  ),
                  Spacer(),

                  InkWell(
                    onTap: () {
                      Get.to(() => ProfileScreen());
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
                        child: SvgPicture.asset('assets/icons/user.svg'),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

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
              SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  double cardWidth = (constraints.maxWidth - 15) / 2;
                  return Wrap(
                    spacing: 5,
                    runSpacing: 10,
                    children: [
                      buildCard(
                        title: "Paste Text",
                        icon: "assets/icons/doc.svg",
                        onTap: () => setState(() => activeSection = 'text'),
                        isActive: activeSection == 'text',
                        width: cardWidth,
                      ),
                      buildCard(
                        title: "Enter URL",
                        icon: "assets/icons/file.svg",
                        onTap: () => setState(() => activeSection = 'url'),
                        isActive: activeSection == 'url',
                        width: cardWidth,
                      ),

                      buildCard(
                        title: "Upload Image",
                        icon: "assets/icons/image.svg",
                        onTap: () => setState(() => activeSection = 'image'),
                        isActive: activeSection == 'image',
                        width: cardWidth,
                      ),
                      buildCard(
                        title: "Upload PDF",
                        icon: "assets/icons/pdf.svg",
                        onTap: () => setState(() => activeSection = 'pdf'),
                        isActive: activeSection == 'pdf',
                        width: cardWidth,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // --- Selected Section Title ---
              if (activeSection.isNotEmpty)
                Text(
                  activeSection == 'text'
                      ? "Paste Text"
                      : activeSection == 'url'
                      ? "Enter URL"
                      : activeSection == 'image'
                      ? "Upload Image"
                      : "Upload PDF",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
              SizedBox(height: 12),

              if (activeSection == 'text') ...[
                buildTextField(hint: "Paste text here..."),
              ] else if (activeSection == 'url') ...[
                buildTextField(hint: "Enter URL..."),
              ] else if (activeSection == 'pdf') ...[
                buildPdfCard(),
              ] else if (activeSection == 'image') ...[
                buildImageCard(),
              ],
              SizedBox(height: 100),

              CustomButton(
                onTap: () {
                  if (activeSection == 'text') {
                    _homeController.submitText(text: textController.text);
                  } else if (activeSection == 'url') {
                    _homeController.submitUrl(url: textController.text);
                  } else if (activeSection == 'image') {
                    if (_homeController.pickImage.value != null) {
                      debugPrint(
                        "Please select an image==========> ${_homeController.pickImage.value!.path}",
                      );
                      _homeController.uploadImage();
                    } else {
                      Get.snackbar("Error", "Please select an image first");
                    }
                  } else if (activeSection == 'pdf') {
                    if (_homeController.pdfPath.value.isNotEmpty) {
                      _homeController.uploadPdf(
                        pdf: _homeController.pdfPath.value,
                      );
                    } else {
                      Get.snackbar("Error", "Please select a PDF file first");
                    }
                  }
                },

                text: "Analysis",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
