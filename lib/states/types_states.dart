enum AuthenticationStatusLogged {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}

//+++ UserOrder
enum UserOrder {
  displayName,
}

extension UserOrderExtension on UserOrder {
  static const names = {
    UserOrder.displayName: 'Nome',
  };
  String get name => names[this];
}
//--- UserOrder

//+++ PlataformOrder
enum PlataformOrder {
  codigo,
}
