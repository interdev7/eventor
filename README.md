
# Eventor

**Eventor** is a lightweight state management solution for Flutter, inspired by the BLoC pattern. It simplifies event handling and state management with a minimalistic API, making it ideal for small to medium-sized applications. Easily register events, update states, and react to changes with minimal boilerplate code.

## Features

- Lightweight and easy-to-use
- Inspired by the BLoC pattern but simplified
- Minimal boilerplate for handling events and states
- Supports event-driven architecture
- Seamless integration with `Provider`

## Installation

To add `eventor` to your project, simply add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  eventor: ^1.0.0
```

## Basic Usage

### 1. Define Events and States

You need to define events and states for your application. Extend `BaseEvent` for events and `BaseState` for states.

#### Example:

```dart
// Define an event
class LoadDataEvent extends BaseEvent {}

// Define a state
class DataLoadedState extends BaseState {
  final String data;
  DataLoadedState(this.data);
}
```

### 2. Create a BlocProvider

Create a custom `BlocProvider` that handles the events and emits new states.

#### Example:

```dart
class DataBloc extends BlocProvider<LoadDataEvent, DataLoadedState> {
  DataBloc() : super(DataLoadedState('Initial Data'));

  @override
  Future<void> _handleEvent(LoadDataEvent event) async {
    // Handle the event, e.g., fetch data from an API
    emit(DataLoadedState('Fetched Data'));
  }
}
```

### 3. Register Event Handlers

Use the `on` method to register event handlers for specific event types.

#### Example:

```dart
class DataBloc extends BlocProvider<LoadDataEvent, DataLoadedState> {
  DataBloc() : super(DataLoadedState('Initial Data')) {
    on<LoadDataEvent>((event) async {
      // Handle the event here
      emit(DataLoadedState('Fetched Data'));
    });
  }
}
```

### 4. Using the Bloc in Your Widget

Use the `ProviderWidget` to bind the `BlocProvider` and listen for state changes.

#### Example:

```dart
ProviderWidget<DataBloc, DataLoadedState>(
  builder: (context, bloc, state) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventor Example')),
      body: Center(
        child: Text(state.data),
      ),
    );
  },
)
```

### 5. Triggering Events

To trigger an event and update the state, use the `add` method of the `BlocProvider`.

#### Example:

```dart
Provider.of<DataBloc>(context, listen: false).add(LoadDataEvent());
```

## API Reference

### BlocProvider

`BlocProvider<E extends BaseEvent, S extends BaseState>`

A base class for the event-driven state management. Use this class to create your own BLoC-like providers.

#### Methods:
- `add(E event)`: Add an event to be processed by the provider.
- `setState(S newState)`: Update the state of the provider and notify listeners.
- `on<T extends E>(Future<void> Function(T event) handler)`: Register event handlers for specific event types.

### ProviderWidget

`ProviderWidget<P extends BlocProvider, S extends BaseState>`

A widget that listens to changes in the `BlocProvider` and rebuilds the UI accordingly.

#### Parameters:
- `builder`: A function that takes the context, provider, and state as arguments and returns a widget to build.

### BaseEvent

`BaseEvent` is the base class for all events in the application. Extend this class to define your own events.

### BaseState

`BaseState` is the base class for all states in the application. Extend this class to define your own states.

## Contributing

We welcome contributions! Feel free to open issues or submit pull requests. When contributing, please follow the standard coding conventions and add tests where applicable.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
