import 'constants.dart';

class PriceCalculator {
  static Map<String, double> calculateTotal(double subtotal) {
    final serviceCharge = subtotal * AppConstants.serviceChargeRate;
    final totalAfterService = subtotal + serviceCharge;
    final pb1 = totalAfterService * AppConstants.pb1Rate;
    final grandTotal = totalAfterService + pb1;
    
    return {
      'subtotal': subtotal,
      'serviceCharge': serviceCharge,
      'pb1': pb1,
      'grandTotal': grandTotal,
    };
  }
  
  static String formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }
}