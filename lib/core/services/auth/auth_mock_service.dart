import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_chat_cod3r/core/models/chat_user.dart';
import 'package:flutter_chat_cod3r/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService{

  static final Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>?  _controller;
  static final  _userStream = Stream<ChatUser?>.multi((controller){
    _controller = controller;
    _updateUser(null);

  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async{
    _updateUser(_users['email']);
  }

  @override
  Future<void> signup(String name, String email, String password, File image) async{
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image.path,
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> logout() async{
    _updateUser(null);
  }


  static void _updateUser(ChatUser? user){
    _currentUser = user;
    _controller?.add(_currentUser);
  }


}