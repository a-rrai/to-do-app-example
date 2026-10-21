import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class TaskItem {
  String title;
  String time;
  bool isDone;

  TaskItem({
    required this.title,
    required this.time,
    this.isDone = false,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(
        fontFamily: 'Outfit',
      ),
      home: const TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final Color primaryBlue = const Color(0xFF4A55A2);

  List<TaskItem> myTasks = [];

  void _showTaskForm({int? index}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    if (index != null) {
      titleController.text = myTasks[index].title;
      timeController.text = myTasks[index].time;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                index == null ? 'Add New Task' : 'Edit Task',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Judul Tugas (ex: Belajar)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: timeController,
                decoration: InputDecoration(
                  hintText: 'Waktu Tugas (ex: 08:00 - 09:00)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty && timeController.text.isNotEmpty) {
                      setState(() {
                        if (index == null) {
                          myTasks.add(
                            TaskItem(
                              title: titleController.text,
                              time: timeController.text,
                            ),
                          );
                        } else {
                          myTasks[index].title = titleController.text;
                          myTasks[index].time = timeController.text;
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    index == null ? 'Save Task' : 'Update Task',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      myTasks.removeAt(index);
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      myTasks[index].isDone = !myTasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 24.0, right: 24.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${myTasks.length} tasks',
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => _showTaskForm(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Add New', style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                ),
                child: myTasks.isEmpty
                    ? const Center(
                        child: Text(
                          "Belum ada tugas hari ini.\nTekan 'Add New' untuk memulai.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: myTasks.length,
                        itemBuilder: (context, index) {
                          final task = myTasks[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _toggleTaskStatus(index),
                                  child: Icon(
                                    task.isDone ? Icons.check_box_rounded : Icons.crop_square_rounded,
                                    color: task.isDone ? primaryBlue : Colors.grey.shade400,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _toggleTaskStatus(index),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            decoration: task.isDone ? TextDecoration.lineThrough : null,
                                            color: task.isDone ? Colors.grey : Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          task.time,
                                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 22),
                                  onPressed: () => _showTaskForm(index: index),
                                ),
                                
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}