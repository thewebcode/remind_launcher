import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:remind_launcher/bloc/tasks.dart';

class MainBloc with ChangeNotifier, Tasks {
  List _apps = [];

  List get apps {
    return _apps;
  }

  // IDEA: If launch fails show an error
  Future<bool> launchChrome() async {
    bool chromeLaunched = await DeviceApps.openApp('com.android.chrome');
    return chromeLaunched;
  }

  Future<bool> launchCamera() async {
    bool dialer = await DeviceApps.openApp('com.android.camera2');

    if (!dialer) {
      dialer = await DeviceApps.openApp('com.android.camera');
    }
    return dialer;
  }

  Future<bool> launchMessaging() async {
    return await DeviceApps.openApp('com.google.android.apps.messaging');
  }

  Future<bool> launchDialer() async {
    if (!await DeviceApps.openApp('com.android.dialer')) {
      await DeviceApps.openApp('com.sh.smart.caller');
    }

    // check for dialer app`
    return false;
  }

  Future<void> getApps({bool shouldNotify: true}) async {
    List apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );

    apps.sort((a, b) => a.appName.compareTo(b.appName));

    _apps = apps;

    if (shouldNotify) this.notifyListeners();
  }
}
