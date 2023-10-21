import 'dart:convert';

class PaymentUrlModel {
  String token;
  String redirectUrl;

  PaymentUrlModel({
    required this.token,
    required this.redirectUrl,
  });

  factory PaymentUrlModel.fromRawJson(String str) =>
      PaymentUrlModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentUrlModel.fromJson(Map<String, dynamic> json) =>
      PaymentUrlModel(
        token: json["token"],
        redirectUrl: json["redirect_url"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "redirect_url": redirectUrl,
      };
}
