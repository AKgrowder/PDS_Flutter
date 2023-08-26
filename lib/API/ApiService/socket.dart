import 'dart:async';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

var Room_ID_stomp = "";

/// late StompClient stompClient;
void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: "/topic/getMessage/${Room_ID_stomp}",
    // "user/topic/messages",
    //  'user/topic/getMessage/${Room_ID}',
    callback: (StompFrame frame) {
      print('Received message AA-: ${frame.body}');
      // Process the received message
    },
  );
//   stompClient.subscribe(
//     destination: '/topic/messages',
//     callback: (frame) {
//       List<dynamic>? result = json.decode(frame.body!);
//       print(result);
//     },
//   );

  Timer.periodic(Duration(seconds: 5), (_) {
    print("Call Send++++++++++++++++++++++++++++++++++++++++++++++++++++");
    stompClient.subscribe(
      destination: "/topic/getMessage/${Room_ID_stomp}",
      // "user/topic/messages",
      //  'user/topic/getMessage/${Room_ID}',
      callback: (StompFrame frame) {
        print('Received message AA-: ${frame.body}');
        // Process the received message
      },
    );
    // stompClient.send(
    //   destination: "/chat",
    //   // 'user/app/sendMessage/${Room_ID}',
    //   body: json.encode({
    //     "message": "Archit 1",
    //     "messageType": "asd",
    //     "roomUid": "${Room_ID}"
    //   }),  
    // );
  });
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://192.168.29.17:8081/user/pdsChat',

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