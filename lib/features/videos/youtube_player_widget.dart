import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String youtubeUrl;

  const YouTubePlayerWidget({
    super.key,
    required this.youtubeUrl,
  });

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  String? _videoId;
  bool _hasError = false;
  double _progress = 0;
  final InAppWebViewSettings _settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    useShouldOverrideUrlLoading: true,
    useOnLoadResource: true,
  );

  @override
  void initState() {
    super.initState();
    _extractVideoId();
  }

  void _extractVideoId() {
    try {
      // Extract video ID from YouTube URL
      Uri uri = Uri.parse(widget.youtubeUrl);
      
      if (widget.youtubeUrl.contains('youtu.be')) {
        // Handle youtu.be format
        _videoId = uri.pathSegments.first;
      } else if (widget.youtubeUrl.contains('youtube.com')) {
        // Handle youtube.com format
        _videoId = uri.queryParameters['v'];
      }
      
      if (_videoId == null || _videoId!.isEmpty) {
        setState(() {
          _hasError = true;
        });
      }
    } catch (e) {
      debugPrint('Error extracting YouTube video ID: $e');
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
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri('https://www.youtube.com/embed/$_videoId'),
                  ),
                  initialSettings: _settings,
                  onWebViewCreated: (controller) {
                    // Controller created
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  onReceivedError: (controller, request, error) {
                    setState(() {
                      _hasError = true;
                    });
                  },
                ),
                if (_progress < 1.0)
                  Center(
                    child: CircularProgressIndicator(
                      value: _progress,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
              ],
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
            Text(
              'Error loading YouTube video',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasError = false;
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