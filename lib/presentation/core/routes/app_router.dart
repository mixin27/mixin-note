import 'package:auto_route/annotations.dart';

import '../../sign_in/sign_in_page.dart';
import '../../splash/splash_page.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
