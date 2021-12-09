import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat_cod3r/core/models/chat_notification.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // PUSH Notification

  Future<void> init() async {
    _configureTerminated();
    _configureForeground();
    _configureBackground();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('all');

    String? token = await messaging.getToken();
    print("Token");
    print(token);
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {

    if(await _isAuthorized){
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }


  Future<void> _configureTerminated() async {
    if(await _isAuthorized){
      RemoteMessage? initialMsg =
        await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }


  Future<void> _configureBackground() async {
    if(await _isAuthorized){
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  void _messageHandler(RemoteMessage? msg) {
    if(msg == null || msg.notification == null) return;
    add(ChatNotification(
        title: msg.notification!.title ?? "No Message",
        body: msg.notification!.body ?? "No Body"
    ));
  }

}
