import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';

class RecomendedPage extends StatefulWidget {
  const RecomendedPage({super.key});

  @override
  State<RecomendedPage> createState() => _RecomendedPageState();
}

class _RecomendedPageState extends State<RecomendedPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // focus container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 170,
                width: 160,
                decoration: const BoxDecoration(
                  color: ThemeConfigs.color23,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    Image.asset('assets/focus.png', width: 350, height: 90),

                    const SizedBox(height: 10),

                    // topic
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        "Focus",
                        style: TextStyle(
                          color: ThemeConfigs.color14,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    // description
                    const Padding(
                      padding: EdgeInsets.only(left: 2, top: 3),
                      child: Text(
                        'MEDITATION * 3-10 MIN',
                        style: TextStyle(
                          color: ThemeConfigs.color24,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // happiness container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 170,
                width: 160,
                decoration: const BoxDecoration(
                  color: ThemeConfigs.color23,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    Image.asset('assets/happiness.png', width: 300, height: 90),

                    const SizedBox(height: 10),

                    // topic
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        "Happiness",
                        style: TextStyle(
                          color: ThemeConfigs.color14,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    // description
                    const Padding(
                      padding: EdgeInsets.only(left: 2, top: 3),
                      child: Text(
                        'MEDITATION * 3-10 MIN',
                        style: TextStyle(
                          color: ThemeConfigs.color24,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // focus container
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 170,
                width: 160,
                decoration: const BoxDecoration(
                  color: ThemeConfigs.color23,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    Image.asset('assets/focus.png', width: 350, height: 90),

                    const SizedBox(height: 10),

                    // topic
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        "Focus",
                        style: TextStyle(
                          color: ThemeConfigs.color14,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    // description
                    const Padding(
                      padding: EdgeInsets.only(left: 2, top: 3),
                      child: Text(
                        'MEDITATION * 3-10 MIN',
                        style: TextStyle(
                          color: ThemeConfigs.color24,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
