import 'package:flutter/material.dart';

import 'awesome_loading_view_model.dart';

/// AwesomeLoadingRoute
///
class AwesomeLoadingRoute extends OverlayRoute {
  bool _opaque;
  bool _maintainState;
  WidgetBuilder _widgetBuilder;

  /// AwesomeLoadingRoute
  ///
  AwesomeLoadingRoute({
    bool opaque = false,
    bool maintainState = false,
    WidgetBuilder builder,
  }) {
    _opaque = opaque;
    _maintainState = maintainState;
    _widgetBuilder = builder;
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      OverlayEntry(
        opaque: _opaque,
        maintainState: _maintainState,
        builder: (context) {
          return AwesomeLoadingWidget(
            opaque: _opaque,
            maintainState: _maintainState,
            builder: _widgetBuilder,
          );
        },
      ),
    ];
  }
}

/// AwesomeLoadingWidget
///
class AwesomeLoadingWidget extends StatefulWidget {
  bool _opaque;
  bool _maintainState;
  WidgetBuilder _widgetBuilder;

  AwesomeLoadingWidget({
    bool opaque = false,
    bool maintainState = false,
    WidgetBuilder builder,
  }) {
    _opaque = opaque;
    _maintainState = maintainState;
    _widgetBuilder = builder;
  }
  @override
  State<StatefulWidget> createState() {
    return AwesomeLoadingState();
  }
}

/// AwesomeLoadingState
///
class AwesomeLoadingState extends State<AwesomeLoadingWidget> {
  @override
  void initState() {
    super.initState();
    //add
    AwesomeLoadingViewModel.getInstance().addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    //remove
    AwesomeLoadingViewModel.getInstance().removeListener(_listener());
  }

  ///
  /// listener
  _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget._widgetBuilder == null
        ? Container()
        : widget._widgetBuilder(context);
  }
}
