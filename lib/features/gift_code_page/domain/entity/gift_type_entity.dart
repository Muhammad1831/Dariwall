import 'package:equatable/equatable.dart';

class GiftTypeEntity extends Equatable {
  final int code;
  final String? title;
  final String? description;

  const GiftTypeEntity({
    required this.code,
    this.description,
    this.title,
  });

  @override
  List<Object?> get props => [code, title, description];
}
