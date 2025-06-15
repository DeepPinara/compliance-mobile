class ListApiResponse<T> {
  final List<T>? data;
  final int? totalCount;

  ListApiResponse({
    this.data,
    this.totalCount,
  });

  factory ListApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ListApiResponse<T>(
      data: json['data'] != null
          ? List<T>.from(json['data'].map((x) => fromJsonT(x)))
          : null,
      totalCount: json['totalCount'],
    );
  }

  Map<String, dynamic> toJson(T Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((x) => toJsonT(x)).toList();
    }
    if (totalCount != null) {
      data['totalCount'] = totalCount;
    }
    return data;
  }
}
