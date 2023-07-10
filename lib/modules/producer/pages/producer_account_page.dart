import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organaki_app/bloc/bloc_get_producer%20_user/get_a_producer_bloc.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/models/singleton_user.dart';
import 'package:organaki_app/core/colors_app.dart';
import 'package:organaki_app/core/extensions.dart';
import 'package:organaki_app/services/shared_preferences_controller.dart';

class ProducerAccountPage extends StatefulWidget {
  const ProducerAccountPage({super.key});

  @override
  State<ProducerAccountPage> createState() => _ProducerAccountPageState();
}

class _ProducerAccountPageState extends State<ProducerAccountPage> {
  @override
  void initState() {
    BlocProvider.of<GetProducerUserBloc>(context)
        .add(GetProducerUserStart(id: SingletonUser().userAuth!.id!));
    super.initState();
  }

  late Producer producerUser;
  bool isProducerVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetProducerUserBloc, GetProducerUserState>(
        listener: (context, state) {
      if (state is GetProducerUserSuccess) {
        setState(() {
          producerUser = state.producer;
          isProducerVisible = producerUser.visible_producer;
        });
      }
    }, builder: (context, state) {
      if (state is GetProducerUserSuccess) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor: Colors.white,
            title: Text(
              "Conta",
              style: TextStyle(
                color: ColorApp.dark1,
                fontSize: 36,
                fontWeight: FontWeight.w600,
                fontFamily: 'Abhaya Libre',
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.sizeH,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 124.0,
                        height: 124.0,
                        decoration: BoxDecoration(
                          color: ColorApp.dark1,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          size: 62.0,
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Center(
                          child: Text(
                            producerUser.name,
                            style: TextStyle(
                              color: ColorApp.blue3,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Abhaya Libre',
                            ),
                          ),
                        ),
                        subtitle: Center(
                          child: Text(
                            producerUser.email,
                            style: TextStyle(
                              color: ColorApp.grey2,
                              fontSize: 15,
                              fontFamily: 'Abhaya Libre',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.sizeH,
                  const Row(
                    children: [],
                  ),
                  Text(
                    "General",
                    style: TextStyle(
                      color: ColorApp.blue3,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Abhaya Libre',
                    ),
                  ),
                  20.sizeH,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => context.push("/edit", extra: {
                          "producerUser": producerUser
                        }).whenComplete(() {
                          BlocProvider.of<GetProducerUserBloc>(context).add(
                              GetProducerUserStart(
                                  id: SingletonUser().userAuth!.id!));
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                "Edit information",
                                style: TextStyle(
                                  color: ColorApp.blue3,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Abhaya Libre',
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ColorApp.grey5,
                              )
                            ],
                          ),
                        ),
                      ),
                      10.sizeH,
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                "Enable notification",
                                style: TextStyle(
                                  color: ColorApp.blue3,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Abhaya Libre',
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ColorApp.grey5,
                              )
                            ],
                          ),
                        ),
                      ),
                      10.sizeH,
                      TextButton(
                        onPressed: () {
                          SingletonUser().removeUserAuth();
                          SharedPreferencesAuthController
                              .logoutSharedPreferences();
                          context.go('/account');
                          //TODO aplly flushbar logout here
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: ColorApp.blue3,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Abhaya Libre',
                          ),
                        ),
                      ),
                    ],
                  ),
                  35.sizeH,
                  !state.producer.visible_producer
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              5.sizeW,
                              const Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              10.sizeW,
                              const Flexible(
                                child: Text(
                                  "Para aparecer online para os clientes, é necessário informar todos os dados necessários",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
