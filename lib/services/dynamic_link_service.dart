//class DynamicLinkService {
//  Future handleDynamicLinks() async {
//    // 1. Get the initial dynamic link if the app is opened with a dynamic link
//    final PendingDynamicLinkData data =
//        await FirebaseDynamicLinks.instance.getInitialLink();
//
//    // 2. handle link that has been retrieved
//    _handleDeepLink(data);
//
//    // 3. Register a link callback to fire if the app is opened up from the background
//    // using a dynamic link.
//    FirebaseDynamicLinks.instance.onLink(
//        onSuccess: (PendingDynamicLinkData dynamicLink) async {
//      // 3a. handle link that has been retrieved
//      _handleDeepLink(dynamicLink);
//    }, onError: (OnLinkErrorException e) async {
//      print('Link Failed: ${e.message}');
//    });
//  }
//
//  void _handleDeepLink(PendingDynamicLinkData data) {
//    final Uri deepLink = data?.link;
//    if (deepLink != null) {
//      print('_handleDeepLink | deeplink: $deepLink');
//    }
//  }
//}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart' as foundation;

typedef DynamicLinkAction(PendingDynamicLinkData dynamicLink);

class DynamicLinkService {
  final DynamicLinkAction dynamicLinkAction;

  DynamicLinkService({this.dynamicLinkAction});

  static const String kDynamicLinkURL =
      'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyCQ4rxb4B8cdR0xN6hyhfevq_XkhcKgdfI';

  Future createLink(Map parameters, String id) async {
    // Construct the link which will open when the Dynamic Link is used
    List parametersList = [];
    parameters?.forEach((key, value) => parametersList.add('$key=$value'));
    String link = 'https://nehemiah-b1bea.web.app/$id';
    if (parametersList.isNotEmpty) {
      link = link + '?${parametersList.join('&')}';
    }
    Map headers = {'Content-Type': 'application/json'};

    // Configure the Dynamic Link
    Map body = {
      'dynamicLinkInfo': {
        'link': link,
        'domainUriPrefix': 'https://nehemiah.page.link',
        'androidInfo': {'androidPackageName': 'com.missiorex.nehemiah'},
        'iosInfo': {
          'iosBundleId': 'com.missiorex.nehemiah',
          'iosAppStoreId': '1234567890'
        }
      },
      'suffix': {'option': 'SHORT'}
    };

    // Request the deep link
    http.Response response = await http.post(
      kDynamicLinkURL,
      body: jsonEncode(body),
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    // Check if we generated a valid Dynamic Link
    if (response.statusCode == 200) {
      Map bodyAnswer = jsonDecode(response.body);
      return bodyAnswer['shortLink'];
    } else {
      return '';
    }
  }

  Future retrieveDynamicLink() async {
    if (!foundation.kIsWeb) {
      final PendingDynamicLinkData dynamicLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (dynamicLink != null) {
        dynamicLinkAction(dynamicLink);
        // doSomething(dynamicLink);
      }
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        if (dynamicLink != null) {
          //doSomething(dynamicLink);
          dynamicLinkAction(dynamicLink);
        }
      });
    }
  }

//  Future doSomething(PendingDynamicLinkData dynamicLink) async {
//    Map paramsMap = dynamicLink?.link?.queryParameters ?? {};
//    print(
//        'Parameter a is ${paramsMap['a']} and parameter b is ${paramsMap['b']}');
//
//    // Parameter a is 1 and parameter b is 2
//  }
}
