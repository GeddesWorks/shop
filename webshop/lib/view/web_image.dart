import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WebImage extends StatelessWidget {
  final String url;
  final String? backupUrl;
  final double? height;
  const WebImage({required this.url, this.backupUrl, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height ?? 50.0,
      fit: BoxFit.cover,
      errorBuilder: (
        BuildContext context,
        Object exception,
        StackTrace? stackTrace,
      ) {
        return backupUrl == null
            ? Icon(
                Icons.error,
                size: height,
              )
            : Image.network(
                backupUrl!,
                height: height ?? 50.0,
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) {
                  return Icon(
                    Icons.error,
                    size: height,
                  );
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    );
                  }
                },
              );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          );
        }
      },
    );
  }
}
