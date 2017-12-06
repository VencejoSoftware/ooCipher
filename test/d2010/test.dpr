{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooCrypto.Text.RandomNoise.RandomKey_test in '..\code\ooCrypto.Text.RandomNoise.RandomKey_test.pas',
  ooCrypto.Text.RandomNoise_test in '..\code\ooCrypto.Text.RandomNoise_test.pas';
{$R *.RES}

begin
  Run;

end.
