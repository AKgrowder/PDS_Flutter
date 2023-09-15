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
  getAPI();
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
    url:
        // 'ws://b71b-2405-201-200b-a0cf-e57b-ed1f-25d4-f1ec.ngrok.io/user/pdsChat',
        'ws://192.168.29.100:8081/user/pdsChat',
// "ws://https://uat.packagingdepot.store/user/pdsChat",
        // "${baseURL}",
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

getAPI() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  baseURL = prefs.getString(PreferencesKey.SocketLink) ?? "";
  dynamic yes = [['xbvfsdvgfsdfg ']];

  prefs.setStringList('key',yes);
}

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
