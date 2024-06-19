import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sakib/ui/screens/authentication/pin_verification_screen.dart';
import 'package:sakib/ui/utility/app_colors.dart';
import 'package:sakib/ui/widgets/backgroundwidget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit verification pin will sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: _onTapConfirmButton,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                  const SizedBox(
                    height: 36,
                  ),
                  _buildBackToSignInSection()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackToSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4),
          text: "Have account? ",
          children: [
            TextSpan(
                text: 'Sign In',
                style: const TextStyle(color: AppColors.themeColor),
                recognizer: TapGestureRecognizer()..onTap = _backToSignIn)
          ],
        ),
      ),
    );
  }

  void _backToSignIn() {
    Navigator.pop(context);
  }

  void _onTapConfirmButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PinVerificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
