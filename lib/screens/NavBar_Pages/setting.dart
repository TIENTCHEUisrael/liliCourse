import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:lilicourse/widgets/appBar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(
          context,
          const Text('Setting App'),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              const FlutterLogo(size: 100),
              const SizedBox(height: 16),
              const Text(
                'Open App Settings',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'On Android + iOS',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text('Open App Settings'),
                onPressed: () =>
                    AppSettings.openAppSettings(asAnotherTask: false),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Device Settings'),
                onPressed: () => AppSettings.openDeviceSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Location / GPS'),
                onPressed: () => AppSettings.openLocationSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Notifications'),
                onPressed: () => AppSettings.openNotificationSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Wifi'),
                onPressed: () => AppSettings.openWIFISettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Bluetooth'),
                onPressed: () => AppSettings.openBluetoothSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open NFC'),
                onPressed: () => AppSettings.openNFCSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open VPN'),
                onPressed: () => AppSettings.openVPNSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Security'),
                onPressed: () => AppSettings.openSecuritySettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Data Roaming'),
                onPressed: () => AppSettings.openDataRoamingSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Display Settings'),
                onPressed: () => AppSettings.openDisplaySettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Date'),
                onPressed: () => AppSettings.openDateSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Sound'),
                onPressed: () => AppSettings.openSoundSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Internal Storage'),
                onPressed: () => AppSettings.openInternalStorageSettings(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Open Battery'),
                onPressed: () => AppSettings.openBatteryOptimizationSettings(),
              ),
            ],
          ),
        ),
      );
}
