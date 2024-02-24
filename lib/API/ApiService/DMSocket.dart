import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../main.dart';

var DMChatInboxUid = "";
var DMbaseURL = "";

/// late StompClient stompClient;
void onConnect(StompFrame frame) {
  DMstompClient.subscribe(
    destination: "/topic/getInboxMessage/${DMChatInboxUid}",
    callback: (StompFrame frame) {
      print('Received message AA <->: ${frame.body}');
      // Process the received message
      Map<String, dynamic> jsonString = json.decode(frame.body ?? "");

      /* BlocProvider.of<DmInboxCubit>(navigatorKey.currentContext!)
          .updateInbox(jsonString); */
    },
  );

  DMstompClient.subscribe(
    destination: "/topic/getDeletedInboxMessage/${DMChatInboxUid}",
    callback: (StompFrame frame) {
      print('Received message Delete-: ${frame.body}');
      // Process the received message
    },
  );

  Timer.periodic(Duration(seconds: 5), (_) {
    DMstompClient.subscribe(
      destination: "/topic/getInboxMessage/${DMChatInboxUid}",
      callback: (StompFrame frame) {
        print('Received message AA ---->: ${frame.body}');
      },
    );

    DMstompClient.subscribe(
      destination: "/topic/getDeletedInboxMessage/${DMChatInboxUid}",
      callback: (StompFrame frame) {
        print(
            "Delete Meassge --------------------------------------------------------------------");
        print('Received message Delete --->: ${frame.body}');
        // Process the received message
      },
    );
  });
}

var DMstompClient = StompClient(
  config: StompConfig(
    url: DMbaseURL,
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
