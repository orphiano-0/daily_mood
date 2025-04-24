import 'dart:ui';

enum EmojiCategory {
  unknown(0, 'assets/images/___.png', 'Unknown', Color(0xff6BBC46)),
  happy(1, 'assets/images/Happy.png', 'Happy', Color(0xffFFD700)),
  angry(2, 'assets/images/Angry.png', 'Angry', Color(0xffFF6767)),
  good(3, 'assets/images/Good.png', 'Good', Color(0xffA7F3D0)),
  confused(4, 'assets/images/Confused.png', 'Confused', Color(0xffFCA5A5)),
  horrible(5, 'assets/images/Horrible.png', 'Horrible', Color(0xffC0B2C3)),
  worried(6, 'assets/images/Worried.png', 'Worried', Color(0xff6EB9EF));

  final int emojiId;
  final String image;
  final String label;
  final Color color;

  //constructor
  const EmojiCategory(this.emojiId, this.image, this.label, this.color);

  static EmojiCategory fromEmojiId(int emojiId) {
    return EmojiCategory.values.firstWhere(
          (id) => id.emojiId == emojiId,
      orElse: () => EmojiCategory.unknown,
    );
  }
}
