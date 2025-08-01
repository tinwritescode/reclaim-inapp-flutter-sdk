import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../logging/logging.dart';
import '../../overrides/overrides.dart';
import 'access_token.dart';

final class CapabilityAccessVerifier {
  const CapabilityAccessVerifier();

  static final _logger = Logger('reclaim_inapp_sdk').child('CapabilityAccessVerifier');

  CapabilityAccessToken? getAccessToken() {
    return ReclaimOverrides.capabilityAccessToken;
  }

  String get _operatingSystemName {
    if (kDebugMode) {
      return defaultTargetPlatform.name.toLowerCase();
    }
    return Platform.operatingSystem;
  }

  /// Whether the current app can be identified as the same party as the given [uri].
  Future<bool> isAuthorizedParty(Uri uri) async {
    final log = _logger.child('isAuthorizedParty');
    try {
      final partyPlatform = uri.scheme;
      if (_operatingSystemName != partyPlatform) {
        return false;
      }
      final packageInfo = await PackageInfo.fromPlatform();
      final packageName = packageInfo.packageName;
      final partyPackageName = uri.host;
      return packageName == partyPackageName;
    } catch (e, s) {
      log.severe('Error verifying party', e, s);
      return false;
    }
  }

  Future<bool> canUse(String capability) async {
    final accessToken = getAccessToken();
    if (accessToken == null) {
      return false;
    }
    final authorizedParties = accessToken.authorizedParties;
    for (final party in authorizedParties) {
      if (await isAuthorizedParty(party)) {
        return accessToken.capabilities.contains(capability);
      }
    }
    return false;
  }
}
