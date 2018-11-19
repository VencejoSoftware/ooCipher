{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  RunTest,
  NoiseRandomKey_test in '..\code\NoiseRandomKey_test.pas',
  RandomNoiseCipher_test in '..\code\RandomNoiseCipher_test.pas',
  Base64Cipher_test in '..\code\Base64Cipher_test.pas',
  Base64Cipher in '..\..\code\Base64Cipher.pas',
  Cipher in '..\..\code\Cipher.pas',
  RandomKey in '..\..\code\RandomKey.pas',
  RandomNoiseCipher in '..\..\code\RandomNoiseCipher.pas',
  NoiseRandomKey in '..\..\code\NoiseRandomKey.pas';

{R *.RES}

begin
  Run;

end.
