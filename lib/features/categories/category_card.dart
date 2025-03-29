import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../core/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key, 
    required this.category, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if we're on desktop platforms
    final bool isDesktop = kIsWeb || (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 12 : 16),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: category.imageUrl.isNotEmpty 
                ? Image.network(
                    category.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                      _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
            ),
            Padding(
              padding: EdgeInsets.all(isDesktop ? 8.0 : 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 14 : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (category.description.isNotEmpty) ...[
                    SizedBox(height: isDesktop ? 2 : 4),
                    Text(
                      category.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: isDesktop ? 11 : null,
                      ),
                      maxLines: isDesktop ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: isDesktop ? 2 : 4),
                  Row(
                    children: [
                      Icon(
                        Icons.video_library,
                        size: isDesktop ? 14 : 16,
                        color: Colors.blue,
                      ),
                      SizedBox(width: isDesktop ? 2 : 4),
                      Text(
                        '${category.videoCount} videos',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: isDesktop ? 10 : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    // Determine if we're on desktop platforms
    final bool isDesktop = kIsWeb || (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    
    return Container(
      color: Colors.blue.shade100,
      child: Icon(
        Icons.category,
        size: isDesktop ? 36 : 48,
        color: Colors.blue.shade700,
      ),
    );
  }
} 