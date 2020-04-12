import 'package:flutter/material.dart';

import 'progress_mix.dart';

/// CircularStateProgressIndicator
class CircularStateProgressIndicator extends StatefulWidget {
  bool _paint;
  Size _size;
  num _value;
  Color _pathColor;
  Color _valueColor;
  double _pathStrokeWidth;
  double _valueStrokeWidth;
  bool _fill;
  bool _useCenter;
  CircularStateProgressIndicator({
    Size size,
    num value,
    Color pathColor,
    Color valueColor = Colors.green,
    double pathStrokeWidth = 5,
    double valueStrokeWidth = 5,
    bool fill = false,
    bool useCenter = false,
  }) {
    _size = size;
    //value >= 0.00,value<=100
    _value = value;

    _pathColor = pathColor;
    _valueColor = valueColor;
    _pathStrokeWidth = pathStrokeWidth;
    _valueStrokeWidth = valueStrokeWidth;

    //
    _fill = fill;
    _useCenter = useCenter;
  }

  @override
  State<StatefulWidget> createState() {
    return _CircularStateProgressIndicatorState();
  }
}

class _CircularStateProgressIndicatorState
    extends State<CircularStateProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget._size,
      painter: CircularProgressPaint(
        shouldRepaint: false,
        min: 1,
        max: 100,
        value: widget._value,
        pathPaint: _getPathPaint(),
        valuePaint: _getValuePaint(),
        useCenter: widget._useCenter,
      ),
    );
  }

  Paint _getPathPaint() {
    return Paint()
      ..color = widget._pathColor
      ..strokeWidth = widget._pathStrokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = widget._fill ? PaintingStyle.fill : PaintingStyle.stroke;
  }

  Paint _getValuePaint() {
    return Paint()
      ..color = widget._valueColor
      ..strokeWidth = widget._valueStrokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = widget._fill ? PaintingStyle.fill : PaintingStyle.stroke;
  }
}

/// CircularProgressPaint
class CircularProgressPaint extends CustomPainter with ProgressMixin {
  final num maxSweepAngle = 6.5;
  final num minSweepAngle = 1.0;
  bool _shouldRepaint;
  num _min;
  num _max;
  num _value;
  Paint _pathPaint;
  Paint _valuePaint;
  bool _useCenter;

  /// CircularProgressPaint
  ///
  CircularProgressPaint({
    @required bool shouldRepaint,
    @required num min,
    @required num max,
    @required num value,
    @required Paint pathPaint,
    @required Paint valuePaint,
    @required bool useCenter,
  }) {
    _shouldRepaint = shouldRepaint;
    _min = min;
    _max = max;
    _value = value;
    _pathPaint = pathPaint;
    _valuePaint = valuePaint;
    _useCenter = useCenter;
  }
  @override
  void paint(Canvas canvas, Size size) {
    // draw progress path
    drawProgressPath(canvas: canvas, paint: _pathPaint, size: size);

    // draw progress value
    drawProgressValue(canvas: canvas, paint: _valuePaint, size: size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return _shouldRepaint;
  }

  @override
  drawProgressPath({Canvas canvas, Paint paint, Size size}) {
    Offset center = _getOffset(size: size);
    double radius = _getRadius(size: size);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  drawProgressValue({Canvas canvas, Paint paint, Size size}) {
    Offset center = _getOffset(size: size);
    double radius = _getRadius(size: size);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        _getStartAngle(), _getSweepAngle(), useCenter, paint);
  }

  double _getStartAngle() {
    return -1.5;
  }

  double _getSweepAngle() {
    if (_value == 0) {
      return 0;
    }
    if (_value > 0 && _value < 50) {
      return (_value * 0.0612);
    }
    if (_value == 50) {
      return _value * 0.0600;
    }
    if (_value > 50 && _value < 100) {}
    if (_value == 100) {
      return 6.5;
    }
    return (_value * 0.0615);
  }

  /// useCenter
  /// whether use center point close the path.
  bool get useCenter {
    return _useCenter;
  }

  double _getRadius({Size size}) {
    double radius =
        size.width / 2 < size.height / 2 ? size.width / 2 : size.height / 2;
    radius -= _valuePaint.strokeWidth / 2;
    return radius;
  }

  Offset _getOffset({Size size}) {
    return Offset(size.width / 2, size.height / 2);
  }
}
