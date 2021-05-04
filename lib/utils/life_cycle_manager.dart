import 'package:flutter/material.dart';
import 'package:nehemiah/services/dynamic_link_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;

  LifeCycleManager({Key key, this.child}) : super(key: key);
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  DynamicLinkService _service;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _service = DynamicLinkService(dynamicLinkAction: dynamicLinkAction);
    _service.retrieveDynamicLink();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _service.retrieveDynamicLink();
    }
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  Future dynamicLinkAction(PendingDynamicLinkData dynamicLink) async {
    Map paramsMap = dynamicLink?.link?.queryParameters ?? {};
    print(
        'Parameter a is ${paramsMap['a']} and parameter b is ${paramsMap['b']}');

    Navigator.pushNamed(context, dynamicLink.link.path);

    // Parameter a is 1 and parameter b is 2
  }
}
