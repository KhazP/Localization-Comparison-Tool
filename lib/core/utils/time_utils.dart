/// Lightweight utility for relative time formatting
/// Avoids adding external dependencies like timeago package
class TimeUtils {
  /// Returns a human-readable relative time string
  /// Examples: "just now", "5 minutes ago", "2 hours ago", "3 days ago"
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.isNegative) {
      return 'in the future';
    }

    if (difference.inSeconds < 30) {
      return 'just now';
    }

    if (difference.inMinutes < 1) {
      return '${difference.inSeconds} seconds ago';
    }

    if (difference.inMinutes == 1) {
      return '1 minute ago';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    }

    if (difference.inHours == 1) {
      return '1 hour ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    }

    if (difference.inDays == 1) {
      return 'yesterday';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    if (difference.inDays < 14) {
      return '1 week ago';
    }

    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks weeks ago';
    }

    if (difference.inDays < 60) {
      return '1 month ago';
    }

    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months months ago';
    }

    if (difference.inDays < 730) {
      return '1 year ago';
    }

    final years = (difference.inDays / 365).floor();
    return '$years years ago';
  }

  /// Returns a short relative time string (more compact)
  /// Examples: "now", "5m", "2h", "3d"
  static String timeAgoShort(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.isNegative) {
      return 'future';
    }

    if (difference.inMinutes < 1) {
      return 'now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d';
    }

    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    }

    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo';
    }

    final years = (difference.inDays / 365).floor();
    return '${years}y';
  }
}
