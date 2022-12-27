import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';
import 'package:polkawallet_sdk/api/apiKeyring.dart';
import 'package:polkawallet_sdk/api/types/addressIconData.dart';
import 'package:polkawallet_sdk/api/types/txInfoData.dart';
// import 'account.dart';
// import 'keyring.dart';
// import 'setting.dart';
// import 'tx.dart';








Future<void> _connectNode() async {
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
  print(res);
}

Future<void> _generateMnemonic() async{
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  int ss58 = 42;
  final AddressIconDataWithMnemonic seed = await sdk.api.keyring.generateMnemonic(ss58);
  final mnemonic = await sdk.api.keyring.generateMnemonic(ss58);
  print(mnemonic);
}

Future<void> _importFromMnemonic() async {

  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  const key = 'wing know chapter eight shed lens mandate lake twenty useless bless glory';
  const name = 'testName01';
  const String testPass = 'a123456';
  final json = await sdk.api.keyring.importAccount(
    keyring,
    keyType: KeyType.mnemonic,
    key:key,
    name: name,
    password: testPass,
  );
  final acc = await sdk.api.keyring.addAccount(
    keyring,
    keyType: KeyType.mnemonic,
    acc: json!,
    password: testPass,
  );
  print(acc);
}

Future<void> _estimateTxFee() async {
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);

  const String testPubKey = '0xe611c2eced1b561183f88faed0dd7d88d5fafdf16f5840c63ec36d8c31136f61';
  const String testAddress = '16CfHoeSifpXMtxVvNAkwgjaeBXK8rAm2CYJvQw4MKMjVHgm';
  const String testAddressGav = 'FcxNWVy5RESDsErjwyZmPCW6Z8Y3fbfLzmou34YZTrbcraL';
  final sender = TxSenderData(testAddress, testPubKey);
  final txInfo = TxInfoData('balances', 'transfer', sender);

  final res = await sdk.api.tx.estimateFees(txInfo, [
    // params.to
    testAddressGav,
    // params.amount
    '10000000000'
  ]);
  // showResult(context, 'estimateTxFees',
  //     JsonEncoder.withIndent('  ').convert(res.toJson()));
  // setState(() {
  //   _submitting = false;
  // });
}

Future<void> _sendTx() async {
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  const String testPubKey = '0xe611c2eced1b561183f88faed0dd7d88d5fafdf16f5840c63ec36d8c31136f61';
  const String testAddress = '16CfHoeSifpXMtxVvNAkwgjaeBXK8rAm2CYJvQw4MKMjVHgm';
  final sender = TxSenderData(
    testAddress,
    testPubKey
  );
  final txInfo = TxInfoData('balances', 'transfer', sender);
  const String testPass = 'a123456';
  try {
    final hash = await sdk.api.tx.signAndSend(
      txInfo,
      [
        '5HGjWAeFDfFCWPsjFQdVV2Msvz2XtMktvgocEZcCj68kUMaw',
        '1000000000000000000'
      ],
      testPass,
      onStatusChange: (status) {
        print(status);
      },
    );
   print(hash);
  }catch (err) {
    print(err);
  }
}

Future<void> _queryBalance() async {

  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);

  const String testAddress = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
  final res = await sdk.api.account.queryBalance(testAddress);
  print(res);
}

Future<void> _encodeAddress() async {
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  const String testPubKey = '0xe611c2eced1b561183f88faed0dd7d88d5fafdf16f5840c63ec36d8c31136f61';
  final res = await sdk.api.account.encodeAddress([testPubKey]);
}

Future<void> _decodeAddress() async {
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  const String testAddress = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
  final res = await sdk.api.account.decodeAddress([testAddress]);
}


Future<void> _queryNetworkConst() async {
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  final res = await sdk.api.setting.queryNetworkConst();
  print(res);
}

Future<void> _queryNetworkProperties() async {
  final sdk = WalletSDK();
  final Keyring keyring = Keyring();
  await keyring.init([0, 2]);
  final KeyringEVM keyringEVM = KeyringEVM();
  final api = await sdk.init(keyring, keyringEVM: keyringEVM);
  final res = await sdk.api.setting.queryNetworkProps();
}


main(){
  _connectNode();
  _queryBalance();
}


