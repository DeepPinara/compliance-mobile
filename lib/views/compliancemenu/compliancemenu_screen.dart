import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'compliancemenu_controller.dart';

const String kCompliancemenuRoute = '/compliancemenu';

class CompliancemenuScreen extends GetView<CompliancemenuController> {
  const CompliancemenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Compliance Menu',
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        itemCount: controller.menuItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = controller.menuItems[index];
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Get.toNamed(item.route),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      color: Colors.blueGrey,
                      size: 28,
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        item.title,
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
            ),
          );
        },
      ),
    );
  }
}
