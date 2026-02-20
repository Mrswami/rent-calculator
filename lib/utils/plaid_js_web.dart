import 'dart:js_interop';

@JS('openPlaidLink')
external void _openPlaidLinkJs(
  JSString linkToken,
  JSFunction onSuccess,
  JSFunction onExit,
);

/// Web implementation of Plaid Link JS integration.
void openPlaidLink({
  required String linkToken,
  required void Function(String publicToken, String metadata) onSuccess,
  required void Function(String? error, String metadata) onExit,
}) {
  void onSuccessJs(JSAny? pubTokenJs, JSAny? metaJs) {
    final publicToken = (pubTokenJs as JSString?)?.toDart ?? '';
    final metadata = (metaJs as JSString?)?.toDart ?? '{}';
    onSuccess(publicToken, metadata);
  }

  void onExitJs(JSAny? errJs, JSAny? metaJs) {
    final errStr = (errJs as JSString?)?.toDart;
    final metadata = (metaJs as JSString?)?.toDart ?? '{}';
    onExit(errStr, metadata);
  }

  _openPlaidLinkJs(
    linkToken.toJS,
    onSuccessJs.toJS,
    onExitJs.toJS,
  );
}
