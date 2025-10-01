import 'package:agri_expert/trending_videos/trending_videos_view.dart';
import 'package:flutter/material.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import '../questions/questions_view.dart';

class TabBarNavigationView extends StatefulWidget {
  const TabBarNavigationView({super.key});

  @override
  State<TabBarNavigationView> createState() => _TabBarNavigationViewState();
}

class _TabBarNavigationViewState extends State<TabBarNavigationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),

        controller: _tabController,
        children: [
          HomeView(),
          QuestionsScreen(),
          TrendingVideosScreen(),
          const SizedBox(),
           ProfileView(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4D4D4).withOpacity(0.3),
              offset: const Offset(0, -10),
              blurRadius: 20,
            ),
          ],
        ),
        child: TabBar(

          controller: _tabController,
          indicator: const _CustomIndicator(), // <-- custom indicator
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xff339D44),
          unselectedLabelColor: Color(0xFFD4D4D4),
          dividerColor: Colors.transparent, // 🚫 remove bottom line

          tabs: const [
            Tab(icon: ImageIcon(AssetImage("assets/icons/Group (3).png"), size: 20)),
            Tab(icon: ImageIcon(AssetImage("assets/icons/Group (7).png"), size: 20)),
            Tab(icon: ImageIcon(AssetImage("assets/icons/Group (4).png"), size: 20)),
            Tab(icon: ImageIcon(AssetImage("assets/icons/Group (5).png"), size: 20)),
            Tab(icon: ImageIcon(AssetImage("assets/icons/Group (6).png"), size: 20)),
          ],
        ),
      ),
    );
  }
}

/// Custom green indicator
class _CustomIndicator extends Decoration {
  const _CustomIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomIndicatorPainter();
  }
}

class _CustomIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Paint paint = Paint()..color = const Color(0xff339D44);

    final double xCenter = offset.dx + cfg.size!.width / 2;
    final double topY = offset.dy;

    final Rect rect = Rect.fromCenter(
      center: Offset(xCenter, topY + 3), // half of height (6/2) = 3
      width: 47,
      height: 6,
    );

    final RRect rRect = RRect.fromRectAndCorners(
      rect,
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10),
    );

    canvas.drawRRect(rRect, paint);
  }
}