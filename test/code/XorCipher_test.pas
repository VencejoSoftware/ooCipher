{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit XorCipher_test;

interface

uses
  SysUtils, Forms,
  KeyCipher, XorCipher,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TXorCipherTest = class sealed(TTestCase)
  published
    procedure EncodedIsSomething;
    procedure DecodedIsText;
    procedure EncodeEmptyIsEmpty;
    procedure DecodeEmptyIsEmpty;
    procedure EncodedLargeIsSomething;
  end;

implementation

procedure TXorCipherTest.DecodedIsText;
begin
  CheckEquals(WideString('Test 1234 @ Ñ'), TXorCipher.New('Key22').Decode('576672752232313235224323D0'));
end;

procedure TXorCipherTest.EncodedIsSomething;
begin
  CheckEquals(WideString('576672752232313235224323D0'), TXorCipher.New('Key22').Encode('Test 1234 @ Ñ'));
end;

procedure TXorCipherTest.EncodedLargeIsSomething;
const
  RAW_TEXT = 'qwertyuiopasdfghjklñzxcvbnm,.|1234567890''¿QWERTYUIOP¨*ASDFGHJKLÑ[]ZXCVBNM;:_°!"#$%&/()=?¡<>';
  CRYPTED = '72746473767A76686E7262706567656B696A6DF3797B6277606D6E2D2F7E3231323537353439383224BC505647515758544B4C53' +
    'A92B43504747464A49484DD0595E59594254414D4C3A385CB32023212726272E2A2A3E3EA03E3D';
var
  Cipher: IKeyCipher;
begin
  Cipher := TXorCipher.New('Key22');
  CheckEquals(WideString(CRYPTED), Cipher.Encode(RAW_TEXT));
  CheckEquals(WideString(RAW_TEXT), Cipher.Decode(CRYPTED));
end;

procedure TXorCipherTest.DecodeEmptyIsEmpty;
begin
  CheckEquals(EmptyWideStr, TXorCipher.New('Key22').Decode(EmptyWideStr));
end;

procedure TXorCipherTest.EncodeEmptyIsEmpty;
begin
  CheckEquals(EmptyWideStr, TXorCipher.New('Key22').Encode(EmptyWideStr));
end;

initialization

RegisterTest(TXorCipherTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
