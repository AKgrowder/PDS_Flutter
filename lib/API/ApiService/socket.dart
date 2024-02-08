import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../core/utils/sharedPreferences.dart';

var Room_ID_stomp = "";
var baseURL = "";

/// late StompClient stompClient;
void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: "/topic/getMessage/${Room_ID_stomp}",
    callback: (StompFrame frame) {
      print('Received message AA <->: ${frame.body}');
      // Process the received message
    },
  );

  stompClient.subscribe(
    destination: "/topic/getDeletedMessage/${Room_ID_stomp}",
    callback: (StompFrame frame) {
      print('Received message Delete-: ${frame.body}');
      // Process the received message
    },
  );

  Timer.periodic(Duration(seconds: 5), (_) {
    

    stompClient.subscribe(
      destination: "/topic/getMessage/${Room_ID_stomp}",
      callback: (StompFrame frame) {
        print('Received message AA ---->: ${frame.body}');
      },
    );

    stompClient.subscribe(
      destination: "/topic/getDeletedMessage/${Room_ID_stomp}",
      callback: (StompFrame frame) {
        print("Delete Meassge --------------------------------------------------------------------");
        print('Received message Delete --->: ${frame.body}');
        // Process the received message
      },
    );
  });
}

final stompClient = StompClient(
  config: StompConfig(
    url:
        // "ws://d91d-2405-201-200b-a0cf-d0c7-a57a-7eba-c736.ngrok.io/user/pdsChat",
    baseURL,
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

/// ------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
var roomUid = "";
var DeleteMSg_baseURL = "";



/// late StompClient stompClient;
void Delet_onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: "/topic/getDeletedMessage/{$roomUid}",
    callback: (StompFrame frame) {
      print('Received message AA-: ${frame.body}');
      // Process the received message
    },
  );

  Timer.periodic(Duration(seconds: 8), (_) {
    print(
        "Delete MSG Socket -------------------------------------------------");
    stompClient.subscribe(
      destination: "/topic/getDeletedMessage/{$roomUid}",
      callback: (StompFrame frame) {
        print('Received message AA-: ${frame.body}');
      },
    );
  });
}

final Delet_stompClient = StompClient(
  config: StompConfig(
      url: "/topic/getDeletedMessage/${roomUid}",
      onConnect: Delet_onConnect,
      beforeConnect: () async {
        print('Delete MSG Socket waiting to connect...');
        await Future.delayed(Duration(
          milliseconds: 200,
        ));
        print('Delete MSG Socket connecting...');
      },
      onWebSocketError: (dynamic error) => {
            print("Delete MSG Socket issue"),
            print(error.toString()),
          }),
);

Delet_onConnectCallback(StompFrame connectFrame) {
  // client is connected and ready
  print("client is connected and ready");
  // stompClient.activate();
}

Delet_onErrorCallback(dynamic error) {
  print('Error connecting to STOMP server: $error');
  // Handle connection error
}
 */