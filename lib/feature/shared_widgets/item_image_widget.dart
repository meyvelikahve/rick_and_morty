import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    super.key,
    required this.name,
    this.imageUrl,
  });
  final String name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(10),
      child: imageUrl != null
          ? SizedBox(
              height: screenSize.height / 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : SizedBox(
              height: screenSize.height / 6,
            ),
    );
  }
}
