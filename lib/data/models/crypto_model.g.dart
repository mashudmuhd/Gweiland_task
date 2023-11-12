// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crypto _$CryptoFromJson(Map<String, dynamic> json) => Crypto(
      cmcRank: json['cmc_rank'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      slug: json['slug'] as String,
      quote: Quote.fromJson(json['quote'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CryptoToJson(Crypto instance) => <String, dynamic>{
      'cmc_rank': instance.cmcRank,
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'slug': instance.slug,
      'quote': instance.quote,
    };

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      usd: USD.fromJson(json['usd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'usd': instance.usd,
    };

USD _$USDFromJson(Map<String, dynamic> json) => USD(
      price: (json['price'] as num).toDouble(),
      percentChange24h: (json['percent_change_24h'] as num).toDouble(),
      volume24h: (json['volume_24h'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
    );

Map<String, dynamic> _$USDToJson(USD instance) => <String, dynamic>{
      'price': instance.price,
      'percent_change_24h': instance.percentChange24h,
      'volume_24h': instance.volume24h,
      'market_cap': instance.marketCap,
    };
