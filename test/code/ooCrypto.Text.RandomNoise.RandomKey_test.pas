{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooCrypto.Text.RandomNoise.RandomKey_test;

interface

uses
  SysUtils, Forms,
  ooCrypto.Text.RandomNoise.RandomKey,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TCryptoTextRandomNoiseRandomKeyTest = class(TTestCase)
  published
    procedure IsRandomKey;
    procedure SizeIsNotZero;
    procedure SizeIs50;
  end;

implementation

procedure TCryptoTextRandomNoiseRandomKeyTest.IsRandomKey;
begin
  CheckTrue(TCryptoTextRandomNoiseRandomKey.New.Build <> TCryptoTextRandomNoiseRandomKey.New.Build);
end;

procedure TCryptoTextRandomNoiseRandomKeyTest.SizeIs50;
begin
  CheckEquals(50, Pred(Length(TCryptoTextRandomNoiseRandomKey.New(50).Build)));
end;

procedure TCryptoTextRandomNoiseRandomKeyTest.SizeIsNotZero;
begin
  CheckTrue(Length(TCryptoTextRandomNoiseRandomKey.New.Build) > 0);
end;

initialization

RegisterTest(TCryptoTextRandomNoiseRandomKeyTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
