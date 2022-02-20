import 'package:flutter/material.dart';
import 'package:hospitalize/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const routeName = '/login-screen';

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Divider(
              color: Colors.red,
              thickness: 5,
              height: 50,
            ),
            const Expanded(child: SizedBox()),
            Flexible(
              fit: FlexFit.loose,
              child: Image.asset(
                'assets/logo.png',
                height: 200,
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: OutlinedButton(
                onPressed: () async {
                  await service.signInWithGoogle(context: context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage("assets/google.png"),
                        height: 35.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
