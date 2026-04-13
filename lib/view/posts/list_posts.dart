import 'package:flutter/material.dart';
import 'package:physio_digital/view/home/buttom_bar.dart';
import 'package:physio_digital/view/posts/view_post.dart';

class ListPostsPage extends StatelessWidget {
  final String initialCategory;
  const ListPostsPage({Key? key, this.initialCategory = 'All'}) : super(key: key);

  static const List<Map<String, dynamic>> posts = [
    {
      'title': 'Unlocking the Benefits of Tele-Rehabilitation',
      'category': 'News',
      'date': 'May 10, 2024',
      'description': 'Tele-rehabilitation is revolutionizing the way patients receive care. By using digital platforms, patients can now access expert physiotherapy from the comfort of their homes, ensuring continuity of care and improved outcomes.',
      'imageUrl': 'assets/images/onboard.jpg',
    },
    {
      'title': 'The Power of Physiotherapy',
      'category': 'News',
      'date': 'May 08, 2024',
      'description': "Physiotherapy is more than just exercises. It's a holistic approach to health that focuses on restoring movement and function. Discover how physiotherapy can help you recover from injury and improve your quality of life.",
      'imageUrl': 'assets/images/onboard.jpg',
    },
    {
      'title': 'Community Wellness Challenge: "Step Up for Health"',
      'category': 'Events',
      'date': '3rd, May',
      'description': 'Join our community-wide wellness challenge and take a step towards a healthier you! This event is designed to encourage physical activity and promote overall wellness through a series of fun and engaging challenges.',
      'imageUrl': 'assets/images/onboard.jpg',
    },
    {
      'title': 'Live Q&A Session with the Experts',
      'category': 'Events',
      'date': '5th, May',
      'description': 'Have questions about physiotherapy, injury prevention, or rehabilitation? Join our live Q&A session with leading experts in the field. Get your questions answered in real-time and gain valuable insights from the pros.',
      'imageUrl': 'assets/images/product3.jpg',
    },
    {
      'title': 'Stretching can increase your tolerance for pain',
      'category': 'News',
      'date': 'Feb 22, 2024',
      'description': 'Some people with back pain see immediate improvements after a specific stretch...',
      'imageUrl': 'assets/images/product3.jpg',
    },
    {
      'title': "Physio 'dry needling' and acupuncture",
      'category': 'News',
      'date': 'Feb 12, 2024',
      'description': "Dry needling and Western acupuncture don't use the same theoretical approach as traditional Chinese medicine...",
      'imageUrl': 'assets/images/product2.jpg',
    },
    {
      'title': 'Should I stop running if my knee hurts?',
      'category': 'News',
      'date': 'Feb 09, 2024',
      'description': 'How to run safely with knee pain and when to seek professional help...',
      'imageUrl': 'assets/images/prduct1.png',
    },
    {
      'title': 'A culture specific health measuring instrument for a...',
      'category': 'News',
      'date': 'Feb 04, 2024',
      'description': 'Healthcare professionals should develop new measurement tools that are culturally appropriate...',
      'imageUrl': 'assets/images/onboard.jpg',
    },
    {
      'title': 'Physiotherapy Open Day - Join Us!',
      'category': 'Events',
      'date': 'Feb 28, 2024',
      'description': 'Learn about physiotherapy careers and meet practicing professionals...',
      'imageUrl': 'assets/images/app-logo.png',
    },
    {
      'title': 'Summer Internship Program Applications Open',
      'category': 'Internships',
      'date': 'Feb 26, 2024',
      'description': 'Apply now for our comprehensive summer internship program in physiotherapy...',
      'imageUrl': 'assets/images/app-logo.png',
    },
    {
      'title': 'Senior Physiotherapist Position Available',
      'category': 'Jobs',
      'date': 'Feb 25, 2024',
      'description': 'We are seeking an experienced physiotherapist to join our growing team...',
      'imageUrl': 'assets/images/circle_pattern.png',
    },
    {
      'title': 'Advanced Manual Therapy Webinar',
      'category': 'Webinars',
      'date': 'Feb 24, 2024',
      'description': 'Join our expert panel for an in-depth discussion on advanced manual therapy techniques...',
      'imageUrl': 'assets/images/product3.jpg',
    },
    {
      'title': 'Annual Physiotherapy Conference 2024',
      'category': 'Conference',
      'date': 'Feb 23, 2024',
      'description': 'Register now for the biggest physiotherapy conference of the year...',
      'imageUrl': 'assets/images/product2.jpg',
    },
    {
      'title': 'Community Health Fair Coming This Weekend',
      'category': 'Events',
      'date': 'Feb 27, 2024',
      'description': 'Free health screenings and consultations available at our annual health fair...',
      'imageUrl': 'assets/images/prduct1.png',
    },
  ];

  static const List<String> _categories = [
    'All',
    'News',
    'Events',
    'Internships',
    'Jobs',
    'Webinars',
    'Conference'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: _PostsPageContent(initialCategory: initialCategory),
      bottomNavigationBar: CustomBottomNavigationBar.create(),
    );
  }
}

class _PostsPageContent extends StatefulWidget {
  final String initialCategory;
  const _PostsPageContent({required this.initialCategory});

  @override
  State<_PostsPageContent> createState() => _PostsPageContentState();
}

class _PostsPageContentState extends State<_PostsPageContent> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  List<Map<String, dynamic>> get _filteredPosts {
    if (_selectedCategory == 'All') {
      return ListPostsPage.posts;
    }
    return ListPostsPage.posts
        .where((post) => post['category'] == _selectedCategory)
        .toList();
  }

  void _onCategoryChanged(String category) {
    if (_selectedCategory != category) {
      setState(() {
        _selectedCategory = category;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header Sliver
        const _HeaderSliver(),
        
        // Category Selection Sliver
        SliverToBoxAdapter(
          child: RepaintBoundary(
            child: _CategorySection(
              categories: ListPostsPage._categories,
              selectedCategory: _selectedCategory,
              onCategoryChanged: _onCategoryChanged,
            ),
          ),
        ),
        
        // Recent Articles Header
        const SliverToBoxAdapter(
          child: RepaintBoundary(child: _RecentArticlesHeader()),
        ),
        
        // Posts List
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _filteredPosts.length) return null;
                return RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _PostCard(post: _filteredPosts[index]),
                  ),
                );
              },
              childCount: _filteredPosts.length,
            ),
          ),
        ),
        
        // Bottom spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
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
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x08000000),
                offset: Offset(0, 1),
                blurRadius: 4,
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1F38), size: 20),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF354AD9).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.article_outlined,
                      color: Color(0xFF354AD9),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latest Articles',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1F38),
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Stay updated with the latest in physiotherapy',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF6B7280),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                
                return RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _CategoryChip(
                      label: category,
                      isSelected: isSelected,
                      onTap: () => onCategoryChanged(category),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xFFF1F3F4),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF354AD9) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF354AD9) : const Color(0xFFE1E5E9),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF354AD9).withValues(alpha: 0.24),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _RecentArticlesHeader extends StatelessWidget {
  const _RecentArticlesHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FD),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF354AD9),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Recent Articles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1F38),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // Handle see all action
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF354AD9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewArticlePage(post: post),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PostCardHeader(category: post['category'], post: post),
            _PostCardContent(post: post),
          ],
        ),
      ),
    );
  }
}

class _PostCardHeader extends StatelessWidget {
  const _PostCardHeader({required this.category, required this.post});

  final String? category;
  final Map<String, dynamic> post;

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'news':
        return const Color(0xFF4285F4);
      case 'internships':
        return const Color(0xFF34A853);
      case 'events':
        return const Color(0xFFFBBC05);
      case 'jobs':
        return const Color(0xFFEA4335);
      case 'webinars':
        return const Color(0xFF9C27B0);
      case 'conference':
        return const Color(0xFF00ACC1);
      default:
        return const Color(0xFF354AD9);
    }
  }

  Widget _getImageWidget() {
    String? imageUrl = post['imageUrl'];
    
    // Check if imageUrl is a local asset
    if (imageUrl != null && imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 140,
      );
    }
    
    // Check if imageUrl is a valid URL
    if (imageUrl != null && (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'))) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 140,
        errorBuilder: (context, error, stackTrace) {
          return _getDefaultContainer();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 140,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
    
    // Default fallback
    return _getDefaultContainer();
  }

  Widget _getDefaultContainer() {
    final color = _getCategoryColor(category);
    return Container(
      height: 140,
      width: double.infinity,
      color: color.withValues(alpha: 0.2),
      child: Center(
        child: Icon(
          Icons.article,
          size: 64,
          color: color.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(category);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        height: 140,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _getImageWidget(),
            // Dark overlay for better text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  category ?? 'Uncategorized',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCardContent extends StatelessWidget {
  const _PostCardContent({required this.post});

  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post['title'] ?? 'Untitled',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1F38),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            post['description'] ?? 'No description available',
            style: const TextStyle(
              color: Color(0xFF4A4E69),
              fontSize: 14,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                post['date'] ?? 'No date',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Text(
                'Read More',
                style: TextStyle(
                  color: Color(0xFF354AD9),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: Color(0xFF354AD9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}