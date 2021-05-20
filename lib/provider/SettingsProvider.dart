import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/job/ForgroundService.dart';
import 'package:peace_time/model/SettingsModel.dart';

class SettingsProvider with ChangeNotifier {
  bool isLoading = true;
  bool isPending = false;
  Settings settings = Settings(
      forgroundServiceStatus: false,
      isDoNotDisturbPermissionStatus: false,
      introductionScreenStatus: false);

  SettingsProvider() {
    // code..
    initialize();
  }

  Future<void> initialize() async {
    settings.isDoNotDisturbPermissionStatus =
        await SettingsController.getPermissionStatus();
    settings.forgroundServiceStatus =
        await ForgroundService.isRunningForgroundService();
    settings.introductionScreenStatus =
        await DBController.getIntroductionScreenStatus();

    if (settings.introductionScreenStatus == null) {
      settings.introductionScreenStatus = false;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    initialize();
    notifyListeners();
  }

  Future<void> isPendingValue(bool value) async {
    isPending = value;
    notifyListeners();
  }

  Future<void> toggleForgroundServiceStatus() async {
    Timer(Duration(seconds: 2), () async {
      settings.forgroundServiceStatus
          ? await ForgroundService.stopForgroundService()
          : await ForgroundService.startForgroundServiceAndTask();
      settings.forgroundServiceStatus =
          await ForgroundService.isRunningForgroundService();
      isPending = false;
      notifyListeners();
    });
  }

  Future<void> toggleIntroductionScreenStatus() async {
    if (settings.introductionScreenStatus == null) {
      settings.introductionScreenStatus = false;
    }
    await DBController.toggleIntroductionScreenStatus(
        !settings.introductionScreenStatus);

    settings.introductionScreenStatus =
        await DBController.getIntroductionScreenStatus();
    notifyListeners();
  }
}
