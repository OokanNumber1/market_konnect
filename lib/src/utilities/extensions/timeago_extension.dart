extension DateHelper on DateTime {
  String timeago() {
    final now = DateTime.now();
    final agoFromNow = now.difference(this);
    if (agoFromNow.inDays > 365) {
      return "${(agoFromNow.inDays/365).floor()} ${(agoFromNow.inDays/365).floor() == 1 ? "year":"years"} ago";
    }
    else if (agoFromNow.inDays > 30) {
      return "${(agoFromNow.inDays/30).floor()} ${(agoFromNow.inDays/30).floor() == 1 ? "month":"months"} ago";
    }
    else if (agoFromNow.inDays > 7) {
      return "${(agoFromNow.inDays/7).floor()} ${(agoFromNow.inDays/7).floor() == 1 ? "week":"weeks"} ago";
    }
    else if (agoFromNow.inDays > 0) {
      return "${agoFromNow.inDays} ${agoFromNow.inDays == 1 ? "day":"days"} ago";
    }
    else if (agoFromNow.inHours > 0) {
      return "${agoFromNow.inHours} ${agoFromNow.inHours == 1 ? "hour":"hours"} ago";
    }
    else if (agoFromNow.inMinutes > 0) {
      return "${agoFromNow.inMinutes} ${agoFromNow.inMinutes == 1 ? "minute":"minutes"} ago";
    }
    return "just now";
  }
}