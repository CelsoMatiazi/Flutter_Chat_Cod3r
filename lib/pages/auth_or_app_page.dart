import 'package:flutter_chat_cod3r/core/models/chat_user.dart';
import 'package:flutter_chat_cod3r/core/services/auth/auth_service.dart';
import 'package:flutter_chat_cod3r/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'auth_page.dart';
import 'chat_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
