import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import 'logger.dart';

/// Example of how to use the logger in a StatelessWidget
class LoggerExampleWidget extends ConsumerWidget {
  /// Creates a logger example widget
  const LoggerExampleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Option 1: Get logger through extension
    ref.logger.i('Building LoggerExampleWidget');
    
    // Option 2: Get logger through provider
    final logger = ref.read(loggerProvider);
    logger.d('This is a debug message');
    
    return Scaffold(
      appBar: AppBar(title: const Text('Logger Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            try {
              // Simulate an error
              throw Exception('This is a test error');
            } catch (e, stackTrace) {
              // Log the error with stack trace
              ref.logger.e('An error occurred', e, stackTrace);
            }
          },
          child: const Text('Test Error Logging'),
        ),
      ),
    );
  }
}

/// Example of how to use the logger in a provider/service
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier(ref);
});

/// Example state notifier that uses logging
class CounterNotifier extends StateNotifier<int> {
  /// Reference for accessing providers
  final Ref ref;
  
  /// Creates a counter notifier
  CounterNotifier(this.ref) : super(0) {
    // Log when the notifier is created
    ref.logger.i('CounterNotifier created');
  }
  
  /// Increment the counter
  void increment() {
    ref.logger.d('Incrementing counter from $state to ${state + 1}');
    state++;
  }
  
  /// Decrement the counter
  void decrement() {
    ref.logger.d('Decrementing counter from $state to ${state - 1}');
    state--;
  }
  
  @override
  void dispose() {
    ref.logger.i('CounterNotifier disposed');
    super.dispose();
  }
} 