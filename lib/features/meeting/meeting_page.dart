import 'package:flutter/material.dart';
import 'package:ua_mobile_health/features/home/doctor_dashboard.dart';
import 'package:ua_mobile_health/features/meeting/misc/control_panel.dart';
import 'package:ua_mobile_health/features/meeting/misc/meeting_model.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:ua_mobile_health/features/meeting/meeting_sdk/flutter_webrtc_wrapper.dart';
import 'package:ua_mobile_health/features/meeting/misc/remote_connection.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage(
      {Key key,
      @required this.hostUrl,
      @required this.userId,
      @required this.meetingId,
      @required this.name,
      @required this.meetingDetail})
      : super(key: key);

  final String hostUrl;
  final String userId;
  final String meetingId;
  final String name;
  final MeetingDetail meetingDetail;

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  final _localRenderer = RTCVideoRenderer();
  final Map<String, dynamic> mediaConstraints = {"audio": true, "video": true};
  bool isConnectionFailed = false;
  WebRTCMeetingHelper meetingHelper;

  Future<void> startMeeting() async {
    meetingHelper = WebRTCMeetingHelper(
      url: widget.hostUrl,
      meetingId: widget.meetingDetail.id,
      userId: widget.userId,
      name: widget.name,
    );

    MediaStream localStream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = localStream;
    meetingHelper.stream = localStream;
    if (context.mounted) {}
    meetingHelper.on(
      "open",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );
    meetingHelper.on(
      "connection",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );
    meetingHelper.on(
      "user-left", //TODO ither operation to do if any meeting member left the video cal or meeeting ,as to show popup saying perticular person have left the meeting or snakbar
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );
    meetingHelper.on(
      "video-toggle",
      context,
      (ev, context) {
        setState(() {});
      },
    );
    meetingHelper.on(
      "audio-toggle",
      context,
      (ev, context) {
        setState(() {});
      },
    );
    meetingHelper.on(
      "meeting-ended",
      context,
      (ev, context) {
        onMeetingEnd(); //TODO firebase delete Document
      },
    );
    meetingHelper.on(
      "connection-setting-changed",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );
    meetingHelper.on(
      "stream-changed",
      context,
      (ev, context) {
        setState(() {
          isConnectionFailed = false;
        });
      },
    );
    setState(() {});
  }

  initRenderers() async {
    await _localRenderer.initialize();
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
    startMeeting();
  }

  @override
  void deactivate() {
    super.deactivate();
    _localRenderer.dispose();
    if (meetingHelper != null) {
      meetingHelper.destroy();
      meetingHelper = null;
    }
  }

  void onMeetingEnd() {
    // deleting firestore data TODO
    if (meetingHelper != null) {
      meetingHelper.endMeeting();
      meetingHelper = null;
      goToHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _buildMeetingRoom(),
      bottomNavigationBar: ControlPanel(
        onAudioToggle: onAudioToggle,
        onVideoToggle: onVideoToggle,
        videoEnabled: isVideoEnabled(),
        audioEnabled: isAudioEnabled(),
        isConnectionFailed: isConnectionFailed,
        onReconnect: handleReconnect,
        onMeetingEnd: onMeetingEnd,
      ),
    );
  }

  void onAudioToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper.toggleAudio();
      });
    }
  }

  void onVideoToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper.toggleVideo();
      });
    }
  }

  void handleReconnect() {
    if (meetingHelper != null) {
      meetingHelper.reconnect();
    }
  }

  bool isAudioEnabled() {
    return meetingHelper != null ? meetingHelper.audioEnabled : false;
  }

  bool isVideoEnabled() {
    return meetingHelper != null ? meetingHelper.videoEnabled : false; //
  }

  void goToHomePage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DoctorDashboardPage()));
  }

  _buildMeetingRoom() {
    return Stack(
      children: [
        meetingHelper != null && meetingHelper.connections.isNotEmpty
            ? GridView.count(
                crossAxisCount: meetingHelper.connections.length < 3 ? 1 : 2,
                children:
                    List.generate(meetingHelper.connections.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: RemoteConnection(
                      renderer: meetingHelper.connections[index].renderer,
                      connection: meetingHelper.connections[index],
                    ),
                  );
                }))
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Waiting for participants to join the meeting",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 24),
                  ),
                ),
              ),
        //my local view TODO
        Positioned(
          bottom: 10,
          right: 0,
          child: SizedBox(
              width: 150, height: 200, child: RTCVideoView(_localRenderer)),
        )
      ],
    );
  }
}
