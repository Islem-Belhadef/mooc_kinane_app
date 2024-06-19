import 'package:klearn/components/text_input.dart';
import 'package:klearn/screens/login.dart';
import 'package:klearn/shared/data/constants.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/state/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/shared/styles/app_styles.dart';

import '../components/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        "S'inscrire",
                        style: AppStyles.headingTextStyle(),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextInput(
                          title: 'Addresse email',
                          controller: _emailController,
                          cubit: cubit,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextInput(
                          title: 'Mot de passe',
                          controller: _passwordController,
                          cubit: cubit,
                          suffix: true,
                          hidden: cubit.isObscure,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextInput(
                          title: 'Confirmer mot de passe',
                          controller: _confirmPasswordController,
                          cubit: cubit,
                          hidden: cubit.isObscure,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: PrimaryButton(title: "S'inscrire", fun: (){
                            cubit.register();
                          },
                            maxWidth: true,
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous avez déja un compte ?",
                            style: AppStyles.subtitleTextStyle(),
                          ),
                          TextButton(
                              onPressed: () => navigateTo(context, LoginScreen()),
                              child: Text(
                                'Se connecter',
                                style: AppStyles.subtitleTextStyle(
                                    color: AppStyles.primaryColor),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ou bien',
                        style: AppStyles.headingTextStyle(),
                      ),
                      Text(
                        "S'inscrire avec",
                        style: AppStyles.regularTextStyle(
                            color: AppStyles.subtitleColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => cubit.registerGoogle(),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Image.asset(
                                  'lib/assets/images/google.png',
                                  width: 32,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () => cubit.registerFacebook(),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Image.asset(
                                  'lib/assets/images/facebook.png',
                                  width: 32,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
