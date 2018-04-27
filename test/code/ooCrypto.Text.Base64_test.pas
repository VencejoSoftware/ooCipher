{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooCrypto.Text.Base64_test;

interface

uses
  SysUtils, Forms,
  ooCrypto.Text.Base64,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TCryptoTextBase64Test = class(TTestCase)
  published
    procedure EncodedIsSomething;
    procedure DecodedIsText;
    procedure EncodeEmptyIsEmpty;
    procedure DecodeEmptyIsEmpty;
  end;

implementation

procedure TCryptoTextBase64Test.DecodedIsText;
begin
  CheckEquals('Test 1234 @ Ñ', TCryptoTextBase64.New.Decode('VGVzdCAxMjM0IEAg0Q=='));
end;

procedure TCryptoTextBase64Test.EncodedIsSomething;
begin
  CheckEquals('VGVzdCAxMjM0IEAg0Q==', TCryptoTextBase64.New.Encode('Test 1234 @ Ñ'));
end;

procedure TCryptoTextBase64Test.DecodeEmptyIsEmpty;
begin
  CheckEquals(EmptyStr, TCryptoTextBase64.New.Decode(EmptyStr));
end;

procedure TCryptoTextBase64Test.EncodeEmptyIsEmpty;
begin
  CheckEquals(EmptyStr, TCryptoTextBase64.New.Encode(EmptyStr));
end;

initialization

RegisterTest(TCryptoTextBase64Test {$IFNDEF FPC}.Suite {$ENDIF});

end.
