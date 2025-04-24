// import 'package:daily_moode/features/mood_entry/bloc/daily_mood_bloc.dart';
// import 'package:daily_moode/features/mood_entry/bloc/daily_mood_event.dart';
// import 'package:daily_moode/features/mood_entry/models/mood_models.dart';
// import 'package:daily_moode/screens/cubit/emote_selection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// void moodEntryDialog(BuildContext context) {
//   final TextEditingController logEntryController = TextEditingController();
//   final moodImages = [
//     'assets/images/___.png',
//     'assets/images/Angry.png',
//     'assets/images/Confused.png',
//     'assets/images/Good.png',
//     'assets/images/Happy.png',
//     'assets/images/Horrible.png',
//     'assets/images/Worried.png',  ];
//
//   showDialog(
//     context: context,
//     builder: (context) {
//       return BlocProvider(
//         create: (_) => EmoteSelectionCubit(moodImages[0]),
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           title: Text('Sup!'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 BlocBuilder<EmoteSelectionCubit, String>(
//                   builder: (context, selectedMood) {
//                     return Wrap(
//                       spacing: 10,
//                       children:
//                           moodImages.map((imagePath) {
//                             final isSelected = selectedMood == imagePath;
//                             return GestureDetector(
//                               onTap:
//                                   () => context
//                                       .read<EmoteSelectionCubit>()
//                                       .selectEmote(imagePath),
//                               child: Container(
//                                 padding: EdgeInsets.all(4),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color:
//                                         isSelected
//                                             ? Colors.blue
//                                             : Colors.transparent,
//                                     width: 2,
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Image.asset(
//                                   imagePath,
//                                   height: 40,
//                                   width: 40,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: logEntryController,
//                   decoration: InputDecoration(
//                     labelText: 'How are you feeling?',
//                     border: OutlineInputBorder(),
//                   ),
//                   maxLines: 5,
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             BlocBuilder<EmoteSelectionCubit, String>(
//               builder: (context, selectedMood) {
//                 return ElevatedButton(onPressed: () {
//                   if (logEntryController.text.trim().isEmpty) return;
//
//                   final moodEntry = MoodModel(
//                     id: DateTime.now().toIso8601String(),
//                     label:
//                     moodImage: selectedMood,
//                     moodLog: logEntryController.text.trim(),
//                     timeStamp: DateTime.now(),
//                   );
//
//                   context.read<MoodBloc>().add(AddMoodEvent(moodEntry));
//                   Navigator.pop(context);
//
//                 }, child: Text('Save'));
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
