import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nehemiah/login/login.dart';
import 'package:nehemiah/sign_up/sign_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:apple_sign_in/apple_sign_in.dart' as apple;
import 'package:nehemiah/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: ListView(
          //mainAxisSize: MainAxisSize.min,
          padding: EdgeInsets.all(20.0),
          children: [
//            Image.asset(
//              'assets/images/logo.png',
//              height: 120,
//            ),

            const SizedBox(height: 16.0),
            _Title(),
            const SizedBox(height: 16.0),
            _AppleLoginButton(),
            const SizedBox(height: 16.0),
            _GoogleLoginButton(),
            const SizedBox(height: 16.0),
            _GuestLoginButton(),
            const SizedBox(height: 16.0),
            _OrTitle(),
            const SizedBox(height: 8.0),
            _EmailInput(),
            const SizedBox(height: 8.0),
            _PasswordInput(),
            const SizedBox(height: 8.0),
            _LoginButton(),
//            const SizedBox(height: 8.0),
//            _GoogleLoginButton(),
//            const SizedBox(height: 8.0),
//            _GuestLoginButton(),
            const SizedBox(height: 4.0),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Login to Your Account.",
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(color: Theme.of(context).accentColor),
    );
  }
}

class _OrTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "- OR -",
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(color: Theme.of(context).accentColor, fontSize: 12.0),
    );
  }
}

class _LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _GoogleLoginButton(),
        _AppleLoginButton(),
        _GuestLoginButton(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.bloc<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'email',
                helperText: '',
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            ));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.bloc<LoginCubit>().passwordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                errorStyle: theme.textTheme.subtitle1
                    .copyWith(fontSize: 12.0, color: theme.primaryColor),
                labelText: 'password',
                helperText: '',
                errorText: state.password.invalid
                    ? 'invalid password.\nMinimum 8 characters with at least one number.'
                    : null,
              ),
            ));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()])
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  child: Text('Login To Your Account',
                      style: theme.textTheme.subtitle1
                          .copyWith(fontSize: 12.0, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    // background color
                    primary: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),

                  //color: const Color(0xFFFFD600),

                  onPressed: state.status.isValidated
                      ? () => context.bloc<LoginCubit>().logInWithCredentials()
                      : null,
                )
              ]);
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RaisedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: Text(
        'Login with Google',
        style: theme.textTheme.subtitle1
            .copyWith(fontSize: 12.0, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      color: theme.accentColor,
      onPressed: () => context.bloc<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);

    if (appleSignInAvailable.isAvailable)
      return apple.AppleSignInButton(
        style: apple.ButtonStyle.black, // style as needed
        type: apple.ButtonType.signIn, // style as needed
        onPressed: () => context.bloc<LoginCubit>().logInWithApple(),
      );
    else
      return Container();
  }
}

class _GuestLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RaisedButton(
      key: const Key('loginForm_guestLogin_raisedButton'),
      child: Text(
        'Login as Guest',
        style: theme.textTheme.subtitle1
            .copyWith(fontSize: 12.0, fontWeight: FontWeight.w900),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      color: Colors.white,
      onPressed: () => context.bloc<LoginCubit>().loginAnonymously(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FlatButton(
      key: const Key('loginForm_createAccount_flatButton'),
      child: Text(
        'Sign Up with Email',
        style: theme.textTheme.subtitle1
            .copyWith(fontSize: 12.0, fontWeight: FontWeight.w900),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );
  }
}
