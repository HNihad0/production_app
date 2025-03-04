import 'package:flutter/material.dart';
import '../../../../utils/constants/app_paddings.dart';
import '../../../../utils/extensions/num_extensions.dart';

class HomeGridCard extends StatelessWidget {
  final String senNo;
  final Map<String, List<Map<String, String>>> elMalAdiGroups;
  final bool stat;
  final VoidCallback onTap;

  const HomeGridCard({
    super.key,
    required this.senNo,
    required this.elMalAdiGroups,
    required this.stat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: AppPaddings.a8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senNo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.h,
              ...elMalAdiGroups.entries.map((entry) {
                final elMalAdi = entry.key;
                final silMalAdiList = entry.value.take(6);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      elMalAdi,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ...silMalAdiList.map((item) => Text(
                          "${item['silMalAdi']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
