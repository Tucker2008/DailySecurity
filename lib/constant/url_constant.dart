// URL定義
// 取り込むURL定義
// IPAのセキュリティアラート
const ipaRss = "https://www.ipa.go.jp/security/alert-rss.rdf";
const ipaHost = "www.ipa.go.jp";

// JVNの脆弱性情報
const jvnRss = "https://jvn.jp/rss/jvnJP.rdf";

// JPCERT/CC RSS
const jpcertRss = "https://www.jpcert.or.jp/rss/jpcert.rdf";
const jpcertStartURL = "https://www.jpcert.or.jp";

// ココログのインシデントに学ぶセキュリティアクション及びトピックス
const cocologRss = "https://aokabi.way-nifty.com/blog/index.rdf";
const cocologHost = "aokabi.way-nifty.com";

// インシデントニュース関連フィード
const itMediaRss = "https://rss.itmedia.co.jp/rss/2.0/news_security.xml";
const scanNsRss = "https://scan.netsecurity.ne.jp/rss/index.rdf";
const snextRss = "http://www.security-next.com/feed";
// const mynaviRss =
//     "http://feeds.journal.mycom.co.jp/rss/mycom/enterprise/security";
const rboysRss = "https://rocket-boys.co.jp/feed/";

// 海外サイトのRSS URL
const cisaRss = "https://www.cisa.gov/news.xml";
const ncscRss = "https://www.ncsc.gov.uk/api/1/services/v1/report-rss-feed.xml";
const swRss = "https://feeds.feedburner.com/securityweek";
const hnRss = "https://feeds.feedburner.com/TheHackersNews";
const nistRSS = "https://www.nist.gov/news-events/cybersecurity/rss.xml";
const sosRss = "https://www.schneier.com/feed/atom/";
const taoRss = "http://taosecurity.blogspot.com/atom.xml";
const krebRss = "https://krebsonsecurity.com/feed/";

// フィッシングサイト
const fishRss = "http://www.antiphishing.jp/atom.xml";

//
// カテゴリ定義
const ipaCategory = "ipa";
const jvnCategory = "jvn";
const jcrCategory = "jcr";
const fisCategory = "fis";
// インシデント　カテゴリ定義
const itmCategory = "itm";
const scnCategory = "scn";
const sntCategory = "snt";
// const mynCategory = "myn";
const rbyCategory = "rby";
// 海外サイト
const cisCategory = "cis";
const ncsCategory = "ncs";
const swnCategory = "swn";
const hnnCategory = "hnn";
const krbCategory = "krb";
const nisCategory = "nis";
const sosCategory = "sos";
const taoCategory = "tao";

// post_category.dartにも同様の種類定義あり
const Map<String, String> rssUrls = {
  // ipaRss: ipaCategory,    IPAはTOPニュースに入れたので、ここでは入れない 2025.6.19
  jvnRss: jvnCategory,
  jpcertRss: jcrCategory,
  fishRss: fisCategory,
};

// アプリスタート時に必ず読むニュース
const Map<String, String> startRssUrls = {
  ipaRss: ipaCategory,
  jvnRss: jvnCategory,
  jpcertRss: jcrCategory,
  // インシデント系ニュースも入れてみる 2026.6.19
  itMediaRss: itmCategory,
  scanNsRss: scnCategory,
  snextRss: sntCategory,
  // mynaviRss: mynCategory,
  rboysRss: rbyCategory,
};

// アプリスタート時に必ず読むTOPニュース
const Map<String, String> topNewsRssUrls = {
  ipaRss: ipaCategory,
};

// インシデントニュース
const Map<String, String> incidentRssUrls = {
  itMediaRss: itmCategory,
  scanNsRss: scnCategory,
  snextRss: sntCategory,
  // mynaviRss: mynCategory,
  rboysRss: rbyCategory,
};

// 海外ニュースサイト
const Map<String, String> foreignRssUrls = {
  cisaRss: cisCategory,
  ncscRss: ncsCategory,
  swRss: swnCategory,
  hnRss: hnnCategory,
  krebRss: krbCategory,
  nistRSS: nisCategory,
  sosRss: sosCategory,
  taoRss: taoCategory,
};

// 英訳が必要なサイト群
// ※うまく動かなそうなサイトは英訳サイトに入れない様にする
const List<String> translateSite = [
  cisaRss, // 確認済
  // ncscRss,   // うまく動かない
  // swRss,     // うまく動かない
  hnRss, // 確認済
  krebRss, // 確認済
  nistRSS, // 確認済
  sosRss, // 確認済
  taoRss // 確認済
];

// CategoryとIconファイルとの対照表
const Map<String, String> categoryIconMap = {
  ipaCategory: 'ipa_logo.png',
  jvnCategory: 'jvn_logo.png',
  jcrCategory: 'jcr_logo.png',
  fisCategory: 'fis_logo.png',
  // インシデントニュースサイト系 後でロゴを設定
  itmCategory: 'itm_logo.png',
  scnCategory: 'scn_logo.png',
  sntCategory: 'snt_logo.png',
  // mynCategory: 'myn_logo.png',
  rbyCategory: 'rby_logo.png',
  // 海外サイト系
  cisCategory: 'cis_logo.png',
  ncsCategory: 'ncs_logo.png',
  swnCategory: 'securityweek.png',
  hnnCategory: 'thehackernews.png',
  krbCategory: 'krebsonsecurity.png',
  nisCategory: 'nist.png',
  sosCategory: 'schneier.png',
  taoCategory: 'taosecurity.png',
};

// 各情報サイトの説明文
// IPA
const ipaName = "IPA（情報処理推進機構）の重要なセキュリティ情報";
const newsDetail = "セキュリティ上の重要な情報を時系列にまとめて掲載しています。";

// jpsert/cc
const jpcertName = "JPCERT/CC（JPCERTコーディネーションセンター）の注意喚起";

// JVN
const jvnName = "JVN（脆弱性対策情報ポータルサイト）の重要なセキュリティ情報";

// ニュース共通
const webTitle =
    "IPA（情報処理推進機構）をはじめとする国内のセキュリティ情報サイト、及び海外の情報セキュリティ関連サイトのページを表示しています";
// "IPA（情報処理推進機構）、JPCERT/CC（JPCERTコーディネーションセンター）、JVN（脆弱性対策情報ポータルサイト）のページを表示しています";

// 利用規約やプライバシーポリシーページ
const privercyPage =
    "https://cyber-interigence.firebaseapp.com/assets/index_security_policy.html";
const termofusePage =
    "https://cyber-interigence.firebaseapp.com/assets/index_terms_of_use.html";
