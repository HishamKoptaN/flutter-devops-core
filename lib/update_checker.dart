import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker {
  static const String versionFileUrl =
      'https://yourdomain.com/downloads/version.json';

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      int currentVersionCode = int.parse(packageInfo.buildNumber);
      final response = await http.get(Uri.parse(versionFileUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int latestVersionCode = data['versionCode'];
        String apkUrl = data['apkUrl'];
        String releaseNotes = data['releaseNotes'];
        if (latestVersionCode > currentVersionCode) {
          _showUpdateDialog(context, apkUrl, releaseNotes);
        }
      }
    } catch (e) {
      debugPrint('فشل التحقق من التحديث: $e');
    }
  }

  static void _showUpdateDialog(
    BuildContext context,
    String apkUrl,
    String notes,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
        title: const Text('تحديث جديد متوفر!'),
        content: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            const Text('توفرت نسخة جديدة من التطبيق لتحسين تجربتك.'),
            const SizedBox(height: 8),
            Text(
              'الجديد في هذا الإصدار:\n$notes',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لاحقاً'),
          ),
          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse(apkUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: .externalApplication);
              }
            },
            child: const Text('تحديث الان'),
          ),
        ],
      );
      },
    );
  }
}
