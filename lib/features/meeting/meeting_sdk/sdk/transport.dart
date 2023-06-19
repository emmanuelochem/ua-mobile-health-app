import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:eventify/eventify.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Transport extends EventEmitter {
  String url;
  bool canReconnect = false;
  int retryCount = 0;
  int maxRetryCount = 4;
  Timer timer;
  bool closed = false;
  IO.Socket socket;

  Transport({this.url, this.canReconnect, this.maxRetryCount});

  void connect() async {
    try {
      if (retryCount <= maxRetryCount) {
        retryCount++;
        socket = IO.io(url, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
        });

        //log(url);

        socket.connect();
        socket.onConnect((data) => {log('Connect: ${socket.id}')});
        socket.onConnectError((data) => log('Connect Error: $data'));
        socket.onDisconnect((data) => log('Socket.IO server disconnected'));
        listenEvents();
      } else {
        // log('failed-------');
        emit('failed');
      }
    } catch (error) {
      //log('error failed -------');
      // log(error.toString());
      connect();
    }
  }

  void listenEvents() {
    socket.emit(
        'message',
        json.encode({
          'type': 'joined-meeting',
          'data': {'message': 'Uche jombo'}
        }));
    socket.on("message", handleMessage);
    // socket.on("update-user-list", (data) => {log(data)});
    handleOpen();
  }

  void remoteEvents() {}

  void handleOpen() {
    sendHeartbeat();
    emit('open');
  }

  void handleMessage(dynamic data) {
    //log('handleMessage: $data');
    emit('message', null, data);
  }

  void handleClose() {
    reset();
    if (!closed) {
      connect();
    }
  }

  void handleError(Object error) {
    log(error.toString());
    reset();
    if (!closed) {
      connect();
    }
  }

  void send(dynamic data) {
    //log(data.toString());
    socket.emit("message", data);
  }

  void sendHeartbeat() {
    // timer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   send(json.encode({'type': 'heartbeat'}));
    // });
  }

  void reset() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  void close() {
    closed = true;
    destroy();
  }

  void destroy() {
    reset();
    url = '';
  }

  void reconnect() {
    retryCount = 0;
    connect();
  }
}
