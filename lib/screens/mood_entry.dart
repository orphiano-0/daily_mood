// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:intl/intl.dart';
// import '../features/mood_entry/models/mood_model.dart' as mood_model;
// import '../features/mood_entry/mood_entry_bloc.dart';
// import '../features/mood_entry/mood_entry_event.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class MoodEntry extends StatefulWidget {
//   const MoodEntry({super.key});
//
//   @override
//   State<MoodEntry> createState() => _MoodEntryState();
// }
//
// class _MoodEntryState extends State<MoodEntry> {
//   int _currentEmojiIndex = 0;
//   final List<String> _emojis = ['😁', '😊', '🙂', '😐', '☹️', '😭'];
//   final List<String> _emojiLabels = ['Excellent', 'Happy', 'Good', 'Okay', 'Sad', 'Terrible'];
//   final List<String> _activityTags = [
//     'Working', 'Studying', 'Relaxing', 'Exercising', 'Eating',
//     'Socializing', 'Sleeping', 'Reading', 'Gaming', 'Traveling',
//     'Meditating', 'Creating', 'Learning', 'Celebrating', 'Reflecting'
//   ];
//
//   final List<bool> _selectedTags = List.generate(15, (_) => false);
//   final TextEditingController _journalController = TextEditingController();
//   double _moodScore = 5.0;
//
//   @override
//   void dispose() {
//     _journalController.dispose();
//     super.dispose();
//   }
//
//   String _getMoodLabel(double score) {
//     if (score >= 9) return 'Excellent';
//     if (score >= 7) return 'Happy';
//     if (score >= 5) return 'Good';
//     if (score >= 3) return 'Okay';
//     if (score >= 1) return 'Sad';
//     return 'Terrible';
//   }
//
//   Color _getMoodColor(double score) {
//     if (score >= 9) return Colors.purple;
//     if (score >= 7) return Colors.blue;
//     if (score >= 5) return Colors.green;
//     if (score >= 3) return Colors.amber;
//     if (score >= 1) return Colors.orange;
//     return Colors.red;
//   }
//
//   String _getMoodEmoji(double score) {
//     if (score >= 9) return '😁';
//     if (score >= 7) return '😊';
//     if (score >= 5) return '🙂';
//     if (score >= 3) return '😐';
//     if (score >= 1) return '☹️';
//     return '😭';
//   }
//
//   void _showMoodEntryDialog() {
//     final formKey = GlobalKey<FormState>();
//     double dialogMoodScore = _moodScore;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setDialogState) {
//               return AlertDialog(
//                 title: const Text('Log Today\'s Mood'),
//                 content: SingleChildScrollView(
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Column(
//                             children: [
//                               Text(
//                                 _getMoodEmoji(dialogMoodScore),
//                                 style: const TextStyle(fontSize: 48),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: _getMoodColor(dialogMoodScore),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 child: Text(
//                                   _getMoodLabel(dialogMoodScore),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Slider(
//                           value: dialogMoodScore,
//                           min: 0,
//                           max: 10,
//                           divisions: 10,
//                           label: dialogMoodScore.toStringAsFixed(1),
//                           activeColor: _getMoodColor(dialogMoodScore),
//                           onChanged: (value) {
//                             setDialogState(() {
//                               dialogMoodScore = value;
//                             });
//                           },
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Terrible', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//                             Text('Excellent', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Your Reflection',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),
//                         TextFormField(
//                           controller: _journalController,
//                           decoration: InputDecoration(
//                             hintText: 'Share your thoughts...',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           maxLines: 3,
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please write a reflection';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(dialogContext).pop();
//                     },
//                     child: const Text('Cancel'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         final bloc = context.read<MoodBloc>();
//                         bloc.add(AddMoodEntry(
//                           moodScore: dialogMoodScore,
//                           journalEntry: _journalController.text.trim(),
//                         ));
//
//                         // Save the mood score to the main state
//                         setState(() {
//                           _moodScore = dialogMoodScore;
//                         });
//
//                         // Clear the journal text
//                         _journalController.clear();
//
//                         Navigator.of(dialogContext).pop();
//
//                         // Show confirmation
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Mood entry saved!'),
//                             duration: Duration(seconds: 2),
//                           ),
//                         );
//                       }
//                     },
//                     child: const Text('Save Entry'),
//                   ),
//                 ],
//               );
//             }
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mood Tracker'),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Emoji Carousel
//             Padding(
//               padding: const EdgeInsets.only(top: 24, bottom: 12),
//               child: Column(
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       height: 120,
//                       viewportFraction: 0.3,
//                       enlargeCenterPage: true,
//                       enableInfiniteScroll: true,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _currentEmojiIndex = index;
//                         });
//                       },
//                     ),
//                     items: _emojis.map((emoji) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 emoji,
//                                 style: const TextStyle(fontSize: 48),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     _emojiLabels[_currentEmojiIndex],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // "What are you up to?" heading
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Text(
//                 'What are you up to?',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             // Activity tags grid
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: List.generate(_activityTags.length, (index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedTags[index] = !_selectedTags[index];
//                       });
//                     },
//                     child: Chip(
//                       label: Text(_activityTags[index]),
//                       backgroundColor: _selectedTags[index]
//                           ? Theme.of(context).primaryColor.withOpacity(0.2)
//                           : Colors.grey[200],
//                       labelStyle: TextStyle(
//                         color: _selectedTags[index]
//                             ? Theme.of(context).primaryColor
//                             : Colors.black87,
//                         fontWeight: _selectedTags[index]
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//
//             // Add Note Button
//             Padding(
//               padding: const EdgeInsets.all(24),
//               child: Center(
//                 child: ElevatedButton.icon(
//                   onPressed: _showMoodEntryDialog,
//                   icon: const Icon(Icons.add),
//                   label: const Text('Add Note'),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Define MoodEntryCard widget if not already defined
// class MoodEntryCard extends StatelessWidget {
//   final mood_model.MoodEntry entry;
//
//   const MoodEntryCard({required this.entry, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         title: Text(
//           entry.journalEntry ?? 'No journal entry',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           entry.timestamp != null
//               ? DateFormat('hh:mm a').format(entry.timestamp!)
//               : 'Unknown time',
//         ),
//         leading: Text(
//           entry.moodEmoji ?? '🙂',
//           style: const TextStyle(fontSize: 32),
//         ),
//       ),
//     );
//   }
// }