import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/categories/categories_screen.dart';
import '../../features/videos/video_details_screen.dart';
import '../../features/videos/videos_screen.dart';
import '../../features/common/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

// Define our route configuration
final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    // Splash Screen
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // Categories Screen
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    
    // Videos Screen (within a category)
    GoRoute(
      path: '/categories/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        return VideosScreen(categoryId: categoryId);
      },
    ),
    
    // Video Details Screen
    GoRoute(
      path: '/videos/:videoId',
      builder: (context, state) {
        final videoId = state.pathParameters['videoId']!;
        return VideoDetailsScreen(videoId: videoId);
      },
    ),
  ],
  
  // Global error handler
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Page Not Found'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oops!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Cannot find page: ${state.uri.path}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/categories'),
            child: const Text('Go to Categories'),
          ),
        ],
      ),
    ),
  ),
); 