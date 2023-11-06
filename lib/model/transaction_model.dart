import 'dart:convert';

class TransactionModel {
  final String transactionType;
  final String transactionDate;
  final String description;
  final double amount;
  final String? category;
  final String? paymentMethod;
  final String? receiptUrl;

  TransactionModel({
    required this.transactionDate,
    required this.transactionType,
    required this.description,
    required this.amount,
    this.category,
    this.paymentMethod,
    this.receiptUrl,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionDate: json['transactionDate'],
      transactionType: json['transactionType'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      paymentMethod: json['paymentMethod'],
      receiptUrl: json['receiptUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionDate' : transactionDate,
      'transactionType' : transactionType,
      'description' : description,
      'amount' : amount.toDouble(),
      'category' : category,
      'paymentMethod' : paymentMethod,
      'receiptUrl' : receiptUrl,
    };
  }

  @override
  String toString() {
    return 'TransactionModel{'
        'transactionDate: $transactionDate, '
        'transactionType: $transactionType, '
        'description: $description, '
        'amount: $amount, '
        'category: $category, '
        'paymentMethod: $paymentMethod, '
        'receiptUrl: $receiptUrl'
        '}';
  }

}