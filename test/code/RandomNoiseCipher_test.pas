{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit RandomNoiseCipher_test;

interface

uses
  SysUtils, Forms,
  Cipher,
  NoiseRandomKey,
  RandomNoiseCipher,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TRandomNoiseCipherTest = class sealed(TTestCase)
  published
    procedure EncryptSameTextWithMultipleReturn;
    procedure TryToUseSecurityKeyInvalid;
    procedure MinNoiseIsGreaterThanMaxNoise;
    procedure EncodeWithInvalidKeyRaiseError;
  end;

implementation

procedure TRandomNoiseCipherTest.EncodeWithInvalidKeyRaiseError;
var
  Failed: Boolean;
  Encoded: String;
begin
  Failed := False;
  try
    Encoded := TRandomNoiseCipher.New('123456781234567812345678', 5, 0).Encode('text');
  except
    on E: ECipher do
    begin
      CheckEquals('Can not validate security string', E.Message);
      Failed := True;
    end;
  end;
  CheckTrue(Failed);
end;

procedure TRandomNoiseCipherTest.EncryptSameTextWithMultipleReturn;
const
  SOURCE_TEXT = 'test 1234 encrypt ~+*@!#$%_''¿¡?';
var
  SC, Encoded: String;
  CryptoTextRandomNoise: ICipher;
begin
  SC := TNoiseRandomKey.New.Build;
  CryptoTextRandomNoise := TRandomNoiseCipher.New(SC);
  Encoded := CryptoTextRandomNoise.Encode(SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Decode(Encoded) = SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Encode(SOURCE_TEXT) <> TRandomNoiseCipher.New(SC).Encode(SOURCE_TEXT));
end;

procedure TRandomNoiseCipherTest.MinNoiseIsGreaterThanMaxNoise;
const
  SOURCE_TEXT = 'test 1234 encrypt ~+*@!#$%_''¿¡?';
var
  SC, Encoded: String;
  CryptoTextRandomNoise: ICipher;
begin
  SC := TNoiseRandomKey.New.Build;
  CryptoTextRandomNoise := TRandomNoiseCipher.New(SC, 5, 0);
  Encoded := CryptoTextRandomNoise.Encode(SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Decode(Encoded) = SOURCE_TEXT);
  CheckTrue(CryptoTextRandomNoise.Encode(SOURCE_TEXT) <> TRandomNoiseCipher.New(SC).Encode(SOURCE_TEXT));
end;

procedure TRandomNoiseCipherTest.TryToUseSecurityKeyInvalid;
var
  CryptoTextRandomNoise: ICipher;
  ErrorFound: Boolean;
begin
  ErrorFound := False;
  try
    CryptoTextRandomNoise := TRandomNoiseCipher.New(EmptyStr);
    CryptoTextRandomNoise.Encode('Test');
  except
    on E: ECipher do
      ErrorFound := True;
  end;
  CheckTrue(ErrorFound);
end;

initialization

RegisterTest(TRandomNoiseCipherTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
