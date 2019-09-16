import 'package:json_annotation/json_annotation.dart';

part 'github.g.dart';

@JsonSerializable()
class Github {
    Github();

    List github;
    
    factory Github.fromJson(Map<String,dynamic> json) => _$GithubFromJson(json);
    Map<String, dynamic> toJson() => _$GithubToJson(this);
}
