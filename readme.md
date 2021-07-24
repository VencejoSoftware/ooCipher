[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Build Status](https://travis-ci.org/VencejoSoftware/ooCipher.svg?branch=master)](https://travis-ci.org/VencejoSoftware/ooCipher)

# ooCipher- Object pascal cryptographic functions
Code to encrypt/decrypt text contents

### Example of encode/decode with base 64
```pascal
  Decoded := TBase64Cipher.New.Decode('VGVzdCAxMjM0IEAg0Q==');
  ...
  Encoded := TBase64Cipher.New.Encode('Test 1234 @ Ñ');
```

### Example of encode/decode with noise algorithm
```pascal
  Decoded := TRandomNoiseCipher.New('123456781234567812345678').Decode('~+*@!#$%_');
  ...
  Encoded := TRandomNoiseCipher.New('123456781234567812345678').Encode('text');
```

### Documentation
If not exists folder "code-documentation" then run the batch "build_doc". The main entry is ./doc/index.html

### Demo
Before all, run the batch "build_demo" to build proyect. Then go to the folder "demo\build\release\" and run the executable.

## Built With
* [Delphi&reg;](https://www.embarcadero.com/products/rad-studio) - Embarcadero&trade; commercial IDE
* [Lazarus](https://www.lazarus-ide.org/) - The Lazarus project

## Contribute
This are an open-source project, and they need your help to go on growing and improving.
You can even fork the project on GitHub, maintain your own version and send us pull requests periodically to merge your work.

## Authors
* **Alejandro Polti** (Vencejo Software team lead) - *Initial work*