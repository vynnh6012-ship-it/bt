
import 'package:flutter/material.dart';

void main() {
  runApp(const EnglishLearningApp());
}

// ================= DỮ LIỆU =================

class Word {
  final String english;
  final String vietnamese;

  const Word(this.english, this.vietnamese);
}

class QuizResult {
  final String topic;
  final int score;
  final int total;
  final DateTime date;

  QuizResult({
    required this.topic,
    required this.score,
    required this.total,
    required this.date,
  });
}

const Map<String, List<Word>> topics = {
  'Động vật': [
    Word('Cat', 'Mèo'),
    Word('Dog', 'Chó'),
    Word('Bird', 'Chim'),
    Word('Fish', 'Cá'),
    Word('Tiger', 'Hổ'),
  ],
  'Trái cây': [
    Word('Apple', 'Táo'),
    Word('Banana', 'Chuối'),
    Word('Mango', 'Xoài'),
    Word('Orange', 'Cam'),
    Word('Grape', 'Nho'),
  ],
  'Màu sắc': [
    Word('Red', 'Đỏ'),
    Word('Blue', 'Xanh dương'),
    Word('Green', 'Xanh lá'),
    Word('Yellow', 'Vàng'),
    Word('Black', 'Đen'),
  ],
  'Gia đình': [
    Word('Father', 'Bố'),
    Word('Mother', 'Mẹ'),
    Word('Brother', 'Anh trai'),
    Word('Sister', 'Chị gái'),
    Word('Grandmother', 'Bà'),
  ],
  'Trường học': [
    Word('Teacher', 'Giáo viên'),
    Word('Student', 'Học sinh'),
    Word('Book', 'Sách'),
    Word('Pen', 'Bút'),
    Word('Classroom', 'Phòng học'),
  ],
  'Đồ ăn': [
    Word('Rice', 'Cơm'),
    Word('Bread', 'Bánh mì'),
    Word('Egg', 'Trứng'),
    Word('Soup', 'Súp'),
    Word('Chicken', 'Thịt gà'),
  ],
  'Đồ uống': [
    Word('Water', 'Nước'),
    Word('Milk', 'Sữa'),
    Word('Tea', 'Trà'),
    Word('Coffee', 'Cà phê'),
    Word('Juice', 'Nước ép'),
  ],
  'Nghề nghiệp': [
    Word('Doctor', 'Bác sĩ'),
    Word('Nurse', 'Y tá'),
    Word('Driver', 'Tài xế'),
    Word('Farmer', 'Nông dân'),
    Word('Chef', 'Đầu bếp'),
  ],
  'Phương tiện': [
    Word('Car', 'Ô tô'),
    Word('Bus', 'Xe buýt'),
    Word('Train', 'Tàu hỏa'),
    Word('Bicycle', 'Xe đạp'),
    Word('Airplane', 'Máy bay'),
  ],
  'Đồ vật': [
    Word('Table', 'Bàn'),
    Word('Chair', 'Ghế'),
    Word('Door', 'Cửa'),
    Word('Window', 'Cửa sổ'),
    Word('Clock', 'Đồng hồ'),
  ],
};

// ================= ỨNG DỤNG =================

class EnglishLearningApp extends StatefulWidget {
  const EnglishLearningApp({super.key});

  @override
  State<EnglishLearningApp> createState() =>
      _EnglishLearningAppState();
}

class _EnglishLearningAppState
    extends State<EnglishLearningApp> {
  final List<QuizResult> history = [];

  void saveResult(QuizResult result) {
    setState(() {
      history.insert(0, result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English E-Learning',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor:
        const Color(0xFFF3F8FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFDCEEFF),
          centerTitle: true,
        ),
      ),
      home: HomeScreen(
        history: history,
        onSaveResult: saveResult,
      ),
    );
  }
}

// ================= TRANG CHỦ =================

class HomeScreen extends StatelessWidget {
  final List<QuizResult> history;
  final ValueChanged<QuizResult> onSaveResult;

  const HomeScreen({
    super.key,
    required this.history,
    required this.onSaveResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English E-Learning'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 15),
          const Icon(
            Icons.school,
            size: 85,
            color: Colors.blue,
          ),
          const SizedBox(height: 15),
          const Text(
            'HỌC TIẾNG ANH MỖI NGÀY',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Học từ vựng - Kiểm tra - Xem kết quả',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),
          menuCard(
            context,
            Icons.menu_book,
            'Học từ vựng',
            '10 chủ đề tiếng Anh cơ bản',
            const TopicScreen(isQuiz: false),
          ),
          menuCard(
            context,
            Icons.quiz,
            'Làm bài kiểm tra',
            'Trắc nghiệm và chấm điểm',
            TopicScreen(
              isQuiz: true,
              onSaveResult: onSaveResult,
            ),
          ),
          menuCard(
            context,
            Icons.history,
            'Lịch sử kiểm tra',
            'Xem kết quả các bài đã làm',
            HistoryScreen(history: history),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Ứng dụng học tiếng Anh cơ bản',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuCard(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      Widget screen,
      ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          icon,
          size: 40,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}

// ================= DANH SÁCH CHỦ ĐỀ =================

class TopicScreen extends StatelessWidget {
  final bool isQuiz;
  final ValueChanged<QuizResult>? onSaveResult;

  const TopicScreen({
    super.key,
    required this.isQuiz,
    this.onSaveResult,
  });

  @override
  Widget build(BuildContext context) {
    final topicNames = topics.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isQuiz ? 'Chọn bài kiểm tra' : 'Chọn bài học',
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: topicNames.length,
        itemBuilder: (context, index) {
          final topic = topicNames[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text('${index + 1}'),
              ),
              title: Text(
                topic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${topics[topic]!.length} từ vựng',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      if (isQuiz) {
                        return QuizScreen(
                          topic: topic,
                          onSaveResult: onSaveResult!,
                        );
                      }

                      return LearnScreen(topic: topic);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= HỌC TỪ VỰNG =================

class LearnScreen extends StatefulWidget {
  final String topic;

  const LearnScreen({
    super.key,
    required this.topic,
  });

  @override
  State<LearnScreen> createState() =>
      _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final words = topics[widget.topic]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Từ ${index + 1}/${words.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.blue.shade50,
                child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.translate,
                        size: 50,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        words[index].english,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        words[index].vietnamese,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: index > 0
                        ? () {
                      setState(() {
                        index--;
                      });
                    }
                        : null,
                    child: const Text('Từ trước'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        index = (index + 1) % words.length;
                      });
                    },
                    child: const Text('Từ tiếp theo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= BÀI KIỂM TRA =================

class QuizScreen extends StatefulWidget {
  final String topic;
  final ValueChanged<QuizResult> onSaveResult;

  const QuizScreen({
    super.key,
    required this.topic,
    required this.onSaveResult,
  });

  @override
  State<QuizScreen> createState() =>
      _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;
  bool finished = false;
  String? selectedAnswer;

  late List<List<String>> allOptions;

  @override
  void initState() {
    super.initState();
    allOptions = generateOptions();
  }

  List<List<String>> generateOptions() {
    final words = topics[widget.topic]!;

    return List.generate(words.length, (index) {
      final answers = words
          .map((word) => word.vietnamese)
          .toList();

      answers.shuffle();
      return answers;
    });
  }

  void selectAnswer(String answer) {
    if (selectedAnswer != null || finished) {
      return;
    }

    final words = topics[widget.topic]!;

    setState(() {
      selectedAnswer = answer;

      if (answer == words[index].vietnamese) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) return;

    final words = topics[widget.topic]!;

    if (index < words.length - 1) {
      setState(() {
        index++;
        selectedAnswer = null;
      });
    } else {
      widget.onSaveResult(
        QuizResult(
          topic: widget.topic,
          score: score,
          total: words.length,
          date: DateTime.now(),
        ),
      );

      setState(() {
        finished = true;
      });
    }
  }

  void restartQuiz() {
    setState(() {
      index = 0;
      score = 0;
      finished = false;
      selectedAnswer = null;
      allOptions = generateOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final words = topics[widget.topic]!;

    if (finished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kết quả kiểm tra'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 90,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              const Text(
                'Hoàn thành bài kiểm tra!',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              Text(
                '$score/${words.length}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Số câu đúng: $score',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: restartQuiz,
                child: const Text('Làm lại bài kiểm tra'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Quay lại chủ đề'),
              ),
            ],
          ),
        ),
      );
    }

    final correctAnswer = words[index].vietnamese;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kiểm tra: ${widget.topic}'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                value: (index + 1) / words.length,
              ),
              const SizedBox(height: 20),
              Text(
                'Câu ${index + 1}/${words.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 25),
              Text(
                '"${words[index].english}" '
                    'có nghĩa là gì?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              for (final answer in allOptions[index])
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: selectedAnswer == null
                          ? () => selectAnswer(answer)
                          : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor:
                        selectedAnswer != null &&
                            answer == correctAnswer
                            ? Colors.green.shade100
                            : selectedAnswer == answer
                            ? Colors.red.shade100
                            : Colors.white,
                      ),
                      child: Text(
                        answer,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),

              if (selectedAnswer != null) ...[
                const SizedBox(height: 10),
                Text(
                  selectedAnswer == correctAnswer
                      ? 'Chính xác!'
                      : 'Sai rồi! Đáp án: $correctAnswer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: selectedAnswer == correctAnswer
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: nextQuestion,
                  child: Text(
                    index == words.length - 1
                        ? 'Xem kết quả'
                        : 'Câu tiếp theo',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ================= LỊCH SỬ KIỂM TRA =================

class HistoryScreen extends StatelessWidget {
  final List<QuizResult> history;

  const HistoryScreen({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử kiểm tra'),
      ),
      body: history.isEmpty
          ? const Center(
        child: Text(
          'Bạn chưa làm bài kiểm tra nào.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final result = history[index];
          final date = result.date;

          final dateText =
              '${date.day}/${date.month}/${date.year} '
              '${date.hour.toString().padLeft(2, '0')}:'
              '${date.minute.toString().padLeft(2, '0')}';

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.assignment_turned_in,
                color: Colors.blue,
                size: 35,
              ),
              title: Text(
                result.topic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(dateText),
              trailing: Text(
                '${result.score}/${result.total}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
