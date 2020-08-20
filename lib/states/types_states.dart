enum AuthenticationStatusLogged {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}

//+++ UserOrder
enum UserOrder {
  name,
}

extension UserOrderExtension on UserOrder {
  static const names = {
    UserOrder.name: 'Nome',
  };
  String get label => names[this];
}
//--- UserOrder

//+++ InfoCodeOrder
enum InfoCodeOrder {
  code,
  name,
  unit,
  infoIndOwnerCode,
}

extension InfoCodeOrderExtension on InfoCodeOrder {
  static const names = {
    InfoCodeOrder.code: 'Codigo',
    InfoCodeOrder.name: 'Nome',
    InfoCodeOrder.unit: 'Unidade',
    InfoCodeOrder.infoIndOwnerCode: 'Organizador',
  };
  String get label => names[this];
}
//--- InfoCodeOrder
