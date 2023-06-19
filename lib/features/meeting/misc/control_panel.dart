import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/widgets/action_button.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel(
      {Key key,
      this.videoEnabled,
      this.audioEnabled,
      this.isConnectionFailed,
      this.onVideoToggle,
      this.onAudioToggle,
      this.onReconnect,
      this.onMeetingEnd})
      : super(key: key);

  final bool videoEnabled;
  final bool audioEnabled;
  final bool isConnectionFailed;
  final VoidCallback onVideoToggle;
  final VoidCallback onAudioToggle;
  final VoidCallback onReconnect;
  final VoidCallback onMeetingEnd;

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildControls() {
      if (!isConnectionFailed) {
        return <Widget>[
          IconButton(
            onPressed: onVideoToggle,
            icon: Icon(videoEnabled ? Icons.videocam : Icons.videocam_off),
            color: UIColors.white,
            iconSize: 32.0,
          ),
          IconButton(
            onPressed: onAudioToggle,
            icon: Icon(audioEnabled ? Icons.mic : Icons.mic_off),
            color: UIColors.white,
            iconSize: 32.0,
          ),
          const SizedBox(width: 25),
          Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.red,
            ),
            child: IconButton(
              icon: Icon(
                Icons.call_end,
                color: UIColors.white,
              ),
              onPressed: onMeetingEnd,
            ),
          )
        ];
      } else {
        return [
          ActionButton(
              text: 'Reconnect',
              backgroundColor: UIColors.primary,
              textColor: UIColors.white,
              shape: ButtonShape.squircle,
              size: ButtonSizes.large,
              isLoading: false,
              onPressed: false == true ? null : onReconnect)
        ];
      }
    }

    return Container(
      color: Colors.blueGrey[900],
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildControls(),
      ),
    );
  }
}
