class PromoVoucher {
  final String title;
  final String code;
  final String description;
  final List<String> terms;
  bool isExpanded;

  PromoVoucher({
    required this.title,
    required this.code,
    required this.description,
    required this.terms,
    this.isExpanded = false,
  });
}
