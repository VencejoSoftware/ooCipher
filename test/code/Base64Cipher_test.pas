{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit Base64Cipher_test;

interface

uses
  SysUtils, Forms,
  Base64Cipher,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TBase64CipherTest = class sealed(TTestCase)
  published
    procedure EncodedIsSomething;
    procedure DecodedIsText;
    procedure EncodeEmptyIsEmpty;
    procedure DecodeEmptyIsEmpty;
    procedure EncodedLargeIsSomething;
  end;

implementation

procedure TBase64CipherTest.DecodedIsText;
begin
  CheckEquals('Test 1234 @ Ñ', TBase64Cipher.New.Decode('VGVzdCAxMjM0IEAg0Q=='));
end;

procedure TBase64CipherTest.EncodedIsSomething;
begin
  CheckEquals('VGVzdCAxMjM0IEAg0Q==', TBase64Cipher.New.Encode('Test 1234 @ Ñ'));
end;

procedure TBase64CipherTest.EncodedLargeIsSomething;
begin
  CheckEquals('VGVzdCAxMjM0IEAg0VRlc3QgMTIzNCBAINFUZXN0IDEyMzQgQCDRVGVzdCAxMjM0IEAg0VRlc3QgMTIzNCBAINE=',
    TBase64Cipher.New.Encode('Test 1234 @ ÑTest 1234 @ ÑTest 1234 @ ÑTest 1234 @ ÑTest 1234 @ Ñ'));
end;

procedure TBase64CipherTest.DecodeEmptyIsEmpty;
begin
  CheckEquals(EmptyStr, TBase64Cipher.New.Decode(EmptyStr));
end;

procedure TBase64CipherTest.EncodeEmptyIsEmpty;
begin
  CheckEquals(EmptyStr, TBase64Cipher.New.Encode(EmptyStr));
end;

initialization

RegisterTest(TBase64CipherTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
