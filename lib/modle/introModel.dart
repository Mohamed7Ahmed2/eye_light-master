class IntroModle{
  IntroModle({ required this.title, required this.desc});
  final String title;
  final String desc;

  static List<IntroModle> data = [
    IntroModle(
        title: 'Why Eye light',
        desc:'Blind people face many circumstances and events that require the help of others, which makes their lives and activities linked to the presence of the person responsible for themand the person responsible for them is not always present by their side'
    ),
    IntroModle(
        title: 'Why Eye light',
        desc:'this leads to anxiety by the blind and also their families in many cases, and this restricts their interaction and movement in life On the other hand, it limits their productivity in society'
    ),
    IntroModle(
        title: ' Eye light',
        desc: ' application that helps the blind learn about things around them without the need for the help of a person who is always with them'
    ),
  ];
}