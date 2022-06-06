import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/view/todo_card.dart';
import 'package:untitled/view/todo_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _index = 0;
  late AnimationController animationController;
  late Animation<Color?> animation;

  final colors = <TweenSequenceItem<Color?>>[
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.orange, end: Colors.green),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.green, end: Colors.lightBlueAccent),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
          begin: Colors.lightBlueAccent, end: Colors.deepPurpleAccent),
    ),
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = TweenSequence<Color?>(colors).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: animation.value),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      Text(
                        "TODO",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(56, 24, 0, 12),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://source.unsplash.com/600x600/?face"),
                    radius: 32,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(56, 12, 0, 12),
                  child: Text(
                    "Hello, Jane.",
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(56, 0, 0, 36),
                  child: Text(
                    "Looks like feel good.\nYou have 3 tasks to do today.",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(56, 0, 0, 24),
                  child: Text(
                    "TODAY : June 6, 2022",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: PageView(
                    pageSnapping: true,
                    children: [
                      generateCard(0),
                      generateCard(1),
                      generateCard(2)
                    ],
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) {
                      setState(() {
                        _index = index;
                        animationController.animateTo(index / colors.length);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget generateCard(int index) {
    var title = ["Personal", "Work", "Extra"];
    var task = [8, 5, 7];
    var percentage = [0.83, 0.56, 0.39];
    return GestureDetector(
      onTap: () {
        Get.to(const TODOPage(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: TODOCard(
          percentage: percentage[index],
          title: title[index],
          task: task[index],
        ),
      ),
    );
  }
}
