import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// A widget that displays device and environment information.
class DeviceInfoSection extends StatefulWidget {
  final bool isDark;
  final bool isAmoled;

  const DeviceInfoSection({
    super.key,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  State<DeviceInfoSection> createState() => _DeviceInfoSectionState();
}

class _DeviceInfoSectionState extends State<DeviceInfoSection> {
  PackageInfo? _packageInfo;
  Map<String, String> _deviceInfo = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllInfo();
  }

  Future<void> _loadAllInfo() async {
    setState(() => _isLoading = true);

    // Load package info
    final packageInfo = await PackageInfo.fromPlatform();

    // Load device info
    final deviceInfoPlugin = DeviceInfoPlugin();
    final Map<String, String> deviceData = {};

    try {
      if (Platform.isWindows) {
        final windowsInfo = await deviceInfoPlugin.windowsInfo;
        deviceData['Computer Name'] = windowsInfo.computerName;
        deviceData['Product Name'] = windowsInfo.productName;
        deviceData['Build Number'] = '${windowsInfo.buildNumber}';
        deviceData['Edition'] = windowsInfo.displayVersion;
        deviceData['Device ID'] = windowsInfo.deviceId;
        deviceData['Cores'] = '${windowsInfo.numberOfCores}';
        deviceData['Memory (GB)'] =
            '${(windowsInfo.systemMemoryInMegabytes / 1024).toStringAsFixed(1)}';
      } else if (Platform.isMacOS) {
        final macInfo = await deviceInfoPlugin.macOsInfo;
        deviceData['Computer Name'] = macInfo.computerName;
        deviceData['Model'] = macInfo.model;
        deviceData['OS Version'] =
            '${macInfo.majorVersion}.${macInfo.minorVersion}.${macInfo.patchVersion}';
        deviceData['Architecture'] = macInfo.arch;
        deviceData['Cores'] = '${macInfo.activeCPUs}';
        deviceData['Memory (GB)'] =
            '${(macInfo.memorySize / (1024 * 1024 * 1024)).toStringAsFixed(1)}';
      } else if (Platform.isLinux) {
        final linuxInfo = await deviceInfoPlugin.linuxInfo;
        deviceData['Name'] = linuxInfo.name;
        deviceData['Version'] = linuxInfo.version ?? 'Unknown';
        deviceData['ID'] = linuxInfo.id;
        deviceData['Pretty Name'] = linuxInfo.prettyName;
      }
    } catch (e) {
      deviceData['Error'] = e.toString();
    }

    setState(() {
      _packageInfo = packageInfo;
      _deviceInfo = deviceData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);

    return ExpansionTile(
      leading: Icon(LucideIcons.monitor, color: colorScheme.primary),
      title: const Text('Device & Environment'),
      subtitle: const Text('Screen, platform, and build info'),
      children: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategory('Display'),
                _buildInfoRow('Window Logical',
                    '${mediaQuery.size.width.toStringAsFixed(0)} x ${mediaQuery.size.height.toStringAsFixed(0)}'),
                _buildInfoRow('Window Physical',
                    '${(mediaQuery.size.width * mediaQuery.devicePixelRatio).toStringAsFixed(0)} x ${(mediaQuery.size.height * mediaQuery.devicePixelRatio).toStringAsFixed(0)}'),
                _buildInfoRow('Pixel Ratio',
                    '${mediaQuery.devicePixelRatio.toStringAsFixed(2)}x'),
                _buildInfoRow('Text Scale',
                    '${mediaQuery.textScaler.scale(1).toStringAsFixed(2)}x'),
                const Divider(),
                _buildCategory('Platform'),
                _buildInfoRow('OS', Platform.operatingSystem.toUpperCase()),
                if (_deviceInfo.isNotEmpty) ...[
                  ..._deviceInfo.entries
                      .map((e) => _buildInfoRow(e.key, e.value)),
                ],
                _buildInfoRow('Dart', Platform.version.split(' ').first),
                _buildInfoRow(
                    'Flutter Mode',
                    kDebugMode
                        ? 'Debug'
                        : (kProfileMode ? 'Profile' : 'Release')),
                const Divider(),
                _buildCategory('Build'),
                if (_packageInfo != null) ...[
                  _buildInfoRow('App Name', _packageInfo!.appName),
                  _buildInfoRow('Package', _packageInfo!.packageName),
                  _buildInfoRow('Version', _packageInfo!.version),
                  _buildInfoRow(
                      'Build #',
                      _packageInfo!.buildNumber.isEmpty
                          ? 'N/A'
                          : _packageInfo!.buildNumber),
                ],
                const SizedBox(height: 8),
                TextButton.icon(
                  icon: const Icon(LucideIcons.refreshCw, size: 16),
                  label: const Text('Refresh'),
                  onPressed: _loadAllInfo,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCategory(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: widget.isDark
              ? AppThemeV2.darkTextSecondary
              : AppThemeV2.lightTextSecondary,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: widget.isDark
                        ? AppThemeV2.darkTextSecondary
                        : AppThemeV2.lightTextSecondary,
                  ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
