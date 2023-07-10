import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organaki_app/models/singleton_user.dart';
import 'package:organaki_app/modules/authentication/pages/login_page.dart';
import 'package:organaki_app/modules/authentication/pages/register_page.dart';
import 'package:organaki_app/modules/home/pages/home_main.dart';
import 'package:organaki_app/modules/home/pages/home_map_page.dart';
import 'package:organaki_app/modules/home/pages/home_orders_page.dart';
import 'package:organaki_app/modules/producer/pages/producer_apresentation_page.dart';
import 'package:organaki_app/modules/producer/pages/producer_account_page.dart';
import 'package:organaki_app/modules/producer/pages/producer_edit_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final route = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/map',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) =>
            const HomeMain(),
        routes: <RouteBase>[
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/map',
              routes: [producerDetailRout],
              builder: (BuildContext context, GoRouterState state) =>
                  const HomeMapPage()),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/list',
              routes: [producerDetailRout],
              builder: (BuildContext context, GoRouterState state) =>
                  const HomeOrdersPage()),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/account',
              redirect: (context, state) {
                if (SingletonUser().userAuth == null) {
                  return "/account/login";
                }
                return "/account/account";
              },
              routes: [
                GoRoute(
                    path: 'login',
                    builder: (BuildContext context, GoRouterState state) =>
                        const LoginPage()),
                GoRoute(
                    path: 'account',
                    builder: (BuildContext context, GoRouterState state) =>
                        const ProducerAccountPage()),
              ]),
        ],
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/edit',
          builder: (BuildContext context, GoRouterState state) {
            var params = state.extra as Map;
            var producerUser  = params["producerUser"];
            return  ProducerEditPage(producerUser: producerUser);
          }),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/register',
          builder: (BuildContext context, GoRouterState state) =>
              const RegisterPage()),
    ]);
var producerDetailRout = GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: 'detail',
    builder: (BuildContext context, GoRouterState state) {
      var params = state.extra as Map;
      String id = params["id"];
      var latLongProducer = params["latLongProducer"];

      return ProducerApresentationPage(
        latLongProducer: latLongProducer,
        id: id,
      );
    });
