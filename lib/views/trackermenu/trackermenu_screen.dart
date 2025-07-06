import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trackermenu_controller.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';

const String kTrackermenuRoute = '/trackermenu';

class TrackermenuScreen extends GetWidget<TrackermenuController> {
  const TrackermenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Trackermenu title',
      ),
      body: GetBuilder<TrackermenuController>(
          id: TrackermenuController.trackermenuScreenId,
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Create Application
                  _buildMenuItem(Icons.create, 'Create Application', () {
                    controller.navigationService.navigateToCreateTracker();
                  }),
                  // Doc for Validations
                  _buildMenuItem(Icons.line_style_sharp, 'Doc for Validations', () {
                    controller.navigationService.navigateToTrackerdocforvalidation();
                  }),
                  // Tracker List
                  _buildMenuItem(Icons.list, 'Tracker List', () {
                    controller.navigationService.navigateToTrackerlist();
                  }),
                ],
              ),
            );
          }),
    );
  }

  _buildMenuItem(IconData icon, String title, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.blueGrey,
              size: 28,
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xFF222B45),
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.blueGrey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
