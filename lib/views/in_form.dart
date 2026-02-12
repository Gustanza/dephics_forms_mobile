import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_app/resources/colors.dart';
import 'package:survey_app/services/outlet_report_service.dart';
import 'package:survey_app/utils/globalfns.dart';
import 'package:survey_app/utils/queries.dart';
import 'package:survey_app/utils/yekonga/ye_gvars.dart';
import 'package:survey_app/views/all_submitted_data.dart';
import 'package:survey_app/views/survey_input.dart';

class InForm extends StatefulWidget {
  const InForm({super.key});

  @override
  State<InForm> createState() => _InFormState();
}

class _InFormState extends State<InForm> {
  var fvisitsCount = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void safeState(Function() runnable) {
    if (mounted) {
      setState(() {
        runnable();
      });
    }
  }

  void getData() async {
    try {
      var res = await YeGenV1().shooter(query: fvisitsQ);
      if (res[respGood]) {
        fvisitsCount = res[respBody][ygdata][ygchild_data][ygcount];
        safeState(() {});
      } else {
        debugPrint("Could not get datar");
      }
    } catch (e) {
      debugPrint("Encountered an problemo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.knaufBlue,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.textOnPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KNAUF TANZANIA',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Knauff Customer Survey',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Action Buttons
            _buildActionButton(
              icon: Icons.add_circle_outline,
              label: '+Add New Data',
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OutletInteractionReportScreen(),
                  ),
                );
                getData();
              },
            ),

            // const SizedBox(height: 12),
            // _buildActionButton(
            //   icon: Icons.visibility_outlined,
            //   label: 'View Submitted Data',
            //   onTap: () {
            //     showToast(isGood: true, message: "Coming soon");
            //     // Navigator.of(context).push(
            //     //   MaterialPageRoute(
            //     //     builder: (context) => const AllSubmittedData(),
            //     //   ),
            //     // );
            //   },
            // ),
            const SizedBox(height: 24),

            // Status Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Pending Submissions
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '0 Submission pending',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.upload, size: 16),
                        label: const Text('Upload'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.buttonTextPrimary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Successful Submissions
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$fvisitsCount inputs successfully submitted',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.buttonTextPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
