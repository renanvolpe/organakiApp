import 'package:flutter/material.dart';
import 'package:organaki_app/bloc/bloc_edit_producer/edit_producer_bloc.dart';
import 'package:organaki_app/bloc/bloc_get_list_producer/get_list_producers_bloc.dart';
import 'package:organaki_app/bloc/bloc_get_list_tags/get_list_tags_bloc.dart';
import 'package:organaki_app/bloc/bloc_get_producer%20_user/get_a_producer_bloc.dart';
import 'package:organaki_app/bloc/bloc_register_user/register_user_bloc.dart';
import 'package:organaki_app/bloc/login_auth_bloc/login_auth_bloc.dart';
import 'package:organaki_app/core/routes.dart';
import 'package:organaki_app/models/singleton_user.dart';
import 'package:organaki_app/services/authentication_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organaki_app/services/producer_services.dart';
import 'package:organaki_app/services/shared_preferences_controller.dart';

import 'bloc/bloc_get_a_producer/get_a_producer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //REPOSITORIES THAT WILL BE USED
  var authRepo = AuthenticationRepository();
  var prodRepo = ProducerRepository();

  SharedPreferencesAuthController sharedPreferencesAuthController =
      SharedPreferencesAuthController();

  var response =
      await sharedPreferencesAuthController.readSharedPreferencesLogin();

  response.fold((success) => SingletonUser().setUserAuth(success),
      (failure) => debugPrint("Usuário ainda não logado"));

  

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LoginAuthBloc(authRepo),
      ),
      BlocProvider(
        create: (context) => GetListProducersBloc(prodRepo),
      ),
      BlocProvider(
        create: (context) => RegisterUserBloc(authRepo),
      ),
      BlocProvider(
        create: (context) => GetAProducerBloc(prodRepo),
      ),
      BlocProvider(
        create: (context) => GetListTagsBloc(prodRepo)..add(GetListTagsStart()),
      ),
      BlocProvider(
        create: (context) => EditProducerBloc(prodRepo),
      ),
      BlocProvider(
        create: (context) => GetProducerUserBloc(prodRepo),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: route,
      theme: ThemeData(useMaterial3: true),
    ),
  ));
}
