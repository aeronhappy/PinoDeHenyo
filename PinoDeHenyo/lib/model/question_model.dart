class QuestionModel {
  final String id;
  final String text;
  final String image;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.image,
  });
}

List<QuestionModel> questions = <QuestionModel>[
  const QuestionModel(
    id: '1',
    text: 'BAKA',
    image:
        'https://static.vecteezy.com/system/resources/previews/000/648/305/original/vector-cute-cow-cartoon.jpg',
  ),
  const QuestionModel(
    id: '2',
    text: 'BAHAY',
    image:
        'https://th.bing.com/th/id/R.3b2f7517f1ba23e595db4c290bce5abe?rik=IEOh5c5W8%2bFNJg&riu=http%3a%2f%2fshmector.com%2f_ph%2f7%2f113327418.png&ehk=fk%2b%2fmBupK%2bGsa%2bjx1g8BqeGMc0e3d1wqtG%2fDocc%2fH1M%3d&risl=&pid=ImgRaw&r=0',
  ),
  const QuestionModel(
    id: '3',
    text: 'BUKO',
    image:
        'https://th.bing.com/th/id/R.4e77caff92c31ce222db7f749b6b12d0?rik=DVM%2bDlWPtrJyLA&riu=http%3a%2f%2fimg.21food.com%2f20110609%2fdescript%2f1306414902979.jpg&ehk=ORTSEepWcf%2fTlUqaAbFzUliZaWUehV6CDkeTV907l68%3d&risl=&pid=ImgRaw&r=0',
  ),
  const QuestionModel(
    id: '4',
    text: 'ILAW',
    image:
        'https://th.bing.com/th/id/OIP.24mW5zDTQ-JxemuQwcxVAgHaHa?w=157&h=180&c=7&r=0&o=5&pid=1.7',
  ),
  const QuestionModel(
    id: '5',
    text: 'PUSA',
    image:
        'https://th.bing.com/th/id/OIP.2yhKZiqiUWZhG47Akxb6-AHaHa?w=205&h=205&c=7&r=0&o=5&pid=1.7',
  ),
];
