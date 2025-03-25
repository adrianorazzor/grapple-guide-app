import 'package:equatable/equatable.dart';

import '../../models/video.dart';

abstract class VideoState extends Equatable {
  const VideoState();
  
  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Video> videos;
  
  const VideoLoaded(this.videos);
  
  @override
  List<Object> get props => [videos];
}

class FavoriteVideosLoaded extends VideoState {
  final List<Video> favoriteVideos;
  
  const FavoriteVideosLoaded(this.favoriteVideos);
  
  @override
  List<Object> get props => [favoriteVideos];
}

class SingleVideoLoaded extends VideoState {
  final Video video;
  
  const SingleVideoLoaded(this.video);
  
  @override
  List<Object> get props => [video];
}

class VideoError extends VideoState {
  final String message;
  
  const VideoError(this.message);
  
  @override
  List<Object> get props => [message];
} 