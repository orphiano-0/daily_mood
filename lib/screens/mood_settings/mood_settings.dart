// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../features/mood_entry/mood_entry_bloc.dart';
// import '../../features/mood_entry/mood_entry_event.dart';
// import '../../shared/theme/theme_controller.dart';

// class MoodSettings extends StatefulWidget {
//   const MoodSettings({super.key});

//   @override
//   State<MoodSettings> createState() => _MoodSettingsState();
// }

// class _MoodSettingsState extends State<MoodSettings> {
//   final TextEditingController _confirmController = TextEditingController();

//   @override
//   void dispose() {
//     _confirmController.dispose();
//     super.dispose();
//   }

//   void _showTeamInfoDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('About Our Team'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTeamMember('Gabriel Orphiano', 'Leader', 'App architecture', Icons.code),
//               const SizedBox(height: 16),
//               _buildTeamMember('Kerby Canaria', 'Database Manager', 'Local database', Icons.storage),
//               const SizedBox(height: 16),
//               _buildTeamMember('Zaki Vishnu Cinco', 'Supporting Developer', 'UI and UX', Icons.design_services_outlined),
//               const SizedBox(height: 24),
//               const Text('Version 1.0.0', style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               const Text('© 2025 Mood Tracker Team', style: TextStyle(color: Colors.grey, fontSize: 12)),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTeamMember(String name, String role, String description, IconData icon) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: Theme.of(context).primaryColor),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               Text(role, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500)),
//               const SizedBox(height: 4),
//               Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showClearDataDialog() {
//     final moodBloc = context.read<MoodBloc>();
//     // Check if there is data to clear
//     final hasData = moodBloc.state.entries.isNotEmpty; // Use the correct property

//     if (!hasData) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No data to clear'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Clear All Data'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'This will permanently delete all your mood entries and cannot be undone.',
//               style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),
//             const Text('To confirm, please type "DELETE" below:'),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _confirmController,
//               decoration: const InputDecoration(
//                 hintText: 'Type DELETE to confirm',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _confirmController.clear();
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (_confirmController.text == 'DELETE') {
//                 moodBloc.add(ClearAllMoodEntries());

//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('All data has been cleared'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Confirmation text does not match "DELETE"'),
//                     backgroundColor: Colors.orange,
//                   ),
//                 );
//               }
//               _confirmController.clear();
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Clear Data'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeController>(
//       builder: (context, themeController, _) {
//         final isDarkMode = themeController.themeMode == ThemeMode.dark;

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               'SETTINGS',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Pixel',
//                 color: Colors.white,
//               ),
//             ),
//             backgroundColor: Colors.blueGrey.shade900,
//             centerTitle: true,
//             elevation: 0,
//           ),
//           body: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               const SizedBox(height: 16),
//               Center(
//                 child: Text(
//                   'THEME',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.5,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildThemeButton(
//                       title: 'Light Mode',
//                       icon: Icons.light_mode,
//                       isSelected: !isDarkMode,
//                       onTap: () => themeController.setLightMode(),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildThemeButton(
//                       title: 'Dark Mode',
//                       icon: Icons.dark_mode,
//                       isSelected: isDarkMode,
//                       onTap: () => themeController.setDarkMode(),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               _buildSettingItem(
//                 title: 'About Our Team',
//                 icon: Icons.people,
//                 onTap: _showTeamInfoDialog,
//               ),
//               const SizedBox(height: 8),
//               _buildSettingItem(
//                 title: 'Clear All Data',
//                 icon: Icons.delete_forever,
//                 onTap: _showClearDataDialog,
//                 isDestructive: true,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildThemeButton({
//     required String title,
//     required IconData icon,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(vertical: 24),
//         decoration: BoxDecoration(
//           color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: isSelected
//               ? [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
//               : [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: 40,
//               color: isSelected ? Colors.white : Theme.of(context).primaryColor,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : Theme.of(context).primaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingItem({
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//     bool isDestructive = false,
//   }) {
//     return Card(
//       elevation: 1,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: isDestructive ? Colors.red.withOpacity(0.1) : Theme.of(context).primaryColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   icon,
//                   color: isDestructive ? Colors.red : Theme.of(context).primaryColor,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: isDestructive ? Colors.red : Theme.of(context).textTheme.bodyLarge?.color,
//                   ),
//                 ),
//               ),
//               Icon(Icons.chevron_right, color: Colors.grey[400]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
