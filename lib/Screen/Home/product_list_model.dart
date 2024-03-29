class ProductListModel {
  List<Data>? data;
  bool? success;
  int? status;

  ProductListModel({this.data, this.success, this.status});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? quantity;
  String? thumbnailImage;
  bool? hasDiscount;
  String? strokedPrice;
  String? mainPrice;
  int? rating;
  int? sales;
  dynamic showStartDate;
  dynamic showEndDate;
  dynamic couponPercent;
  int? discountInPercentage;
  Campaign? campaign;
  int? variantProduct;
  bool? isFavourist;
  Links? links;

  Data(
      {this.id,
        this.name,
        this.thumbnailImage,
        this.hasDiscount,
        this.strokedPrice,
        this.mainPrice,
        this.rating,
        this.sales,
        this.quantity,
        this.showStartDate,
        this.showEndDate,
        this.couponPercent,
        this.discountInPercentage,
        this.campaign,
        this.variantProduct,
        this.isFavourist,
        this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImage = json['thumbnail_image'];
    hasDiscount = json['has_discount'];
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    rating = json['rating'];
    sales = json['sales'];
    quantity = 1;
    showStartDate = json['show_start_date'];
    showEndDate = json['show_end_date'];
    couponPercent = json['coupon_percent'];
    discountInPercentage = json['discount_in_percentage'];
    campaign = json['campaign'] != null
        ? Campaign.fromJson(json['campaign'])
        : null;
    variantProduct = json['variant_product'];
    isFavourist = json['is_favourist'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail_image'] = thumbnailImage;
    data['has_discount'] = hasDiscount;
    data['stroked_price'] = strokedPrice;
    data['main_price'] = mainPrice;
    data['rating'] = rating;
    data['quanity'] = quantity;
    data['sales'] = sales;
    data['show_start_date'] = showStartDate;
    data['show_end_date'] = showEndDate;
    data['coupon_percent'] = couponPercent;
    data['discount_in_percentage'] = discountInPercentage;
    if (campaign != null) {
      data['campaign'] = campaign!.toJson();
    }
    data['variant_product'] = variantProduct;
    data['is_favourist'] = isFavourist;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class Campaign {
  String? name;
  int? numType;
  int? id;
  String? type;

  Campaign({this.name, this.numType, this.id, this.type});

  Campaign.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numType = json['num_type'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['num_type'] = numType;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

class Links {
  String? details;

  Links({this.details});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details;
    return data;
  }
}
