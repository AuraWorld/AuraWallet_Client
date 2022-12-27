import 'package:get/get.dart';
import 'package:polkawallet_sdk/api/types/addressIconData.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';

class ConfigWalletController extends GetxController {

  final copyState = false.obs;

  @override
  void setCopyState() =>
      {
        copyState.value = true,
        Future.delayed(Duration(seconds: 2), () {
          copyState.value = false;
        }),
        print(copyState.value)
      };


  Future<AddressIconDataWithMnemonic> createAddress() async {
    // 登陆
    final sdk = WalletSDK();
    final Keyring keyring = Keyring();
    await keyring.init([0, 2]);
    final KeyringEVM keyringEVM = KeyringEVM();
    final api = await sdk.init(keyring, keyringEVM: keyringEVM);

    final node = NetworkParams();
    node.name = 'Web3Games';
    node.endpoint = 'wss://devnet.web3games.org/';
    node.ss58 = 42;

    final res = await sdk.api.connectNode(keyring, [node]);
    int ss58 = 42;
    final AddressIconDataWithMnemonic seed = await sdk.api.keyring.generateMnemonic(ss58);
    return seed;

  }

}