class Calculation {
  final int? id;
  final double capital;
  final double term;
  final double rate;
  final double interest;
  final DateTime date;

  Calculation({
    this.id,
    required this.capital,
    required this.term,
    required this.rate,
    required this.interest,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'capital': capital,
      'term': term,
      'rate': rate,
      'interest': interest,
      'date': date.toIso8601String(),
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      id: map['id'],
      capital: map['capital'],
      term: map['term'],
      rate: map['rate'],
      interest: map['interest'],
      date: DateTime.parse(map['date']),
    );
  }
}
