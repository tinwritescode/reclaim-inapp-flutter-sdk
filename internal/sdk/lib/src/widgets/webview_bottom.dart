import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../assets/assets.dart';

import '../controller.dart';
import '../usecase/usecase.dart';
import 'fonts_loaded.dart';
import 'svg_icon.dart';

class WebviewBottomBar extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final MainAxisSize mainAxisSize;

  /// If null, the sessionId will be fetched from [VerificationController.of(context).request.sessionInformation.sessionId].
  final String? sessionId;

  const WebviewBottomBar({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    this.mainAxisSize = MainAxisSize.max,
    this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    // late initialized to avoid use when sessionId is provided
    late final verificationController = VerificationController.of(context);
    final sessionId = this.sessionId?.isNotEmpty == true ? this.sessionId : null;

    const sessionLabelStyle = TextStyle(
      fontSize: 12,
      color: Color(0x88000000),
      fontWeight: FontWeight.w400,
      height: 1.35,
    );
    return FutureBuilder<SessionStartResponse?>(
      // no need to wait for session start if sessionId is provided
      future: sessionId != null ? null : verificationController.sessionStartFuture,
      builder: (context, snapshot) {
        final sessionId =
            this.sessionId ??
            snapshot.data?.sessionInformation.sessionId ??
            verificationController.maybeIdentity?.sessionId;
        return GestureDetector(
          onTap: () {
            if (sessionId == null) return;
            Clipboard.setData(ClipboardData(text: sessionId)).then((_) {
              Fluttertoast.showToast(msg: 'Copied to your clipboard!');
            });
          },
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: mainAxisSize,
              children: [
                const SvgImageIcon($ReclaimAssetImageProvider.shieldTick, color: Color(0x66292929), size: 19),
                const SizedBox(width: 8),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 15),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AnimatedSwitcher(
                        duration: Durations.short4,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: FontsLoaded(
                          child: Text.rich(
                            TextSpan(
                              text: (sessionId != null && sessionId.isNotEmpty)
                                  ? sessionId // fmt
                                  : 'Proofs generated by Reclaim Protocol are secure and private.',
                              children: [
                                if (sessionId != null && sessionId.isNotEmpty)
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 2.0),
                                      child: const Icon(Icons.copy_rounded, color: Color(0x88000000), size: 14),
                                    ),
                                  ),
                              ],
                            ),
                            key: ValueKey('${context.hashCode}-$sessionId'),
                            style: sessionLabelStyle,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
