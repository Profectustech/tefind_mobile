import 'package:flutter/material.dart';

class StatefulBottomSheetContent extends StatefulWidget {
  final Widget firstState;
  final Widget secondState;
  final bool loading;

  const StatefulBottomSheetContent({
    super.key,
    required this.firstState,
    required this.secondState, required this.loading,
  });

  @override
  State<StatefulBottomSheetContent> createState() =>
      _StatefulBottomSheetContentState();
}

class _StatefulBottomSheetContentState
    extends State<StatefulBottomSheetContent> {



  @override
  Widget build(BuildContext context) {
    return !widget.loading ? widget.firstState : widget.secondState;
  }
}
