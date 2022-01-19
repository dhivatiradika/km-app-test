import 'package:flutter/material.dart';
import 'package:km_app_test/presentation/pages/page_one.dart';
import 'package:km_app_test/common/utils.dart';
import 'package:km_app_test/presentation/pages/page_three.dart';
import 'package:km_app_test/presentation/pages/page_two.dart';
import 'package:km_app_test/presentation/provider/selected_user_notifier.dart';
import 'package:km_app_test/presentation/provider/user_list_notifier.dart';
import 'package:provider/provider.dart';
import 'package:km_app_test/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<UserListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SelectedUserNotifier>(),
        )
      ],
      child: MaterialApp(
        title: 'KM Test',
        home: PageOne(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case PageOne.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PageOne());
            case PageTwo.ROUTE_NAME:
              String name = settings.arguments as String;
              return MaterialPageRoute(builder: (_) => PageTwo(name: name));
            case PageThree.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PageThree());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
