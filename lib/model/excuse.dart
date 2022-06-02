class Excuse {
  //Class which will contain all the necessary elements.
  int httpCode;
  String tag;
  String message;
  Excuse({
    required this.httpCode,
    required this.tag,
    required this.message,
  });

// Method to post an excuse to the API

  Map<String, dynamic> toJson() {
    return {
      'http_code': httpCode,
      'tag': tag,
      'message': message,
    };
  }

//Method to parse the fetched json

  factory Excuse.fromJson(Map<String, dynamic> map) {
    return Excuse(
      httpCode: map['http_code'],
      tag: map['tag '] ?? map['tag'],
      message: map['message '] ?? map['message'],
    );
  }
}
