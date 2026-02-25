import 'package:cloud_firestore/cloud_firestore.dart';

/// Records what a roommate actually paid in a given month, vs what they owed.
/// The delta (credit = actualPaid - owedAmount) carries forward to next month.
class PaymentRecord {
  final String? id;
  final String userName;
  final int month;
  final int year;
  final double owedAmount;   // What the app calculated they owe
  final double actualPaid;   // What they actually sent (Venmo, cash, etc.)
  final String? notes;
  final DateTime createdAt;

  const PaymentRecord({
    this.id,
    required this.userName,
    required this.month,
    required this.year,
    required this.owedAmount,
    required this.actualPaid,
    this.notes,
    required this.createdAt,
  });

  /// Positive = overpaid (credit toward next month).
  /// Negative = underpaid (debt added to next month).
  double get credit => actualPaid - owedAmount;

  bool get isOverpaid  => credit > 0.005;
  bool get isUnderpaid => credit < -0.005;

  factory PaymentRecord.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return PaymentRecord(
      id:          doc.id,
      userName:    d['userName']   as String,
      month:       d['month']      as int,
      year:        d['year']       as int,
      owedAmount:  (d['owedAmount'] as num).toDouble(),
      actualPaid:  (d['actualPaid'] as num).toDouble(),
      notes:       d['notes']      as String?,
      createdAt:   (d['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userName':   userName,
    'month':      month,
    'year':       year,
    'owedAmount': owedAmount,
    'actualPaid': actualPaid,
    'credit':     credit,
    'notes':      notes,
    'createdAt':  Timestamp.fromDate(createdAt),
  };

  PaymentRecord copyWith({
    double? owedAmount,
    double? actualPaid,
    String? notes,
  }) => PaymentRecord(
    id:          id,
    userName:    userName,
    month:       month,
    year:        year,
    owedAmount:  owedAmount  ?? this.owedAmount,
    actualPaid:  actualPaid  ?? this.actualPaid,
    notes:       notes       ?? this.notes,
    createdAt:   createdAt,
  );
}
