enum BiometricResult {
  success,

  /// The user cancelled or the fingerprint didn't match.
  failed,

  /// No fingerprint hardware or none enrolled on this device.
  unavailable,
}
