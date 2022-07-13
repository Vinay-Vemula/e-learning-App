import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class Explorer extends StatelessWidget {
  const Explorer(MaterialColor pink, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white),
            child: SkeletonItem(
                child: Column(
              children: [
                Row(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.rectangle, width: 50, height: 50),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 3,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 6,
                              maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 12),
                // SkeletonParagraph(
                //   style: SkeletonParagraphStyle(
                //       lines: 3,
                //       spacing: 6,
                //       lineStyle: SkeletonLineStyle(
                //         randomLength: true,
                //         height: 10,
                //         borderRadius: BorderRadius.circular(8),
                //         minLength: MediaQuery.of(context).size.width / 2,
                //       )),
                // ),
                // SizedBox(height: 12),
                // SkeletonAvatar(
                //   style: SkeletonAvatarStyle(
                //     width: double.infinity,
                //     minHeight: MediaQuery.of(context).size.height / 8,
                //     maxHeight: MediaQuery.of(context).size.height / 3,
                //   ),
                // ),
                // SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         SkeletonAvatar(
                //             style: SkeletonAvatarStyle(width: 20, height: 20)),
                //         SizedBox(width: 8),
                //         SkeletonAvatar(
                //             style: SkeletonAvatarStyle(width: 20, height: 20)),
                //         SizedBox(width: 8),
                //         SkeletonAvatar(
                //             style: SkeletonAvatarStyle(width: 20, height: 20)),
                //       ],
                //     ),
                //     SkeletonLine(
                //       style: SkeletonLineStyle(
                //           height: 16,
                //           width: 64,
                //           borderRadius: BorderRadius.circular(8)),
                //     )
                //   ],
                // )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey,
      ),
    );
  }
}
