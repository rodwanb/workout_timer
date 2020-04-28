extension StringFormatting on Duration {
  String asTimeString() {
    String twoDigits(int n) => n >= 10 ? '$n' : '0$n';

    var minutes = twoDigits(this.inMinutes.remainder(60));
    var seconds = twoDigits(this.inSeconds.remainder(60));

    var hours = '';
    if (this.inHours > 0) {
      hours = '${twoDigits(this.inHours)}:';
    }
    return '$hours$minutes:$seconds';
  }
}
