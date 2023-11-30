import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../core/utils/sharedPreferences.dart';

var DMChatInboxUid = "";
var DMbaseURL = "";

/// late StompClient stompClient;
void onConnect(StompFrame frame) {
  DMstompClient.subscribe(
    destination: "/topic/getMessage/${DMChatInboxUid}",
    callback: (StompFrame frame) {
      print('Received message AA <->: ${frame.body}');
      // Process the received message
    },
  );

  DMstompClient.subscribe(
    destination: "/topic/getDeletedMessage/${DMChatInboxUid}",
    callback: (StompFrame frame) {
      print('Received message Delete-: ${frame.body}');
      // Process the received message
    },
  );

  Timer.periodic(Duration(seconds: 5), (_) {
    print("Room Socket ++++++++++++++++++++++++++++++++++++++++++++++++++++");

    DMstompClient.subscribe(
      destination: "/topic/getMessage/${DMChatInboxUid}",
      callback: (StompFrame frame) {
        print('Received message AA ---->: ${frame.body}');
      },
    );

    DMstompClient.subscribe(
      destination: "/topic/getDeletedMessage/${DMChatInboxUid}",
      callback: (StompFrame frame) {
        print("Delete Meassge --------------------------------------------------------------------");
        print('Received message Delete --->: ${frame.body}');
        // Process the received message
      },
    );
  });
}

final DMstompClient = StompClient(
  config: StompConfig(
    url:
        // "ws://d91d-2405-201-200b-a0cf-d0c7-a57a-7eba-c736.ngrok.io/user/pdsChat",
    DMbaseURL,
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(
        milliseconds: 200,
      ));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(
      error.toString(),
    ),
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
