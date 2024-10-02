import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { event_amber, event_purple }

class ColorBloc {
  Color _color = Colors.amber;

  final _inputEventController = StreamController<ColorEvent>();
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.event_amber)
      _color = const Color.fromARGB(255, 255, 111, 0);
    else if (event == ColorEvent.event_purple)
      _color = const Color.fromARGB(255, 74, 20, 140);
    else
      throw Exception("Wrong Event Type");

    _outputStateController.sink.add(_color);
  }

  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

//Почему закрывает контроллеры потому, что это обертка над потоками и через него и создается Stream
  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
