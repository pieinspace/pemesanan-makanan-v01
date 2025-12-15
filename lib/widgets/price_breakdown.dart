import 'package:flutter/material.dart';
import '../utils/price_calculator.dart';

class PriceBreakdown extends StatelessWidget {
  final double subtotal;
  final VoidCallback onCheckout;

  const PriceBreakdown({
    super.key,
    required this.subtotal,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final breakdown = PriceCalculator.calculateTotal(subtotal);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPriceRow(
            'Subtotal',
            breakdown['subtotal']!,
            isBold: false,
          ),
          _buildPriceRow(
            'Service Charge (7.5%)',
            breakdown['serviceCharge']!,
            isBold: false,
          ),
          _buildPriceRow(
            'PB1 (10%)',
            breakdown['pb1']!,
            isBold: false,
          ),
          const Divider(height: 20, thickness: 2),
          _buildPriceRow(
            'Total Pembayaran',
            breakdown['grandTotal']!,
            isBold: true,
            isTotal: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    double amount, {
    required bool isBold,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.orange.shade700 : Colors.black87,
            ),
          ),
          Text(
            PriceCalculator.formatCurrency(amount),
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.orange.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}