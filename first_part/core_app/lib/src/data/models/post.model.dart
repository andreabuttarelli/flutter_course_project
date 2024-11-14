const _kID = 'id';
const _kTitle = 'title';
const _kBody = 'body';

class PostModel {
  final int id;
  final String title;
  final String body;

  const PostModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json[_kID] as int,
      title: json[_kTitle] as String,
      body: json[_kBody] as String,
    );
  }

  static List<PostModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => PostModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      _kID: id,
      _kTitle: title,
      _kBody: body,
    };
  }

  @override
  String toString() => 'PostModel(id: $id, title: $title, body: $body)';
}
