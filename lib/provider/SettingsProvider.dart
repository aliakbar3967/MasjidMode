import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/model/SettingsModel.dart';

class SettingsProvider with ChangeNotifier {
  bool isLoading = true;
  bool isPending = false;
  Settings settings = Settings(
      isDoNotDisturbPermissionStatus: false,
      introductionScreenStatus: false,
      darkMode: false);

  SettingsProvider() {
    // code..
    initialize();
  }

  Future<void> initialize() async {
    settings.isDoNotDisturbPermissionStatus =
        await SettingsController.getPermissionStatus();
    settings.introductionScreenStatus =
        await DBController.getIntroductionScreenStatus();
    settings.darkMode = await DBController.getDarkModeStatus();

    if (settings.introductionScreenStatus == null) {
      settings.introductionScreenStatus = false;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    initialize();
  }

  Future<void> toggleDarkMode() async {
    await DBController.toggleDarkModeStatus(!settings.darkMode);
    settings.darkMode = await DBController.getDarkModeStatus();
    notifyListeners();
  }

  Future<void> darkModeStatus() async {
    settings.darkMode = await DBController.getDarkModeStatus();
    notifyListeners();
  }

  Future<void> isPendingValue(bool value) async {
    isPending = value;
    notifyListeners();
  }

  Future<void> toggleIntroductionScreenStatus() async {
    if (settings.introductionScreenStatus == null) {
      settings.introductionScreenStatus = false;
    }
    await DBController.toggleIntroductionScreenStatus(
        !settings.introductionScreenStatus);

    settings.introductionScreenStatus = !settings.introductionScreenStatus;
    notifyListeners();
  }
}
