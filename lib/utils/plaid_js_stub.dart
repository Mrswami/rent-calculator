/// Stub for non-web platforms.
void openPlaidLink({
  required String linkToken,
  required void Function(String publicToken, String metadata) onSuccess,
  required void Function(String? error, String metadata) onExit,
}) {
  // Do nothing on native platforms as Plaid Link Web isn't supported here.
  throw UnsupportedError('Plaid Link Web can only be opened on the web.');
}
