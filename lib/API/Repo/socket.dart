import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

/// late StompClient stompClient;
void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/topic/messages',
    callback: (frame) {
      List<dynamic>? result = json.decode(frame.body!);
      print(result);
    },
  );

  Timer.periodic(Duration(seconds: 1), (_) {
    stompClient.send(
      destination: '/chat',
      body: json.encode({'a': 123}),
    );
    //  stompClient.send(
    //             destination: '/chat',
    //             body: 'Hello STOMP server!',
    //           );
  });
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://1eda-2405-201-200b-a0cf-1873-7431-8217-e7b0.ngrok.io/user/pdsChat',
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);

onConnectCallback(StompFrame connectFrame) {
  // client is connected and ready
  print("client is connected and ready");
  // stompClient.activate();
}

onErrorCallback(dynamic error) {
  print('Error connecting to STOMP server: $error');
  // Handle connection error
}


///set in On_Tap()
//  stompClient.send(
//                   destination: '/chat',
//                   body: json.encode({'from': "123", "text": userInput.text}),
//                 );