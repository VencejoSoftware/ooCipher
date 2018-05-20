{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooCrypto.Text.RandomNoise.RandomKey_test in '..\code\ooCrypto.Text.RandomNoise.RandomKey_test.pas',
  ooCrypto.Text.RandomNoise_test in '..\code\ooCrypto.Text.RandomNoise_test.pas',
  ooCrypto.Text.Base64_test in '..\code\ooCrypto.Text.Base64_test.pas',
  ooCrypto.Text.Base64 in '..\..\code\ooCrypto.Text.Base64.pas',
  ooCrypto.Text.Intf in '..\..\code\ooCrypto.Text.Intf.pas',
  ooCrypto.Text.RandomKey.Intf in '..\..\code\ooCrypto.Text.RandomKey.Intf.pas',
  ooCrypto.Text.RandomNoise in '..\..\code\ooCrypto.Text.RandomNoise.pas',
  ooCrypto.Text.RandomNoise.RandomKey in '..\..\code\ooCrypto.Text.RandomNoise.RandomKey.pas';

{R *.RES}

begin
  Run;

end.
