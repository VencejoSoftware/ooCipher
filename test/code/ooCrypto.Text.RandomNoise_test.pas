{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooCrypto.Text.RandomNoise_test;

interface

uses
  SysUtils, Forms,
  ooCrypto.Text.Intf,
  ooCrypto.Text.RandomNoise.RandomKey,
  ooCrypto.Text.RandomNoise,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TCryptoTextRandomNoiseTest = class sealed(TTestCase)
  published
    procedure EncryptSameTextWithMultipleReturn;
    procedure TryToUseSecurityKeyInvalid;
    procedure MinNoiseIsGreaterThanMaxNoise;
    procedure EncodeWithInvalidKeyRaiseError;
  end;

implementation

procedure TCryptoTextRandomNoiseTest.EncodeWithInvalidKeyRaiseError;
var
  Failed: Boolean;
  Encoded: String;
begin
  Failed := False;
  try
    Encoded := TCryptoTextRandomNoise.New('123456781234567812345678', 5, 0).Encode('text');
  except
    on E: ECryptoText do
    begin
      CheckEquals('Can not validate security string', E.Message);
      Failed := True;
    end;
  end;
  CheckTrue(Failed);
end;

procedure TCryptoTextRandomNoiseTest.EncryptSameTextWithMultipleReturn;
const
  SOURCE_TEXT = 'test 1234 encrypt ~+*@!#$%_''¿¡?';
var
  SC, Encoded: String;
  CryptoTextRandomNoise: ICryptoText;
begin
  SC := TCryptoTextRandomNoiseRandomKey.New.Build;
  CryptoTextRandomNoise := TCryptoTextRandomNoise.New(SC);
  Encoded := CryptoTextRandomNoise.Encode(SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Decode(Encoded) = SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Encode(SOURCE_TEXT) <> TCryptoTextRandomNoise.New(SC).Encode(SOURCE_TEXT));
end;

procedure TCryptoTextRandomNoiseTest.MinNoiseIsGreaterThanMaxNoise;
const
  SOURCE_TEXT = 'test 1234 encrypt ~+*@!#$%_''¿¡?';
var
  SC, Encoded: String;
  CryptoTextRandomNoise: ICryptoText;
begin
  SC := TCryptoTextRandomNoiseRandomKey.New.Build;
  CryptoTextRandomNoise := TCryptoTextRandomNoise.New(SC, 5, 0);
  Encoded := CryptoTextRandomNoise.Encode(SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Decode(Encoded) = SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Encode(SOURCE_TEXT) <> TCryptoTextRandomNoise.New(SC).Encode(SOURCE_TEXT));
end;

procedure TCryptoTextRandomNoiseTest.TryToUseSecurityKeyInvalid;
var
  CryptoTextRandomNoise: ICryptoText;
  ErrorFound: Boolean;
begin
  ErrorFound := False;
  try
    CryptoTextRandomNoise := TCryptoTextRandomNoise.New(EmptyStr);
    CryptoTextRandomNoise.Encode('Test');
  except
    on E: ECryptoText do
      ErrorFound := True;
  end;
  CheckTrue(ErrorFound);
end;

initialization

RegisterTest(TCryptoTextRandomNoiseTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
