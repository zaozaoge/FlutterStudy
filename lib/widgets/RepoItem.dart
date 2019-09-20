import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/i10n/GmLocalizations.dart';
import 'package:flutter_app/models/index.dart';

class RepoItem extends StatefulWidget {
  final Repo repo;

  RepoItem(this.repo) : super(key: ValueKey(repo.id));

  @override
  State<StatefulWidget> createState() {
    return _RepoItemState();
  }
}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    var subtitle;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).dividerColor, width: .5)),
        child: Padding(
          padding: const EdgeInsets.only(top: .0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: gmAvator(widget.repo.owner.avatar_url,
                    width: 24.0, borderRadius: BorderRadius.circular(12.0)),
                title: Text(
                  widget.repo.owner.login,
                  textScaleFactor: .9,
                ),
                subtitle: subtitle,
                trailing: Text(widget.repo.language ?? ""),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.repo.fork
                          ? widget.repo.full_name
                          : widget.repo.name,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: widget.repo.fork
                              ? FontStyle.italic
                              : FontStyle.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                      child: widget.repo.description == null
                          ? Text(
                              GmLocalizations.of(context).noDescription,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[700]),
                            )
                          : Text(
                              widget.repo.description,
                              maxLines: 3,
                              style: TextStyle(
                                  height: 1.15,
                                  color: Colors.blueGrey[700],
                                  fontSize: 13),
                            ),
                    )
                  ],
                ),
              ),
              _buildBottom()
            ],
          ),
        ),
      ),
    );
  }

  Widget gmAvator(String url,
      {double width = 30,
      double height,
      BoxFit fit,
      BorderRadius borderRadius}) {
    var placeHolder = Image.asset(
      "image/ic_launcher.png", //占位图，加载中显示
      width: width,
      height: height,
    );
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(2.0),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeHolder,
        errorWidget: (context, url, error) => placeHolder,
      ),
    );
  }

  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
        data: IconThemeData(color: Colors.grey, size: 15),
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.grey, fontSize: 12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Builder(builder: (context) {
              var children = <Widget>[
                Icon(Icons.star),
                Text(" " +
                    widget.repo.stargazers_count
                        .toString()
                        .padLeft(paddingWidth)),
                Icon(Icons.info_outline),
                Text(" " +
                    widget.repo.open_issues_count
                        .toString()
                        .padRight(paddingWidth))
              ];
              return Row(
                children: children,
              );
            }),
          ),
        ));
  }
}
