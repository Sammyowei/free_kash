import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderScopeContainer extends InheritedWidget {
  final ProviderContainer container;
  const ProviderScopeContainer(
      {required this.container, required super.child, super.key});

  static ProviderScopeContainer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderScopeContainer>();
  }

  @override
  bool updateShouldNotify(covariant ProviderScopeContainer oldWidget) {
    return container != oldWidget.container;
  }
}
