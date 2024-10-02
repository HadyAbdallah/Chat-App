import 'package:chat_app/Blocs/bloc/auth_bloc.dart';
import 'package:chat_app/Cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/Pages/ChatPage.dart';
import 'package:chat_app/Widgets/CustomButton.dart';
import 'package:chat_app/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Helper/ShowSnakBar.dart';
import '../constans.dart';
import 'Register.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoding = false;
  static String id = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoding = true;
        } else if (state is LoginSuccess) {
          ShowSnakBar(context, 'Succes Login');
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoding = false;
        } else if (state is LoginFailure) {
          ShowSnakBar(context, state.message);
          isLoding = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoding,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey,
              child: ListView(children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'E-Mail',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                  obscure: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context)
                          .add(LoginEvent(email: email!, password: password!));
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(
                          color: Color(0xffc7ede6),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
