import 'package:flutter/material.dart';

/// A base class for events in the BLoC pattern.
abstract class BaseEvent {
  // Represents a base event in the BLoC pattern.
}

/// A base class for states in the BLoC pattern.
abstract class BaseState {
  // Represents a base state in the BLoC pattern.
}

/// Mixin for handling events. It stores event handlers and provides a way to register and call them.
mixin EventHandler<E extends BaseEvent> {
  /// A map to store event handlers, where the key is the event type and the value is the handler function.
  final Map<Type, Future<void> Function(E)> _eventHandlers = {};

  /// Registers an event handler for a specific event type [T].
  ///
  /// Example usage:
  /// ```dart
  /// blocProvider.on<MyEvent>((event) => handleMyEvent(event));
  /// ```
  void on<T extends E>(Future<void> Function(T event) handler) {
    _eventHandlers[T] = (event) => handler(event as T);
  }

  /// Handles an event by calling the registered handler.
  /// Throws an [UnimplementedError] if no handler is found for the event type.
  ///
  /// Example usage:
  /// ```dart
  /// blocProvider.handleEvent(myEvent);
  /// ```
  Future<void> handleEvent(E event) async {
    final handler = _eventHandlers[event.runtimeType];
    if (handler != null) {
      await handler(event);
    } else {
      throw UnimplementedError('No handler found for event: ${event.runtimeType}');
    }
  }
}

/// A base provider class that mimics the BLoC pattern.
/// It combines event handling and state management.
abstract class BlocProvider<E extends BaseEvent, S extends BaseState> extends ChangeNotifier with EventHandler<E> {
  /// Current state of the provider.
  S _state;
  S get state => _state;

  /// Constructor that takes an initial state.
  BlocProvider(this._state);

  /// Emits a new state and notifies listeners.
  ///
  /// Example usage:
  /// ```dart
  /// blocProvider.emit(LoadedState("Data loaded"));
  /// ```
  @protected
  void emit(S newState) {
    _state = newState;
    notifyListeners();
  }

  /// Adds an event to the provider.
  /// It will trigger the appropriate handler for the event.
  ///
  /// Example usage:
  /// ```dart
  /// blocProvider.add(UserActionEvent("button_clicked"));
  /// ```
  @protected
  Future<void> add(E event) async {
    await handleEvent(event);
  }
}
