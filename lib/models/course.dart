class CourseModel {
  late int? id;
  late String? title;
  late String? description;
  late String? thumbnail_image;
  late String? video_path;
  late String? watch_time;
  late int? status;

  CourseModel({
    this.id,
    this.title,
    this.description,
    this.thumbnail_image,
    this.video_path,
    this.watch_time,
    this.status,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    thumbnail_image = json['thumbnail_image'];
    video_path = json['video_path'];
    watch_time = json['watch_time'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail_image': thumbnail_image,
      'video_path': video_path,
      'watch_time': watch_time,
      'status': status,
    };
  }
}
