import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:organaki_app/bloc/bloc_register_user/register_user_bloc.dart';
import 'package:organaki_app/core/extensions.dart';
import 'package:organaki_app/core/colors_app.dart';
import 'package:organaki_app/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future editImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //final String _profileImage = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Processar o registro do usuário
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      // Aqui você pode fazer o que quiser com as informações do usuário, como enviar para um servidor, salvar localmente, etc.

      BlocProvider.of<RegisterUserBloc>(context)
          .add(RegisterUserStart(User("", "", fullName, email, password)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.chevron_left,
              color: ColorApp.black,
              size: 35,
              weight: 10,
            )),
        backgroundColor: ColorApp.white1,
      ),
      body: BlocListener<RegisterUserBloc, RegisterUserState>(
        listener: (context, state) {
          if (state is RegisterUserFailure) {
            //TODO  call flushbar here
            print("Falhou na requisição");
          }
          if (state is RegisterUserSuccess) {
            Navigator.pop(context);
            //TODO  call flushbar here
            print("Deu certo na requisição");
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(21.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: getImage,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    backgroundImage: FileImage(_image!),
                                    radius: 50,
                                    backgroundColor: ColorApp.blue3,
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: ColorApp.white1,
                                    ),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorApp.black,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(7),
                                child: Icon(
                                  Icons.edit,
                                  size: 25,
                                  color: ColorApp.white1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Coloque uma foto de perfil!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorApp.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Crie sua conta',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: ColorApp.black,
                          fontFamily: 'Abhaya Libre',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Nome completo',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                      fontFamily: 'Abhaya Libre',
                    ),
                  ),
                  10.sizeH,
                  Container(
                    alignment: Alignment.center,
                    width: 368.0,
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: ColorApp.white4,
                        hintText: "Insira seu nome completo",
                        hintStyle: TextStyle(
                          color: ColorApp.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                    ),
                  ),
                  15.sizeH,
                  Text(
                    'E-mail',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                      fontFamily: 'Abhaya Libre',
                    ),
                  ),
                  10.sizeH,
                  SizedBox(
                    width: 368.0,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: ColorApp.white4,
                        hintText: "Insira seu e-mail",
                        hintStyle: TextStyle(
                          color: ColorApp.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                    ),
                  ),
                  15.sizeH,
                  Text(
                    'Senha',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                      fontFamily: 'Abhaya Libre',
                    ),
                  ),
                  10.sizeH,
                  SizedBox(
                    width: 368.0,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: ColorApp.white4,
                        hintText: "Insira sua senha",
                        hintStyle: TextStyle(
                          color: ColorApp.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                    ),
                  ),
                  15.sizeH,
                  Text(
                    'Confirme sua senha',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                      fontFamily: 'Abhaya Libre',
                    ),
                  ),
                  10.sizeH,
                  SizedBox(
                    width: 368.0,
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: ColorApp.white4,
                        hintText: "Insira sua senha novamente",
                        hintStyle: TextStyle(
                          color: ColorApp.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Abhaya Libre',
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        if (value != _passwordController.text) {
                          return 'Essa senha não corresponde.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.blue3,
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: ColorApp.white1,
                            fontFamily: 'Abhaya Libre'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        fixedSize: const Size(348, 58),
                      ),
                      child: BlocBuilder<RegisterUserBloc, RegisterUserState>(
                        builder: (context, state) {
                          if (state is RegisterUserProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            "Cadastre-se",
                            style: TextStyle(
                              color: ColorApp.white1,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Abhaya Libre',
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
