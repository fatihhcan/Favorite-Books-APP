import 'package:favorite_books_app/core/constants/strings/strings_constant.dart';
import 'package:favorite_books_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class BookInfoCard extends StatelessWidget {
  final Color? borderColor;
  final Widget? image;
  final String? title;
  final String? publisher;
  final String? publishedDate;
  final String? pageCount;
  final String? authors;
  final bool? authorsVisible;
  final bool? publisherVisible;
  final bool? pageCountVisible;
  final bool? publishedDateVisible;

  const BookInfoCard(
      {super.key,
      this.borderColor,
      this.image,
      this.title,
      this.publisher,
      this.publishedDate,
      this.pageCount,
      this.authors,
      this.authorsVisible,
      this.publisherVisible,
      this.pageCountVisible,
      this.publishedDateVisible});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: context.appColors.mirage,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor!, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
            leading: image,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? StringConstants.unknown,
                  style: context.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 2,
                ),
                Visibility(
                    visible: publisherVisible ?? false,
                    child: Text('${StringConstants.publisher} ${publisher ?? ''}')),
                Visibility(
                    visible: publishedDateVisible ?? false,
                    child: Text('${StringConstants.publishedDate} ${publishedDate ?? ''}')),
                Visibility(
                    visible: pageCountVisible ?? false,
                    child: Text('${StringConstants.pageCount} ${pageCount ?? ''}')),
                Visibility(
                    visible: authorsVisible ?? false, child: Text('${StringConstants.authors} ${authors ?? ''}')),
              ],
            )));
  }
}
