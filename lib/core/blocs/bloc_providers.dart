import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_client.dart';
import '../api/remote_category_repository.dart';
import '../api/local_category_repository.dart';
import '../api/remote_video_repository.dart';
import '../api/local_video_repository.dart';
import '../logger/logger.dart';
import '../services/category_service.dart';
import '../services/video_service.dart';
import 'category/category_cubit.dart';
import 'logger/logger_cubit.dart';
import 'video/video_cubit.dart';

List<BlocProvider> getAppBlocProviders() {
  final logger = AppLogger();
  final apiClient = ApiClient();
  
  // Create repositories
  final remoteCategoryRepo = RemoteCategoryRepository(apiClient);
  final localCategoryRepo = LocalCategoryRepository();
  final remoteVideoRepo = RemoteVideoRepository(apiClient);
  final localVideoRepo = LocalVideoRepository();
  
  // Create services
  final categoryService = CategoryService(remoteCategoryRepo, localCategoryRepo);
  final videoService = VideoService(remoteVideoRepo, localVideoRepo);
  
  // Create cubits
  final loggerCubit = LoggerCubit(logger: logger);
  final categoryCubit = CategoryCubit(categoryService: categoryService);
  
  return [
    BlocProvider<LoggerCubit>(
      create: (BuildContext context) => loggerCubit,
    ),
    BlocProvider<CategoryCubit>(
      create: (BuildContext context) => categoryCubit,
    ),
    BlocProvider<VideoCubit>(
      create: (BuildContext context) => VideoCubit(
        videoService: videoService,
        categoryCubit: categoryCubit,
      ),
    ),
  ];
} 