import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learningdart/screens/onboarding_screen.dart';
import 'package:learningdart/screens/signup_form.dart';
import 'package:provider/provider.dart';
import 'models/crud_todo.dart';
import 'models/in_app_purchase.dart';
import 'models/logged_user.dart';
import 'models/todo.dart';
import 'package:rxdart/subjects.dart';

import 'widgets/start_app.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

final didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final  selectNotificationSubject = BehaviorSubject<String?>();

const MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

const String testDevice = 'gphone64_x86_64';

void main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  // AndroidInitializationSettings('app_icon');
  //
  // InitializationSettings initializationSettings = const InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: null,
  //   macOS: null,
  //   linux: null,
  // );
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     // onDidReceiveNotificationResponse: (
  //     //(String? payload) async {
  //     //         if (payload != null) {
  //     //           debugPrint('notification payload: $payload');
  //     //         }
  //     //         selectedNotificationPayload = payload;
  //     //         selectNotificationSubject.add(payload);
  //     //       })
  //           );
  MobileAds.instance.initialize();

  runApp(RestartWidget(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final iap = InAppPurchaseService();
    final crudTodo = CrudTodo();
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ScreenUtilInit(
            designSize: const Size(390, 844),
            builder: (context, child) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (BuildContext context) { return crudTodo; },),
                ChangeNotifierProvider(
                  create: (ctx) => LoggedUser(),
                ),
                ChangeNotifierProvider<InAppPurchaseService>(
                  create: (ctx) => iap,
                ),
                StreamProvider(
                  create: (ctx) => iap.getPurchaseDetailsList(ctx), initialData: null,
                ),
                StreamProvider<List<Todo>>(
                  initialData: [],
                  create: (ctx) => crudTodo.getTaskItemsFromServer(),
                )
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const SignUpForm(),
              ),
            ),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
