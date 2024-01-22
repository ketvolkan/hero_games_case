class UserInternetInfoModel {
  String? ip;
  String? city;
  String? region;
  String? regionCode;
  String? country;
  String? countryName;
  String? countryCode;
  String? countryCodeIso3;
  String? countryCapital;
  String? timezone;
  String? utcOffset;
  String? countryCallingCode;
  String? currency;
  String? currencyName;
  String? languages;

  UserInternetInfoModel(
      {this.ip,
      this.city,
      this.region,
      this.regionCode,
      this.country,
      this.countryName,
      this.countryCode,
      this.countryCodeIso3,
      this.countryCapital,
      this.timezone,
      this.utcOffset,
      this.countryCallingCode,
      this.currency,
      this.currencyName,
      this.languages});

  UserInternetInfoModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    city = json['city'];
    region = json['region'];
    regionCode = json['region_code'];
    country = json['country'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    countryCodeIso3 = json['country_code_iso3'];
    countryCapital = json['country_capital'];
    timezone = json['timezone'];
    utcOffset = json['utc_offset'];
    countryCallingCode = json['country_calling_code'];
    currency = json['currency'];
    currencyName = json['currency_name'];
    languages = json['languages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['city'] = city;
    data['region'] = region;
    data['region_code'] = regionCode;
    data['country'] = country;
    data['country_name'] = countryName;
    data['country_code'] = countryCode;
    data['country_code_iso3'] = countryCodeIso3;
    data['country_capital'] = countryCapital;
    data['timezone'] = timezone;
    data['utc_offset'] = utcOffset;
    data['country_calling_code'] = countryCallingCode;
    data['currency'] = currency;
    data['currency_name'] = currencyName;
    data['languages'] = languages;
    return data;
  }
}
