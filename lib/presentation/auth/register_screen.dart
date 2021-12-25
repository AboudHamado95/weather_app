// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:weatherapp/components/components.dart';
import 'package:weatherapp/cubit/register/register_cubit.dart';
import 'package:weatherapp/cubit/register/register_states.dart';
import 'package:weatherapp/presentation/auth/login_screen.dart';
import 'package:weatherapp/presentation/screens/choose_city.dart';


class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState)
            return navigateAndFinish(context, ChooseCity());
            
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to know the weather forecast!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        defaultFormFeild(
                            controller: nameController,
                            type: TextInputType.name,
                            returnValidate: 'please enter your name!',
                            label: 'Name',
                            prefix: Icons.person,
                            onSubmit: (text) {}),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            returnValidate: 'please enter your email address!',
                            label: 'Email Address',
                            prefix: Icons.email,
                            onSubmit: (text) {}),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: RegisterCubit.get(context).suffix,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (text) {},
                            returnValidate: 'password is too short!',
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: phoneController,
                            type: TextInputType.phone,
                            returnValidate: 'please enter your phone!',
                            onSubmit: (text) {},
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(height: 30.0),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) {
                              return state is! RegisterLoadingState;
                            },
                            widgetBuilder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'register',
                                  isUpperCase: true,
                                ),
                            fallbackBuilder: (context) => Center(
                                  child: CircularProgressIndicator(),
                                )),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You have an account?',
                              ),
                              defaultTextButton(
                                  function: () {
                                    navigateAndFinish(context, LoginScreen());
                                  },
                                  text: 'LOGIN'),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
