import 'package:custom_simple_github_app/commons/globals.dart';
import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeIndexView extends StatelessWidget {
  const HomeIndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          ElevatedButton(
            child: SvgPicture.asset(
              'assets/images/favicon.svg',
              color: Colors.white,
              width: 26.0,
            ),
            onPressed: () {
              showMenu(
                context: context,
                position:
                    RelativeRect.fromLTRB(screenSize.width * .8, 60, 0, 20),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      context.goNamed(AppRoutes.signIn);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text('提示'),
                            );
                          });
                    },
                    padding: const EdgeInsets.only(left: 25.0, bottom: 8.0),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  const PopupMenuDivider(height: .8),
                  PopupMenuItem(
                    padding: const EdgeInsets.only(left: 25.0, top: 8.0),
                    onTap: () {
                      context.goNamed(AppRoutes.signUp);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text('提示'),
                            );
                          });
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
                color: Colors.grey[800],
              );
            },
          ),
        ],
      ),
      body: Theme(
        data: Globals.defaultTheme,
        child: Container(
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Colors.black87,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 150.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180.0,
                      child: Image.asset(
                        'assets/images/astro-mona.webp',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: const Text(
                        'Welcome GitHub',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                    const SearchWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  FocusNode searchFocus = FocusNode();
  TextEditingController searchContro = TextEditingController();
  bool hasInput = false;
  bool hasVisibitySearchJump = false;
  String searchText = '';
  String subSearchText = '';

  @override
  void initState() {
    super.initState();
    searchFocus.addListener(() {
      setState(() {
        hasInput = searchFocus.hasFocus;
        hasVisibitySearchJump = searchText.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchFocus.dispose();
    searchContro.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double searchWidth = MediaQuery.of(context).size.width * .5;
    return Container(
      height: 100.0,
      width: searchWidth,
      margin: const EdgeInsets.only(top: 35.0),
      child: Stack(
        children: [
          SizedBox(
            height: 40.0,
            child: Stack(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: .4,
                        color: Colors.white60,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: .6,
                        color: Colors.white70,
                      ),
                    ),
                    counterStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 9.0,
                    ),
                    hintText: 'Search GitHub',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 13.0,
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                  ),
                  maxLines: 1,
                  minLines: 1,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                  ],
                  cursorColor: Colors.white70,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 15.0,
                  ),
                  cursorHeight: 20.0,
                  focusNode: searchFocus,
                  controller: searchContro,
                  onChanged: (text) {
                    setState(() {
                      searchText = text;
                      subSearchText = text;
                      hasVisibitySearchJump = text.isNotEmpty;
                      if (text.length > 10) {
                        subSearchText =
                            subSearchText.substring(0, 10).padRight(11, '...');
                      }
                    });
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      debugPrint(value);
                      context.goNamed(
                        AppRoutes.repositorySearch,
                        params: {"searchText": value},
                      );
                    }
                  },
                ),
                Visibility(
                  visible: !hasInput,
                  child: Container(
                    width: 33.7,
                    height: 38.0,
                    color: Colors.grey[900],
                    margin: EdgeInsets.only(left: searchWidth - 35.0, top: 1.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 22.0,
                          height: 22.0,
                          margin: const EdgeInsets.only(top: 8.0, left: 6.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: .3, color: Colors.white60),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.0)),
                            color: Colors.black.withOpacity(.2),
                          ),
                          child: const Text(
                            '/',
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 36.5,
            child: Visibility(
              visible: hasVisibitySearchJump,
              child: GestureDetector(
                onTap: () => context.goNamed(
                  AppRoutes.repositorySearch,
                  params: {
                    'searchText': searchText,
                  },
                ),
                child: MouseRegion(
                  onEnter: (PointerEnterEvent e) {
                    setState(() {
                      hasVisibitySearchJump = searchText.isNotEmpty;
                      hasInput = true;
                    });
                  },
                  onExit: (PointerExitEvent e) {
                    setState(() {
                      hasVisibitySearchJump = false;
                      hasInput = false;
                    });
                  },
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: searchWidth,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(6.0),
                      ),
                      border: Border.all(color: Colors.black38, width: .7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.search, color: Colors.white60),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            subSearchText,
                            style: const TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Container(
                          width: 80.0,
                          height: 25.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(4.0),
                            border:
                                Border.all(width: .7, color: Colors.white38),
                          ),
                          child: const Text(
                            'All GitHub   ↵',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
