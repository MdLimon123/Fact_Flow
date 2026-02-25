import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:fact_flow/controllers/ai_chat_result_controller.dart';
import 'package:fact_flow/controllers/home_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/screen/History/history_screen.dart';
import 'package:fact_flow/views/screen/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AiResultScreen extends StatefulWidget {
  const AiResultScreen({super.key});

  @override
  State<AiResultScreen> createState() => _AiResultScreenState();
}

class _AiResultScreenState extends State<AiResultScreen> {
  final _aiChatResultController = Get.put(AiChatResultController());

  final _homeController = Get.put(HomeController());

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> shareCard() async {
    final image = await screenshotController.capture();

    if (image == null) return;

    final directory = await getTemporaryDirectory();
    final imagePath = await File('${directory.path}/result.png').create();
    await imagePath.writeAsBytes(image);

    await Share.shareXFiles([
      XFile(imagePath.path),
    ], text: "Here is my AI Result Card");
  }

  // Future<void> downloadPDFFromText() async {
  //   try {
  //     final data = _homeController.aiResponseResult.value;
  //     if (data == null) return;

  //     final pdf = pw.Document();

  //     pdf.addPage(
  //       pw.MultiPage(
  //         build: (pw.Context context) => [
  //           pw.Text(
  //             "AI RESULT",
  //             style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
  //           ),
  //           pw.SizedBox(height: 12),

  //           pw.Text(
  //             "VERDICT: ${data.verdict ?? 'N/A'}",
  //             style: pw.TextStyle(fontSize: 16),
  //           ),
  //           pw.Text(
  //             "Confidence: ${data.confidence?.toInt() ?? 0}%",
  //             style: pw.TextStyle(fontSize: 14),
  //           ),
  //           pw.SizedBox(height: 12),

  //           pw.Text(
  //             "CLAIM:",
  //             style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //           ),
  //           pw.Text(data.claim ?? 'N/A', style: pw.TextStyle(fontSize: 14)),
  //           pw.SizedBox(height: 12),

  //           pw.Text(
  //             "CONCLUSION:",
  //             style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //           ),
  //           pw.Text(
  //             data.conclusion ?? 'N/A',
  //             style: pw.TextStyle(fontSize: 14),
  //           ),
  //           pw.SizedBox(height: 12),

  //           pw.Text(
  //             "EVIDENCE:",
  //             style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //           ),
  //           pw.Text(
  //             "Supporting Evidence:",
  //             style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
  //           ),
  //           pw.Text(
  //             data.evidence?.supporting?.isNotEmpty == true
  //                 ? data.evidence!.supporting!.join("\n• ")
  //                 : "No supporting evidence available.",
  //             style: pw.TextStyle(fontSize: 14),
  //           ),
  //           pw.SizedBox(height: 8),
  //           pw.Text(
  //             "Counter Evidence:",
  //             style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
  //           ),
  //           pw.Text(
  //             data.evidence?.counter?.isNotEmpty == true
  //                 ? data.evidence!.counter!.join("\n• ")
  //                 : "No counter evidence available.",
  //             style: pw.TextStyle(fontSize: 14),
  //           ),
  //           pw.SizedBox(height: 12),

  //           pw.Text(
  //             "CITATIONS:",
  //             style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  //           ),
  //           if (data.sources != null && data.sources!.isNotEmpty)
  //             ...data.sources!.map(
  //               (source) => pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text(
  //                     source.title ?? '',
  //                     style: pw.TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     source.url ?? '',
  //                     style: pw.TextStyle(fontSize: 14, color: PdfColors.blue),
  //                   ),
  //                   pw.SizedBox(height: 6),
  //                 ],
  //               ),
  //             ),
  //         ],
  //       ),
  //     );

  //     String filePath;
  //     if (Platform.isAndroid) {
  //       final downloadsPath =
  //           await ExternalPath.getExternalStoragePublicDirectory(
  //             ExternalPath.DIRECTORY_DOWNLOAD,
  //           );
  //       filePath =
  //           '$downloadsPath/AI_Result_${DateTime.now().millisecondsSinceEpoch}.pdf';
  //     } else {
  //       final directory = await getApplicationDocumentsDirectory();
  //       filePath =
  //           '${directory.path}/AI_Result_${DateTime.now().millisecondsSinceEpoch}.pdf';
  //     }

  //     final file = File(filePath);
  //     await file.writeAsBytes(await pdf.save());

  //     if (Platform.isIOS) {
  //       await Share.shareXFiles([XFile(filePath)], text: "Here is your PDF");
  //     }

  //     Get.snackbar(
  //       "Success",
  //       "PDF Saved Successfully\n$filePath",
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: Duration(seconds: 3),
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       "Failed to save PDF",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     debugPrint("PDF Error: $e");
  //   }
  // }

  // Future<void> savePDF() async {
  //   await downloadPDFFromText();
  // }

  Future<void> downloadPDFFromText() async {
    try {
      final data = _homeController.aiResponseResult.value;
      if (data == null) return;

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => [
            pw.Text(
              "AI RESULT",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),

            pw.Text(
              "VERDICT: ${data.verdict ?? 'N/A'}",
              style: pw.TextStyle(fontSize: 16),
            ),
            pw.Text(
              "Confidence: ${data.confidence?.toInt() ?? 0}%",
              style: pw.TextStyle(fontSize: 14),
            ),
            pw.SizedBox(height: 12),

            pw.Text(
              "CLAIM:",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(data.claim ?? 'N/A', style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 12),

            pw.Text(
              "CONCLUSION:",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              data.conclusion ?? 'N/A',
              style: pw.TextStyle(fontSize: 14),
            ),
            pw.SizedBox(height: 12),

            pw.Text(
              "EVIDENCE:",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              "Supporting Evidence:",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              data.evidence?.supporting?.isNotEmpty == true
                  ? data.evidence!.supporting!.join("\n• ")
                  : "No supporting evidence available.",
              style: pw.TextStyle(fontSize: 14),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              "Counter Evidence:",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              data.evidence?.counter?.isNotEmpty == true
                  ? data.evidence!.counter!.join("\n• ")
                  : "No counter evidence available.",
              style: pw.TextStyle(fontSize: 14),
            ),
            pw.SizedBox(height: 12),

            pw.Text(
              "CITATIONS:",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            if (data.sources != null && data.sources!.isNotEmpty)
              ...data.sources!.map(
                (source) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      source.title ?? '',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      source.url ?? '',
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.blue),
                    ),
                    pw.SizedBox(height: 6),
                  ],
                ),
              ),
          ],
        ),
      );

      String filePath;
      if (Platform.isAndroid) {
        final downloadsPath =
            await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOAD,
            );
        filePath =
            '$downloadsPath/AI_Result_${DateTime.now().millisecondsSinceEpoch}.pdf';
      } else {
        final directory = await getApplicationDocumentsDirectory();
        filePath =
            '${directory.path}/AI_Result_${DateTime.now().millisecondsSinceEpoch}.pdf';
      }

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      if (Platform.isIOS) {
        await Share.shareXFiles([XFile(filePath)], text: "Here is your PDF");
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("PDF Saved Successfully\n$filePath"),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to save PDF"),
            backgroundColor: Colors.red,
          ),
        );
      });
      debugPrint("PDF Error: $e");
    }
  }

  Future<void> savePDF() async {
    await downloadPDFFromText();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = _homeController.aiResponseResult.value;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/image/app_logo.png',
                    width: 50,
                    height: 50,
                  ),
                  Spacer(),
                  buildCircleIcon('assets/icons/user.svg', () {
                    Get.to(() => ProfileScreen());
                  }),
                  SizedBox(width: 12),
                  buildCircleIcon('assets/icons/clock.svg', () {
                    Get.to(() => HistoryScreen());
                  }),
                ],
              ),

              SizedBox(height: 20),
              Expanded(
                child: Screenshot(
                  controller: screenshotController,
                  child: ListView(
                    children: [
                      Container(
                        width: double.infinity,

                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "VERDICT",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            SizedBox(height: 12),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color:
                                            data.verdict?.toUpperCase() ==
                                                "TRUE"
                                            ? Color(0xFFD3F4DE)
                                            : Color(
                                                0xFFF8C1C1,
                                              ).withValues(alpha: 0.50),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          if (data.verdict?.toUpperCase() ==
                                              "TRUE")
                                            SvgPicture.asset(
                                              'assets/icons/true.svg',
                                            ),

                                          if (data.verdict?.toUpperCase() ==
                                              "TRUE")
                                            SizedBox(width: 12),

                                          Text(
                                            "${data.verdict}",
                                            style: TextStyle(
                                              fontSize: 14,

                                              color:
                                                  data.verdict?.toUpperCase() ==
                                                      "TRUE"
                                                  ? Color(0xFF1AA146)
                                                  : Color(0xFFC93C2A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: 105,
                                      height: 105,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox.expand(
                                            child: CircularProgressIndicator(
                                              value: (data.confidence ?? 0) * 1,
                                              strokeWidth: 5,
                                              backgroundColor: Colors.grey[300],
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                    Color
                                                  >(Color(0xFF33B6C9)),
                                            ),
                                          ),

                                          Text(
                                            '${((data.confidence ?? 0) * 100).toInt()}%',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Positioned(
                                            top: 60,
                                            child: Text(
                                              "Confident",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.subTextColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "CLAIM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.subTextColor,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "${data.claim}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),

                      /// conclusion
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            _aiChatResultController.toggleExpansion(0);
                          },
                          child: Container(
                            width: double.infinity,

                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "CONCLUSION",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.subTextColor,
                                      ),
                                    ),
                                    Spacer(),
                                    AnimatedRotation(
                                      duration: Duration(milliseconds: 100),
                                      turns:
                                          _aiChatResultController.isExpanded[0]
                                          ? 0.5
                                          : 0,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Obx(() {
                                  return AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: _aiChatResultController.isExpanded[0]
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data.conclusion}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            height: 0,
                                          ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: 12),

                      /// evidence
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            _aiChatResultController.toggleExpansion(1);
                          },
                          child: Container(
                            width: double.infinity,

                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "EVIDENCE",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.subTextColor,
                                      ),
                                    ),
                                    Spacer(),
                                    AnimatedRotation(
                                      duration: Duration(milliseconds: 100),
                                      turns:
                                          _aiChatResultController.isExpanded[1]
                                          ? 0.5
                                          : 0,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                Obx(() {
                                  return AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: _aiChatResultController.isExpanded[1]
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Supporting Evidence",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                              SizedBox(height: 8),

                                              Text(
                                                data
                                                        .evidence!
                                                        .supporting!
                                                        .isNotEmpty
                                                    ? data.evidence!.supporting!
                                                          .join("\n• ")
                                                    : "No supporting evidence available.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.textColor,
                                                ),
                                              ),

                                              SizedBox(height: 20),
                                              Text(
                                                "Counter Evidence",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                              SizedBox(height: 8),

                                              Text(
                                                data
                                                        .evidence!
                                                        .counter!
                                                        .isNotEmpty
                                                    ? data.evidence!.counter!
                                                          .join("\n• ")
                                                    : "No counter evidence available.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.subTextColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            height: 0,
                                          ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),

                      /// contitations
                      SizedBox(height: 12),
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            _aiChatResultController.toggleExpansion(2);
                          },
                          child: Container(
                            width: double.infinity,

                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "CITITATIONS",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.subTextColor,
                                      ),
                                    ),
                                    Spacer(),
                                    AnimatedRotation(
                                      duration: Duration(milliseconds: 100),
                                      turns:
                                          _aiChatResultController.isExpanded[2]
                                          ? 0.5
                                          : 0,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                Obx(() {
                                  return AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: _aiChatResultController.isExpanded[2]
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data
                                                            .sources![index]
                                                            .title!,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .subTextColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),

                                                      InkWell(
                                                        onTap: () async {
                                                          final url = data
                                                              .sources![index]
                                                              .url!;
                                                          if (await canLaunchUrl(
                                                            Uri.parse(url),
                                                          )) {
                                                            await launchUrl(
                                                              Uri.parse(url),
                                                              mode: LaunchMode
                                                                  .externalApplication,
                                                            );
                                                          } else {
                                                            print(
                                                              "Could not launch $url",
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          data
                                                              .sources![index]
                                                              .url!,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                              0xFF1180FF,
                                                            ),
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder: (_, _) =>
                                                    SizedBox(height: 10),
                                                itemCount: data.sources!.length,
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            height: 0,
                                          ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      shareCard();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/share.svg'),
                        ),

                        Text(
                          "Share Card",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      savePDF();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/download.svg'),
                        ),

                        Text(
                          "Download PDF",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          await _homeController.saveData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/save.svg'),
                        ),
                      ),

                      Text(
                        "Save History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleIcon(String asset, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundColor,
          border: Border.all(color: Color(0xFFE6EBF0)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withValues(alpha: .1),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(asset),
        ),
      ),
    );
  }
}
