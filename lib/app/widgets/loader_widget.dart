import 'package:flutter/material.dart';
import 'package:te_find/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';
class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        padding: const EdgeInsets.only(
            left: 20.0, right: 20),
        child: Center(
          child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              period: const Duration(seconds: 2),
              baseColor: AppColors.primaryColor.withOpacity(0.5),
              highlightColor: Colors.white,
              child: ListView(
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                children: [0, 1, 2, 3]
                    .map((_) => Padding(
                  padding:
                  const EdgeInsets
                      .all(8.0),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      const Padding(
                        padding: EdgeInsets
                            .symmetric(
                            horizontal:
                            8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Container(
                              width: double
                                  .infinity,
                              height: 8.0,
                              color: Colors
                                  .white,
                            ),
                            const Padding(
                              padding: EdgeInsets
                                  .symmetric(
                                  vertical:
                                  2.0),
                            ),
                            Container(
                              width: double
                                  .infinity,
                              height: 8.0,
                              color: Colors
                                  .white,
                            ),
                            const Padding(
                              padding: EdgeInsets
                                  .symmetric(
                                  vertical:
                                  2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors
                                  .white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
                    .toList(),
              )),
        ));
  }
}
