import 'dart:async';

import '../../utils/provider_performance_report.dart';

import 'callback.dart';
export 'callback.dart';

typedef OnZKComputePerformanceReportCallback = FutureOr<void> Function(ZKComputePerformanceReport report);

/// Defines an interface for zero-knowledge operations in the attestation process.
///
/// Implementations of this class provide the ability to check support for operations,
/// determine readiness, and compute results for zero-knowledge proofs.
///
/// See also [AttestorZkOperatorWithCallback] for a default implementation that uses callbacks.
abstract class AttestorZkOperator {
  const AttestorZkOperator();

  /// Checks if the specified function is supported with the given arguments.
  ///
  /// Returns `true` if the function is supported, `false` otherwise.
  FutureOr<bool> isSupported(String fnName, Object? args);

  /// Computes the result of the specified function with the given arguments.
  ///
  /// Returns a string representation of the computation result.
  FutureOr<String> compute(String fnName, List<dynamic> args, OnZKComputePerformanceReportCallback onPerformanceReport);

  /// Checks if the runtime platform is supported for the operator.
  ///
  /// Returns `true` if the platform is supported, `false` otherwise.
  Future<bool> isPlatformSupported();
}
