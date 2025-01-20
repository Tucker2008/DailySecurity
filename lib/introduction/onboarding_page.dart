// import 'package:flutter/foundation.dart';

import 'package:cyber_interigence/methods/associate_methods.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/constant/onboarding_page_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/main_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  // スキップまたは終了を押したときの処理
  // 設定情報を更新する(初期画面表示フラグを落とす)
  void _onIntroEnd(context) {
    PreferenceManager().flipIntroductionState();
    PreferenceManager().savePreference();
    //
    // ここでエラーメッセージを表示する(それしかない)
    final msg = NoteProvider().getNote();
    if (msg.isNotEmpty) {
      AssociateMethods().showSnackBarMsg(msg, context);
    }

    // メインスクリーンへ移行
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  // イメージ処理（のみ）デフォルトサイズは300
  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset("images/$assetName", width: width);
  }

  @override
  Widget build(BuildContext context) {
    // イントロ画面の表示詳細設定
    TextStyle bodyStyle = TextStyle(
      fontSize: fontSize.headlineH6,
      height: 1.3, //行間指定(これをしないとiOSで切れる)
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: fontSize.headlineH5,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.surfaceDim, //色調整必要
      imagePadding: EdgeInsets.zero,
      contentMargin: const EdgeInsets.symmetric(horizontal: 16),
      bodyFlex: 2,
      imageFlex: 3,
    );

    // IntroductionScreen
    // これをSafeAreaで囲わないと表示エリアが（特に下が）オーバーする
    // iOSは大丈夫そうだがAndroidがダメ
    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Theme.of(context).colorScheme.surfaceDim, //色調整必要
        allowImplicitScrolling: true,
        // 自動で進むときのページ毎の時間
        // 注意：コメントアウトすると例外発生
        autoScrollDuration: 10000,
        // 自動で繰り返しイントロを表示するか？
        infiniteAutoScroll: false,

        // 各ページのコンテンツ内容
        pages: [
          // １ページ目
          PageViewModel(
            titleWidget: Container(
              padding: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                title1st,
                style: TextStyle(
                  fontSize: fontSize.headlineH5,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            bodyWidget: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                body1st,
                style: bodyStyle,
              ),
            ),
            image: _buildImage(image1st),
            decoration: pageDecoration,
          ),
          // ２ページ目
          PageViewModel(
            titleWidget: Container(
              padding: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                title2nd,
                style: TextStyle(
                  fontSize: fontSize.headlineH5,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            bodyWidget: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                body2nd,
                style: bodyStyle,
              ),
            ),
            image: _buildImage(image2nd),
            decoration: pageDecoration,
          ),
          // ３ページ目
          PageViewModel(
            titleWidget: Container(
              padding: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                title3rd,
                style: TextStyle(
                  fontSize: fontSize.headlineH5,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            bodyWidget: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                body3rd,
                style: bodyStyle,
              ),
            ),
            image: _buildImage(image3rd),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        // showSkipButton と showBackButton は２択（両方trueは例外発生）
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: true,
        //rtl: true, // Display as right-to-left
        back: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onTertiaryFixed,
          size: 24 * (sizeConfig.screenWidthTimes!),
        ),
        skip: Text(skipTxt,
            style: TextStyle(
              fontSize: fontSize.body1,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onTertiaryFixed,
            )),
        next: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).colorScheme.onTertiaryFixed,
          size: 24 * (sizeConfig.screenWidthTimes!),
        ),
        done: Text(completeTxt,
            style: TextStyle(
              fontSize: fontSize.body1,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onTertiaryFixed,
            )),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: Theme.of(context)
              .colorScheme
              .onTertiaryFixed, //Color(0xFFBDBDBD),
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: ShapeDecoration(
          color:
              Theme.of(context).colorScheme.tertiaryFixedDim, //Colors.black87,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
