import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physio_digital/view/posts/list_posts.dart';
import 'package:physio_digital/view/posts/view_post.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Upcoming events', onViewAll: () {
          Get.to(() => const ListPostsPage(initialCategory: 'Events'), transition: Transition.rightToLeft);
        }),
        _buildEventList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          TextButton.icon(
            onPressed: onViewAll,
            label: const Text(
              'See all',
              style: TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
            ),
            icon: const Icon(Icons.arrow_forward, size: 16),
            iconAlignment: IconAlignment.end,
            style: TextButton.styleFrom(
              iconColor: const Color.fromARGB(255, 99, 99, 99), // Text color
              backgroundColor: Colors.transparent, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    // Filter events from the central posts list
    final events = ListPostsPage.posts.where((p) => p['category'] == 'Events').toList();
    
    // Define a set of background colors for aesthetics
    final colors = [
      Colors.orange.shade100,
      Colors.teal.shade100,
      Colors.blue.shade100,
      Colors.purple.shade100,
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final post = events[index];
          return _buildEventCard(
            post: post,
            backgroundColor: colors[index % colors.length],
          );
        },
      ),
    );
  }

  Widget _buildEventCard({required Map<String, dynamic> post, required Color backgroundColor}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ViewArticlePage(post: post), transition: Transition.downToUp);
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      post['date'] ?? 'TBD',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post['title'] ?? 'Upcoming Event',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/circle_pattern.png',
                  width: 140,
                  height: 140,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

