import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';

class RemoteConnection extends StatefulWidget {
  const RemoteConnection(
      {Key key, @required this.renderer, @required this.connection})
      : super(key: key);

  final RTCVideoRenderer renderer;
  final Connection connection;

  @override
  State<RemoteConnection> createState() => _RemoteConnectionState();
}

class _RemoteConnectionState extends State<RemoteConnection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: RTCVideoView(
            widget.renderer,
            mirror: false,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
        ),
        Container(
          color: widget.connection.videoEnabled
              ? Colors.transparent
              : Colors.blueGrey[900],
          child: Text(
            widget.connection.videoEnabled ? '' : widget.connection.name,
            style: TypographyStyle.bodyMediumn.copyWith(
              color: UIColors.white,
              fontSize: 30.sp,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.all(5),
            color: widget.connection.videoEnabled
                ? Colors.transparent
                : Colors.blueGrey[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.connection.name,
                  style: TypographyStyle.bodyMediumn.copyWith(
                    color: UIColors.white,
                    fontSize: 15.sp,
                  ),
                ),
                Icon(
                  widget.connection.audioEnabled ? Icons.mic : Icons.mic_off,
                  color: UIColors.white,
                  size: 15.sp,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
