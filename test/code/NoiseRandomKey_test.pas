{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit NoiseRandomKey_test;

interface

uses
  SysUtils, Forms,
  NoiseRandomKey,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TNoiseRandomKeyTest = class sealed(TTestCase)
  published
    procedure IsRandomKey;
    procedure SizeIsNotZero;
    procedure SizeIs50;
  end;

implementation

procedure TNoiseRandomKeyTest.IsRandomKey;
begin
  CheckTrue(TNoiseRandomKey.New.Build <> TNoiseRandomKey.New.Build);
end;

procedure TNoiseRandomKeyTest.SizeIs50;
begin
  CheckEquals(50, Pred(Length(TNoiseRandomKey.New(50).Build)));
end;

procedure TNoiseRandomKeyTest.SizeIsNotZero;
begin
  CheckTrue(Length(TNoiseRandomKey.New.Build) > 0);
end;

initialization

RegisterTest(TNoiseRandomKeyTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
