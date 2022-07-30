// Reference Link:https://www.youtube.com/watch?v=QNUkIXAXatI

// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsProvider = ChangeNotifierProvider((ref) => Settings());

class Settings extends ChangeNotifier {
  /// StorageUnitConfig Page
  bool isResizePhotosOn = false;
  bool isResizeVideosOn = false;
  bool isEncryptVideoOn = false;
  String storageLaptopName = "My Laptop";

  void resizePhotosChanged(isCheck) {
    isResizePhotosOn = isCheck;
    notifyListeners();
  }

  void resizeVideosChanged(isCheck) {
    isResizeVideosOn = isCheck;
    notifyListeners();
  }

  void encryptVideoChanged(isCheck) {
    isEncryptVideoOn = isCheck;
    notifyListeners();
  }

  /// ComputeUnitConfig Page
  String computeLaptopName = "My Laptop";

  /// Backup Settings Page
  bool isBackupOn = false;
  bool isUploadWiFiOn = false;
  bool isUploadFilterOn = false;
  String srcDirName = "Upload Source Directory";

  void backupChanged(isCheck) {
    isBackupOn = isCheck;
    notifyListeners();
  }

  void uploadWiFiChanged(isCheck) {
    isUploadWiFiOn = isCheck;
    notifyListeners();
  }

  void uploadFilterChanged(isCheck) {
    isUploadFilterOn = isCheck;
    notifyListeners();
  }

  /// Encryption Settings Page
  bool isEncryptionEnabled = false;

  void encryptionChanged(isCheck) {
    isEncryptionEnabled = isCheck;
    notifyListeners();
  }

  /// General Settings Page
  bool isEnableCacheOn = false;
  double sliderValue = 1000;

  void cacheChanged(isCheck) {
    isEnableCacheOn = isCheck;
    notifyListeners();
  }

  /// Privacy Settings Page
  bool isPrivatePhotoEnabled = false;
  bool isUseFaceIdOn = false;
  bool isPhotoSharingPrevented = false;

  void photoEnabledChanged(isCheck) {
    isPrivatePhotoEnabled = isCheck;
    //notifyListeners(); // Not work but to use setState()?
  }

  void useFaceIDChanged(isCheck) {
    isUseFaceIdOn = isCheck;
    //notifyListeners();
  }

  void photoSharingPreventChanged(isCheck) {
    isPhotoSharingPrevented = isCheck;
    //notifyListeners();
  }

  /// Notification Settings Page
  NotificationItem backupErrors = NotificationItem();
  NotificationItem backupWarnings = NotificationItem();
  NotificationItem computeErrors = NotificationItem();
  NotificationItem computeWarnings = NotificationItem();
  NotificationItem newStory = NotificationItem();

  void itemCheckChanged(item, method, isCheck) {
    if (method == "Email") {
      item.isEmailCheck = isCheck;
    } else if (method == "Text") {
      item.isTextCheck = isCheck;
    } else if (method == "App") {
      item.isAppCheck = isCheck;
    }
    notifyListeners();
  }
}

/// Item Structure for Notification Settings
class NotificationItem {
  bool isEmailCheck = false;
  bool isTextCheck = false;
  bool isAppCheck = false;
}
