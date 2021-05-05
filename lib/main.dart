import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campaign_repository/campaign_repository.dart';
import 'package:missio_app_core/missio_app_core.dart';
import 'package:nehemiah/localization.dart';
import 'package:nehemiah/blocs/blocs.dart';
import 'package:nehemiah/models/models.dart';
import 'package:nehemiah/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nehemiah/widgets/widgets.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:nehemiah/utils/utils.dart';

//Dynamic Link Service
import 'package:nehemiah/utils/life_cycle_manager.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:nehemiah/login/login.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'utils/utils.dart';
import 'dart:io';

void main() {
  // We can set a Bloc's observer to an instance of `SimpleBlocObserver`.
  // This will allow us to handle all transitions and errors in SimpleBlocObserver.
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  configureApp();

  runApp(FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
              child: Center(
                  child: Text(
            "Sorry, unable to open app. Please try later.",
            textDirection: TextDirection.ltr,
          )));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider<CampaignsBloc>(
            create: (context) {
              return CampaignsBloc(
                  campaignsRepository: FirebaseCampaignRepository())
                ..add(CampaignsLoaded());
            },
            child: CampaignsApp(),
          );
        }
        return LoadingIndicator();
      }));
}

class CampaignsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CampaignLocalizations().appTitle,
      theme: CampaignTheme.theme,
      localizationsDelegates: [
        CampaignLocalizationsDelegate(),
        MainLocalizationsDelegate(),
      ],
      routes: {
        CampaignRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredCampaignsBloc>(
                create: (context) => FilteredCampaignsBloc(
                  campaignsBloc: BlocProvider.of<CampaignsBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  campaignsBloc: BlocProvider.of<CampaignsBloc>(context),
                ),
              ),
            ],
            child: LifeCycleManager(child: HomeScreen()),
          );
        },
        CampaignRoutes.addCampaign: (context) {
          return AddEditScreen(
            key: CampaignKeys.addCampaignScreen,
            onSave: (title, description) {
              BlocProvider.of<CampaignsBloc>(context).add(
                CampaignAdded(Campaign(title, description: description)),
              );
            },
            isEditing: false,
          );
        },
      },
      onGenerateRoute: (settings) {
        // If you push the Campaign Details route
        if (settings.name == CampaignDetailsScreen.routeName) {
          final CampaignScreenArguments args =
              settings.arguments as CampaignScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return CampaignDetailsScreen(
                id: args.id,
              );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.

//void main() async {
//  Bloc.observer = SimpleBlocObserver();
//  WidgetsFlutterBinding.ensureInitialized();
//  final appleSignInAvailable = await AppleSignInAvailable.check();
//  runApp(Provider<AppleSignInAvailable>.value(
//      value: appleSignInAvailable, child: CampaignsApp()));
//}
//
//class CampaignsApp extends StatefulWidget {
//  CampaignsApp();
//
//  @override
//  State<StatefulWidget> createState() {
//    return CampaignsAppState();
//  }
//}
//
//class CampaignsAppState extends State<CampaignsApp> {
//  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//  final _navigatorKey = GlobalKey<NavigatorState>();
//
//  NavigatorState get _navigator => _navigatorKey.currentState;
//
//  AuthenticationRepository authenticationRepository;
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//  @override
//  void initState() {
//    super.initState();
//
//    if (!kIsWeb) {
//      _firebaseMessaging.configure(
//        onMessage: (Map<String, dynamic> message) async {
//          print("onMessage: $message");
//          _showItemDialog(message);
//        },
//        onLaunch: (Map<String, dynamic> message) async {
//          print("onLaunch: $message");
//          _navigateToItemDetail(message);
//        },
//        onResume: (Map<String, dynamic> message) async {
//          print("onResume: $message");
//          _navigateToItemDetail(message);
//        },
//        onBackgroundMessage:
//            Platform.isAndroid ? myBackgroundMessageHandler : null,
//      );
//      _firebaseMessaging.requestNotificationPermissions(
//          const IosNotificationSettings(
//              sound: true, badge: true, alert: true, provisional: false));
//      _firebaseMessaging.onIosSettingsRegistered
//          .listen((IosNotificationSettings settings) {
//        print("Settings registered: $settings");
//      });
//      _firebaseMessaging.getToken().then((String token) {
//        assert(token != null);
//
//        print("Push Messaging token: $token");
//      });
//    }
//  }
//
//  void _showItemDialog(Map<String, dynamic> message) {
//    showDialog<bool>(
//      context: context,
//      builder: (_) => _buildDialog(context, _itemForMessage(message)),
//    ).then((bool shouldNavigate) {
//      if (shouldNavigate == true) {
//        _navigateToItemDetail(message);
//      }
//    });
//  }
//
//  void _navigateToItemDetail(Map<String, dynamic> message) {
//    final Item item = _itemForMessage(message);
//    // Clear away dialogs
//    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
//    if (!item.route.isCurrent) {
//      Navigator.push(context, item.route);
//    }
//  }
//
//  Widget _buildDialog(BuildContext context, Item item) {
//    return AlertDialog(
//      content: Text("Item ${item.itemId} has been updated"),
//      actions: <Widget>[
//        FlatButton(
//          child: const Text('CLOSE'),
//          onPressed: () {
//            Navigator.pop(context, false);
//          },
//        ),
//        FlatButton(
//          child: const Text('SHOW'),
//          onPressed: () {
//            Navigator.pop(context, true);
//          },
//        ),
//      ],
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//      // Initialize FlutterFire:
//      future: _initialization,
//      builder: (context, snapshot) {
//        // Check for errors
//        if (snapshot.hasError) {
//          return Container(
//              child: Center(
//                  child: Text(
//            "Sorry, unable to open app. Please try later.",
//            textDirection: TextDirection.ltr,
//          )));
//        }
//
//        // Once complete, show your application
//        if (snapshot.connectionState == ConnectionState.done) {
//          authenticationRepository = AuthenticationRepository();
//          UsersRepository userRepository = FirebaseUserRepository();
//          CampaignRepository campaignRepository = FirebaseCampaignRepository();
//
//          return RepositoryProvider.value(
//              value: authenticationRepository,
//              child: BlocProvider(
//                  create: (_) => AuthenticationBloc(
//                        authenticationRepository: authenticationRepository,
//                      ),
//                  child: MultiBlocProvider(
//                    providers: [
//                      BlocProvider<AuthenticationBloc>(
//                        create: (context) {
//                          return AuthenticationBloc(
//                            authenticationRepository: authenticationRepository,
//                          );
//                        },
//                      ),
//                      BlocProvider<UsersBloc>(
//                        create: (context) {
//                          return UsersBloc(
//                            usersRepository: userRepository,
//                          )..add(LoadChildUsers(
//                              userId: context
//                                  .read<AuthenticationBloc>()
//                                  .state
//                                  .user
//                                  .id));
//                        },
//                      ),
//                      BlocProvider<CampaignsBloc>(
//                        create: (context) {
//                          return CampaignsBloc(
//                            campaignsRepository: campaignRepository,
//                          )..add(CampaignsLoaded());
//                        },
//                      ),
//                      BlocProvider<TabBloc>(
//                        create: (context) => TabBloc(),
//                      ),
//                      BlocProvider<FilteredCampaignsBloc>(
//                        create: (context) => FilteredCampaignsBloc(
//                          campaignsBloc:
//                              BlocProvider.of<CampaignsBloc>(context),
//                        ),
//                      ),
//                      BlocProvider<StatsBloc>(
//                        create: (context) => StatsBloc(
//                          campaignsBloc:
//                              BlocProvider.of<CampaignsBloc>(context),
//                        ),
//                      ),
//                    ],
//                    child: MaterialApp(
//                      title: CampaignLocalizations().appTitle,
//                      theme: CampaignTheme.theme,
//                      localizationsDelegates: [
//                        CampaignLocalizationsDelegate(),
//                        MainLocalizationsDelegate(),
//                      ],
//                      routes: {
//                        CampaignRoutes.home: (context) {
//                          return MultiBlocProvider(
//                            providers: [
//                              BlocProvider<TabBloc>(
//                                create: (context) => TabBloc(),
//                              ),
//                              BlocProvider<FilteredCampaignsBloc>(
//                                create: (context) => FilteredCampaignsBloc(
//                                  campaignsBloc:
//                                      BlocProvider.of<CampaignsBloc>(context),
//                                ),
//                              ),
//                              BlocProvider<StatsBloc>(
//                                create: (context) => StatsBloc(
//                                  campaignsBloc:
//                                      BlocProvider.of<CampaignsBloc>(context),
//                                ),
//                              ),
//                            ],
//                            child: HomeScreen(),
//                          );
//                        },
//                        CampaignRoutes.addCampaign: (context) {
//                          return AddEditScreen(
//                            key: CampaignKeys.addCampaignScreen,
//                            onSave: (title, description) {
//                              BlocProvider.of<CampaignsBloc>(context).add(
//                                CampaignAdded(
//                                    Campaign(title, description: description)),
//                              );
//                            },
//                            isEditing: false,
//                          );
//                        },
//                      },
//                      debugShowCheckedModeBanner: false,
//                      navigatorKey: _navigatorKey,
//
////        home: HomeScreen(),
//                      builder: (context, child) {
//                        return BlocListener<AuthenticationBloc,
//                            AuthenticationState>(
//                          listener: (context, state) {
//                            switch (state.status) {
//                              case AuthenticationStatus.authenticated:
//                                _navigator.pushAndRemoveUntil<void>(
//                                  HomeScreen.route(),
//                                  (route) => false,
//                                );
//                                break;
//                              case AuthenticationStatus.unauthenticated:
////                                kIsWeb
////                                    ? _navigator.pushAndRemoveUntil<void>(
////                                        LoginPage.route(),
////                                        (route) => false,
////                                      )
////                                    : _navigator.pushAndRemoveUntil<void>(
////                                        LoginPage.route(),
////                                        (route) => false,
////                                      );
//                                _navigator.pushAndRemoveUntil<void>(
//                                  HomeScreen.route(),
//                                  (route) => false,
//                                );
//                                break;
//                              default:
//                                break;
//                            }
//                          },
//                          child: child,
//                        );
//                      },
//
//                      onGenerateRoute: (settings) {
//                        // Handle '/'
//                        if (settings.name == '/') {
//                          return MaterialPageRoute(
//                              builder: (context) => HomeScreen());
//                        }
//
//                        return MaterialPageRoute(
//                            builder: (context) => UnknownScreen());
//                      },
//                    ),
//                  )));
//        }
//
//        // Otherwise, show something whilst waiting for initialization to complete
//        return LoadingIndicator();
//      },
//    );
//  }
//}
////Background FCM handler
//
//Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//  if (message.containsKey('data')) {
//    // Handle data message
//    final dynamic data = message['data'];
//  }
//
//  if (message.containsKey('notification')) {
//    // Handle notification message
//    final dynamic notification = message['notification'];
//  }
//
//  // Or do other work.
//}
//
//// To redirect to apprpriate screen on FCM
//
//final Map<String, Item> _items = <String, Item>{};
//Item _itemForMessage(Map<String, dynamic> message) {
//  final dynamic data = message['data'] ?? message;
//  final String itemId = data['id'];
//  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
//    ..status = data['status'];
//  return item;
//}
//
//class Item {
//  Item({this.itemId});
//  final String itemId;
//
//  StreamController<Item> _controller = StreamController<Item>.broadcast();
//  Stream<Item> get onChanged => _controller.stream;
//
//  String _status;
//  String get status => _status;
//  set status(String value) {
//    _status = value;
//    _controller.add(this);
//  }
//
//  static final Map<String, Route<void>> routes = <String, Route<void>>{};
//  Route<void> get route {
//    final String routeName = '/chatbot/$itemId';
//    return routes.putIfAbsent(
//      routeName,
//      () => MaterialPageRoute<void>(
//          settings: RouteSettings(name: routeName),
//          builder: (BuildContext context) => HomeScreen()),
//    );
//  }
//}
//
//class UnknownScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(),
//      body: Center(
//        child: Text('404!'),
//      ),
//    );
//  }
//}
