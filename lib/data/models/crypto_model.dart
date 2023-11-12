import 'package:json_annotation/json_annotation.dart';
part 'crypto_model.g.dart';

@JsonSerializable()
class Crypto {
  @JsonKey(name: 'cmc_rank')
  final int cmcRank;
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final Quote quote;

  Crypto({
    required this.cmcRank,
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.quote,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      cmcRank: json['cmc_rank'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      slug: json['slug'] as String,
      quote: Quote.fromJson(json['quote'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => _$CryptoToJson(this);
}

@JsonSerializable()
class Quote {
  final USD usd;

  Quote({required this.usd});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      usd: USD.fromJson(json['USD'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

@JsonSerializable()
class USD {
  final double price;
  @JsonKey(name: 'percent_change_24h')
  final double percentChange24h;
  @JsonKey(name: 'volume_24h')
  final double volume24h;
  @JsonKey(name: 'market_cap') // Added marketCap field
  final double marketCap;

  USD({
    required this.price,
    required this.percentChange24h,
    required this.volume24h,
    required this.marketCap,
  });

  factory USD.fromJson(Map<String, dynamic> json) {
    return USD(
      price: (json['price'] as num).toDouble(),
      percentChange24h: (json['percent_change_24h'] as num).toDouble(),
      volume24h: (json['volume_24h'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(), // Added this line
    );
  }

  Map<String, dynamic> toJson() => _$USDToJson(this);
}
