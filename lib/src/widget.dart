import 'package:flutter/material.dart';
import 'package:eventor/src/provider.dart';
import 'package:provider/provider.dart';

/// A widget that provides access to the [BlocProvider] state and functionality.
/// It listens to changes in the provider and rebuilds the widget when the state changes.
class ProviderWidget<P extends BlocProvider, S extends BaseState> extends StatelessWidget {
  const ProviderWidget({super.key, required this.builder});

  /// A builder function that takes the [BuildContext], [provider], and [state] as arguments.
  final Widget Function(BuildContext context, P provider, S state) builder;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<P>(context);
    return builder(
      context,
      provider,
      provider.state as S, // Accessing state directly from provider
    );
  }
}
