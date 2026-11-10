class ClubLesson {
  const ClubLesson(this.week, this.title, this.date, this.description);
  final int week;
  final String title;
  final String date;
  final String description;

  String resource(String type) =>
      'https://machinelearning-club.github.io/w$week/$type/';
}

const lessons = <ClubLesson>[
  ClubLesson(1, 'What Is AI? Rules and Learning', '2 Dec 2026',
      'Identify the difference between fixed rules, learning, planning and generation.'),
  ClubLesson(2, 'Mathematics for Machine Learning', '9 Dec 2026',
      'Work with data, probability, statistics and information.'),
  ClubLesson(3, 'Decision Trees: ID3', '16 Dec 2026',
      'Turn questions about features into a decision-making tree.'),
  ClubLesson(4, 'Numeric Splits and Evaluation', '13 Jan 2027',
      'Measure accuracy and recognise when models overfit.'),
  ClubLesson(5, 'K-Nearest Neighbours', '20 Jan 2027',
      'Make predictions using nearby examples.'),
  ClubLesson(6, 'K-Means Clustering', '27 Jan 2027',
      'Discover groups without using labelled answers.'),
  ClubLesson(7, 'Linear Regression', '3 Feb 2027',
      'Adjust a straight line and measure prediction error.'),
  ClubLesson(8, 'Computer Vision', '10 Feb 2027',
      'Discover how images become numbers for learning algorithms.'),
  ClubLesson(9, 'Perceptrons and Neural Networks', '17 Feb 2027',
      'Combine weighted inputs to create a simple classifier.'),
  ClubLesson(10, 'Integrated AI Systems I', '3 Mar 2027',
      'Connect inputs, models and outputs into a complete pipeline.'),
  ClubLesson(11, 'Integrated AI Systems II', '10 Mar 2027',
      'Build and monitor a simple forecasting pipeline.'),
  ClubLesson(12, 'Language Models and Trust', '17 Mar 2027',
      'Understand generation, verification and responsible use.'),
  ClubLesson(13, 'FIICode: Baselines and Metrics', '24 Mar 2027',
      'Build a baseline and evaluate its performance.'),
  ClubLesson(14, 'FIICode: Error Analysis and Tuning', '31 Mar 2027',
      'Inspect mistakes and improve a model systematically.'),
  ClubLesson(15, 'FIICode: Mock Hackathon', '7 Apr 2027',
      'Present and explain a complete reproducible mini-project.'),
];

class QuizQuestion {
  const QuizQuestion(this.scenario, this.answer, this.explanation);
  final String scenario;
  final String answer;
  final String explanation;
}

const approaches = <String>[
  'Rules and automation',
  'Classification',
  'Regression',
  'Clustering',
  'Search and planning',
  'Reinforcement learning',
  'Generative AI',
];

const weekOneQuiz = <QuizQuestion>[
  QuizQuestion('Classroom lights switch on whenever the light sensor reads below 20.',
      'Rules and automation', 'This system follows a fixed threshold without learning.'),
  QuizQuestion('An app decides whether a leaf photo shows signs of disease.',
      'Classification', 'The model assigns a category to the image.'),
  QuizQuestion('A model predicts tomorrow\'s electricity use in kWh.',
      'Regression', 'The output is a continuous numerical value.'),
  QuizQuestion('An app groups similar songs without predefined genres.',
      'Clustering', 'The model finds structure in unlabelled data.'),
  QuizQuestion('A delivery app finds an efficient route through five addresses.',
      'Search and planning', 'The algorithm searches for a suitable sequence of actions.'),
  QuizQuestion('A robot improves its movements using rewards for safe actions.',
      'Reinforcement learning', 'The agent learns by acting and receiving feedback.'),
  QuizQuestion('A system drafts a new lesson summary from the student\'s notes.',
      'Generative AI', 'The system produces new content from the input.'),
];
