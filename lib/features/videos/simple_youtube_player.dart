import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SimpleYouTubePlayer extends StatefulWidget {
  final String youtubeUrl;

  const SimpleYouTubePlayer({
    super.key,
    required this.youtubeUrl,
  });

  @override
  State<SimpleYouTubePlayer> createState() => _SimpleYouTubePlayerState();
}

class _SimpleYouTubePlayerState extends State<SimpleYouTubePlayer> {
  String? _videoId;
  bool _isLoading = true;
  bool _hasError = false;
  final InAppWebViewSettings _settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "autoplay; fullscreen",
    iframeAllowFullscreen: true,
  );

  @override
  void initState() {
    super.initState();
    _extractVideoId();
  }

  void _extractVideoId() {
    try {
      Uri uri = Uri.parse(widget.youtubeUrl);
      
      if (widget.youtubeUrl.contains('youtu.be')) {
        _videoId = uri.pathSegments.first;
      } else if (widget.youtubeUrl.contains('youtube.com')) {
        _videoId = uri.queryParameters['v'];
      }
      
      if (_videoId == null || _videoId!.isEmpty) {
        setState(() {
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || _videoId == null) {
      return _buildErrorWidget();
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse('https://www.youtube.com/embed/$_videoId')),
            ),
            initialSettings: _settings,
            onReceivedError: (controller, request, error) {
              setState(() {
                _hasError = true;
              });
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Could not load YouTube video',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                  _extractVideoId();
                });
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
} 