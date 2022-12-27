import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/NFTInfo/bindings/test_binding.dart';
import '../modules/NFTInfo/views/NFTInfo_view.dart';
import '../modules/addTokenList/bindings/addTokenList_binding.dart';
import '../modules/addTokenList/views/addTokenList_view.dart';
import '../modules/avatar/bindings/avatar_binding.dart';
import '../modules/avatar/views/avatar_view.dart';
import '../modules/collection/bindings/collection_binding.dart';
import '../modules/collection/views/collection_view.dart';
import '../modules/config/bindings/config_binding.dart';
import '../modules/config/views/config_view.dart';
import '../modules/configAbout/bindings/configAbout_binding.dart';
import '../modules/configAbout/views/configAbout_view.dart';
import '../modules/configAddressBook/bindings/configAddressBook_binding.dart';
import '../modules/configAddressBook/views/configAddressBook_view.dart';
import '../modules/configAddressBookList/bindings/configAddressBookList_binding.dart';
import '../modules/configAddressBookList/views/configAddressBookList_view.dart';
import '../modules/configEditAddressBook/bindings/configEditAddressBook_binding.dart';
import '../modules/configEditAddressBook/views/configEditAddressBook_view.dart';
import '../modules/configWallet/bindings/config_binding.dart';
import '../modules/configWallet/views/configWallet_view.dart';
import '../modules/configWalletList/bindings/config_binding.dart';
import '../modules/configWalletList/views/configWalletList_view.dart';
import '../modules/createAccountStep1/bindings/createAccountStep1_binding.dart';
import '../modules/createAccountStep1/views/createAccountStep1_view.dart';
import '../modules/createAccountStep2/bindings/createAccountStep2_binding.dart';
import '../modules/createAccountStep2/views/createAccountStep2_view.dart';
import '../modules/createdSuccess/bindings/createdSuccess_binding.dart';
import '../modules/createdSuccess/views/createdSuccess_view.dart';
import '../modules/explorer/bindings/explorer_binding.dart';
import '../modules/explorerMore/bindings/explorerMore_binding.dart';
import '../modules/explorerMore/views/explorerMore_view.dart';
import '../modules/explorer_info/bindings/explorer_info_binding.dart';
import '../modules/explorer_info/views/explorer_info_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/loginMethod/bindings/loginMethod_binding.dart';
import '../modules/loginMethod/views/loginMethod_view.dart';
import '../modules/explorer/views/explorer_view.dart';
import '../modules/manageTokenList/bindings/manageTokenList_binding.dart';
import '../modules/manageTokenList/controllers/manageTokenList_controller.dart';
import '../modules/manageTokenList/views/manageTokenList_view.dart';
import '../modules/token/bindings/token_binding.dart';
import '../modules/token/views/token_view.dart';
import '../modules/tokenInfo/bindings/tokenInfo_binding.dart';
import '../modules/tokenInfo/views/tokenInfo_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/transactionAnimation/bindings/transactionAnimation_binding.dart';
import '../modules/transactionAnimation/views/transactionAnimation_view.dart';
import '../modules/transactionHistory/bindings/test_binding.dart';
import '../modules/transactionHistory/views/transactionHistory_view.dart';
import '../modules/web_explorer/bindings/web_explorer_binding.dart';
import '../modules/web_explorer/views/web_explorer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static   String INITIAL = GetStorage().read('address')==null? Routes.LOGIN:Routes.HOME;

  // static   String INITIAL =  Routes.LOGIN;
  static final routes = [
    GetPage(
      name: _Paths.Token,
      page: () =>  TokenViewState(),
      binding: TokenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.introduction,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COLLECTION,
      page: () => const CollectionView(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORER,
      page: () =>  ExplorerView(),
      binding: ExplorerBinding(),
    ),
    GetPage(
      name: _Paths.CONFIG,
      page: () => const ConfigView(),
      binding: ConfigBinding(),
    ),
    GetPage(
      name: _Paths.NFTInfo,
      page: () =>  NFTInfoView(),
      binding: NFTInfoBindings(),
    ),
    GetPage(
      name: _Paths.transactionHistory,
      page: () =>  TransactionHistoryView(),
      binding: TransactionHistory(),
    ),
    GetPage(
      name: _Paths.tokenInfo,
      page: () =>  TokenInfoView(),
      binding: TokenInfoBinding(),
    ),
    GetPage(
      name: _Paths.configWallet,
      page: () =>  ConfigWalletView(),
      binding: ConfigWalletBinding(),
    ),
    GetPage(
      name: _Paths.configWalletList,
      page: () =>  ConfigWalleListView(),
      binding: ConfigWalletListBinding(),
    ),
    GetPage(
      name: _Paths.configAbout,
      page: () =>  ConfigAboutView(),
      binding: ConfigAboutBinding(),
    ),
    GetPage(
      name: _Paths.loginMethod,
      page: () =>  LoginMethodView(),
      binding: LoginMethodBinding(),
    ),
    GetPage(
      name: _Paths.createAccountStep1,
      page: () =>  CreateAccountStep1View(),
      binding: CreateAccountStep1Binding(),
    ),
    GetPage(
      name: _Paths.createAccountStep2,
      page: () =>  CreateAccountStep2View(),
      binding: CreateAccountStep2Binding(),
    ),
    GetPage(
      name: _Paths.createdSuccess,
      page: () =>  CreatedSuccessView(),
      binding: CreatedSuccessBinding(),
    ),
    GetPage(
      name: _Paths.transactionAnimation,
      page: () => TransactionAnimationView(),
      binding: TransactionAnimationBinding(),
    ),
    GetPage(
      name: _Paths.avatar,
      page: () => AvatarInfoView(),
      binding: AvatarInfoBindings(),
    ),
    GetPage(
      name: _Paths.explorer_Info,
      page: () => Explorer_InfoView(),
      binding: Explorer_InfoBinding(),
    ),
    GetPage(
      name: _Paths.explorerMore,
      page: () => ExplorerMoreView(),
      binding: ExplorerMoreBinding(),
    ),

    GetPage(
      name: _Paths.configAddressBookList,
      page: () => ConfigAddressBookListView(),
      binding: ConfigAddressBookListBinding(),
    ),
    GetPage(
      name: _Paths.configAddressBook,
      page: () => ConfigAddressBookView(),
      binding: ConfigAddressBookBinding(),
    ),

    GetPage(
      name: _Paths.configEditAddressBook,
      page: () => ConfigEditAddressBookView(),
      binding: ConfigEditAddressBookBinding(),
    ),

    GetPage(
      name: _Paths.manageTokenList,
      page: () => ManageTokenListInfoView(),
      binding: ManageTokenListBinding(),
    ),

    GetPage(
      name: _Paths.addTokenList,
      page: () => AddTokenListInfoView(),
      binding: AddTokenListBinding(),
    ),
    GetPage(
      name: _Paths.webExplorer,
      page: () => WebViewExample(),
      binding: WebExplorerBinding(),
    ),



  ];




}
