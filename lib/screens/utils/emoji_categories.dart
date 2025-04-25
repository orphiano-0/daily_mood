import 'dart:ui';

enum EmojiCategory {
  unknown(0, 'assets/images/___.png', 'Unknown', Color(0xff6BBC46), ''),
  happy(
    1,
    'assets/images/Happy.png',
    'Happy',
    Color(0xffFFD700),
    "You're glowing with happiness! Keep spreading those good vibes.",
  ),
  angry(
    2,
    'assets/images/Angry.png',
    'Angry',
    Color(0xffFF6767),
    "It's okay to feel angry. Take a deep breath; you've got this.",
  ),
  good(
    3,
    'assets/images/Good.png',
    'Good',
    Color(0xffA7F3D0),
    "You're feeling good, and it shows! Keep enjoying the moment.",
  ),
  confused(
    4,
    'assets/images/Confused.png',
    'Confused',
    Color(0xffFCA5A5),
    "Feeling confused is a part of learning. You'll figure it out, step by step",
  ),
  horrible(
    5,
    'assets/images/Horrible.png',
    'Horrible',
    Color(0xffC0B2C3),
    "I'm sorry you're feeling this way. Remember, even the darkest clouds pass.",
  ),
  worried(
    6,
    'assets/images/Worried.png',
    'Worried',
    Color(0xff6EB9EF),
    "Worry is natural, but don't let it weigh you down. Things have a way of working out",
  );

  final int emojiId;
  final String image;
  final String label;
  final Color color;
  final String message;

  //constructor
  const EmojiCategory(
    this.emojiId,
    this.image,
    this.label,
    this.color,
    this.message,
  );

  static EmojiCategory fromEmojiId(int emojiId) {
    return EmojiCategory.values.firstWhere(
      (id) => id.emojiId == emojiId,
      orElse: () => EmojiCategory.unknown,
    );
  }
}
