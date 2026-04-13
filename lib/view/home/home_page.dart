import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physio_digital/controllers/home_controller.dart';
import 'package:physio_digital/view/home/buttom_bar.dart';
import 'package:physio_digital/view/home/clinic_near_you.dart';
import 'package:physio_digital/view/home/informative_articles.dart';
import 'package:physio_digital/view/home/upcoming_events.dart';
import 'package:physio_digital/view/clinics/clinic.dart';
// import 'package:physio_digital/view/notification/list_notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: const _HomePageContent(),
      bottomNavigationBar: CustomBottomNavigationBar.create(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Modern Header Sliver
        const _HeaderSliver(),
        
        // Main Content Slivers
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const RepaintBoundary(child: ClinicNearYou()),
              const SizedBox(height: 20),
              const RepaintBoundary(child: UpcomingEvents()),
              const SizedBox(height: 20),
              const RepaintBoundary(child: InformativeArticles()),
              const SizedBox(height: 100), // Bottom spacing for nav bar
            ]),
          ),
        ),
      ],
    );
  }
}

class _HeaderSliver extends StatelessWidget {
  const _HeaderSliver();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RepaintBoundary(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                const Color(0xFF4A5FE7),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileSection(),
                  SizedBox(height: 28),
                  _SearchBarSection(),
                  SizedBox(height: 20),
                  _QuickStatsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Enhanced Profile Avatar
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.3),
                Colors.white.withValues(alpha: 0.1),
              ],
            ),
          ),
          child: const _ProfileAvatar(),
        ),
        const SizedBox(width: 16),
        
        // Welcome Text with Cached Greeting
        const Expanded(child: _WelcomeText()),
        
        // App Logo/Icon
        const _AppIcon(),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/onboard.jpg'),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
          homeController.greeting,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )),
        const SizedBox(height: 2),
        const Text(
          'Ready for your wellness journey?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.healing,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search therapists, clinics, products...',
            prefixIcon: _SearchIcon(Theme.of(context).colorScheme.primary),
            suffixIcon: _FilterIcon(Theme.of(context).colorScheme.primary),
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
          ),
          cursorColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon(this.color);
  
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Icon(
        Icons.search,
        color: color,
        size: 22,
      ),
    );
  }
}

class _FilterIcon extends StatelessWidget {
  const _FilterIcon(this.color);
  
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.tune,
        color: color,
        size: 20,
      ),
    );
  }
}

class _QuickStatsSection extends StatelessWidget {
  const _QuickStatsSection();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(() => const Clinic(initialTab: 1));
              },
              child: const _QuickStatCard(
                icon: Icons.local_hospital,
                label: 'Clinics',
                value: '50+',
                color: Colors.orange,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(() => const Clinic(initialTab: 0));
              },
              child: const _QuickStatCard(
                icon: Icons.people,
                label: 'Therapists',
                value: '200+',
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/marketplace');
              },
              child: const _QuickStatCard(
                icon: Icons.shopping_bag,
                label: 'Products',
                value: '1K+',
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(height: 8),
            // Text(
            //   value,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
