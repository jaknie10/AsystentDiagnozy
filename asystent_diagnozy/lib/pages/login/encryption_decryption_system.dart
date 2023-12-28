// You can read the article I wrote for this setup on medium.com at the link below
// https://medium.com/@rishi_singh/how-to-implement-end-to-end-encryption-using-pbkdf-in-flutter-a5508e7ad93e

//Kod pochodzi z repozytorium:
//https://gist.github.com/rishi-singh26/4d02a6900820b0e6bfc6e2a208061a87

import 'dart:math';
import 'dart:typed_data';

import 'package:crypton/crypton.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'dart:convert';
import 'package:pointycastle/pointycastle.dart'
    hide RSAPublicKey, RSAPrivateKey;

PrivateKeyEncryptionResult signUp(String password) {
  // Generate PBKDF key
  final String randomSaltOne = CryptoService.generateRandomSalt();
  final Uint8List pbkdfKey =
      CryptoService.generatePBKDFKey(password, randomSaltOne);

  // Generate RSA Key Pair
  final RSAKeypair keyPair = CryptoService.getKeyPair();

  // Encrypt Private key
  final privateKeySalt = CryptoService.generateRandomSalt();
  final encryptedPrivateKey = CryptoService.symetricEncrypt(
    pbkdfKey,
    Uint8List.fromList(privateKeySalt.codeUnits),
    Uint8List.fromList(keyPair.privateKey.toFormattedPEM().codeUnits),
  );
  return PrivateKeyEncryptionResult(
    publicKey: keyPair.publicKey.toFormattedPEM(),
    encryptedPrivateKey: String.fromCharCodes(encryptedPrivateKey),
    randomSaltOne: randomSaltOne,
    randomSaltTwo: privateKeySalt,
  );
}

class PrivateKeyEncryptionResult {
  final String publicKey;
  final String encryptedPrivateKey;
  final String randomSaltOne;
  final String randomSaltTwo;

  PrivateKeyEncryptionResult({
    required this.publicKey,
    required this.encryptedPrivateKey,
    required this.randomSaltOne,
    required this.randomSaltTwo,
  });
}

LoginResult login(String randomSaltOne, String randomSaltTwo,
    String encryptedPrivateKey, String password) {
  final Uint8List pbkdfKey =
      CryptoService.generatePBKDFKey(password, randomSaltOne);

  // decrypt private key
  try {
    Uint8List decryptedPrivateKey = CryptoService.symetricDecrypt(
      pbkdfKey,
      Uint8List.fromList(randomSaltTwo.codeUnits),
      Uint8List.fromList(encryptedPrivateKey.codeUnits),
    );

    return LoginResult(
      privateKey: String.fromCharCodes(decryptedPrivateKey),
      randomSaltOne: randomSaltOne,
      randomSaltTwo: randomSaltTwo,
    );
  } on ArgumentError catch (e) {
    print("Exception $e");
  }

  return LoginResult(privateKey: "", randomSaltOne: "", randomSaltTwo: "");
}

class LoginResult {
  final String privateKey;
  final String randomSaltOne;
  final String randomSaltTwo;

  LoginResult({
    required this.privateKey,
    required this.randomSaltOne,
    required this.randomSaltTwo,
  });
}

PrivateKeyEncryptionResult resetPassword(
    String encryptedPrivateKey,
    String publicKey,
    String randomSaltOne,
    String randomSaltTwo,
    String currentPass,
    String newPass) {
  final Uint8List pbkdfKey =
      CryptoService.generatePBKDFKey(currentPass, randomSaltOne);

  // decrypt private key
  try {
    Uint8List decryptedPrivateKey = CryptoService.symetricDecrypt(
      pbkdfKey,
      Uint8List.fromList(randomSaltTwo.codeUnits),
      Uint8List.fromList(encryptedPrivateKey.codeUnits),
    );

    // generate pbkdf key using new password
    final Uint8List newPbkdfKey =
        CryptoService.generatePBKDFKey(newPass, randomSaltOne);

    // encrypt private key with new pbkdf key
    final encryptedPrivateKey1 = CryptoService.symetricEncrypt(
      newPbkdfKey,
      Uint8List.fromList(randomSaltTwo.codeUnits),
      decryptedPrivateKey,
    );

    return PrivateKeyEncryptionResult(
      publicKey: publicKey,
      encryptedPrivateKey: String.fromCharCodes(encryptedPrivateKey1),
      randomSaltOne: randomSaltOne,
      randomSaltTwo: randomSaltTwo,
    );
  } on ArgumentError catch (e) {
    print("Exception $e");
  }

  return PrivateKeyEncryptionResult(
      publicKey: "",
      encryptedPrivateKey: "",
      randomSaltOne: "",
      randomSaltTwo: "");
}

class CryptoResult {
  final bool status;
  final String data;
  CryptoResult({required this.data, required this.status});
}

class CryptoService {
  static RSAKeypair getKeyPair() {
    RSAKeypair rsaKeypair = RSAKeypair.fromRandom();
    return rsaKeypair;
  }

  static CryptoResult assymetricEncrypt(String text, RSAPublicKey pubKey) {
    try {
      String encrypted = pubKey.encrypt(text);
      return CryptoResult(data: encrypted, status: true);
    } catch (err) {
      print(err.toString());
      return CryptoResult(data: err.toString(), status: false);
    }
  }

  static CryptoResult assymetricDecript(
      String encodedTxt, RSAPrivateKey pvKey) {
    try {
      String decoded = pvKey.decrypt(encodedTxt);
      return CryptoResult(data: decoded, status: true);
    } catch (err) {
      // print(err.toString());
      return CryptoResult(data: err.toString(), status: false);
    }
  }

  static String generateRandomSalt({int length = 16}) {
    final random = Random.secure();
    final saltCodeUnits =
        List<int>.generate(length, (_) => random.nextInt(256));
    return String.fromCharCodes(saltCodeUnits);
  }

  static Uint8List generatePBKDFKey(String password, String salt,
      {int iterations = 10000, int derivedKeyLength = 32}) {
    final passwordBytes = utf8.encode(password);
    final saltBytes = utf8.encode(salt);

    final params = Pbkdf2Parameters(
        Uint8List.fromList(saltBytes), iterations, derivedKeyLength);
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));

    pbkdf2.init(params);

    return pbkdf2.process(Uint8List.fromList(passwordBytes));
  }

  static Uint8List symetricEncrypt(
      Uint8List key, Uint8List iv, Uint8List plaintext) {
    final cipher = PaddedBlockCipherImpl(PKCS7Padding(), AESEngine());
    final params = PaddedBlockCipherParameters(
      KeyParameter(key),
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
    );
    cipher.init(true, params);
    return cipher.process(plaintext);
  }

  static Uint8List symetricDecrypt(
      Uint8List key, Uint8List iv, Uint8List ciphertext) {
    final cipher = PaddedBlockCipherImpl(PKCS7Padding(), AESEngine());
    final params = PaddedBlockCipherParameters(
      KeyParameter(key),
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
    );
    cipher.init(false, params);
    return cipher.process(ciphertext);
  }
}
