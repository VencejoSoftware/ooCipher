{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text for random noise crypt
  @created(08/04/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooCrypto.Text.RandomNoise.RandomKey;

interface

uses
  ooCrypto.Text.RandomNoise,
  ooCrypto.Text.RandomKey.Intf;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ICryptoTextRandomKey))
  @member(Build @SeeAlso(ICryptoTextRandomKey.Build))
  @member(
    Create Object constructor
    @param(Size Length text to generate)
  )
  @member(
    New Create a new @classname as interface
    @param(Size Length text to generate)
  )
}
{$ENDREGION}
  TCryptoTextRandomNoiseRandomKey = class sealed(TInterfacedObject, ICryptoTextRandomKey)
  strict private
    _Size: Byte;
  public
    function Build: String;
    constructor Create(Const Size: Byte);
    class function New(Const Size: Byte = 15): ICryptoTextRandomKey;
  end;

implementation

function TCryptoTextRandomNoiseRandomKey.Build: String;
var
  i, NewCharIndex, LenGenerated: integer;
  BaseText: string;
begin
  BaseText := TCryptoTextRandomNoise.Codes64;
  Result := '';
  for i := 0 to _Size do
  begin
    LenGenerated := Length(BaseText);
    NewCharIndex := Random(LenGenerated);
    NewCharIndex := LenGenerated - NewCharIndex;
    Result := Result + BaseText[NewCharIndex];
    BaseText := Copy(BaseText, 1, Pred(NewCharIndex)) + Copy(BaseText, Succ(NewCharIndex), LenGenerated);
  end;
end;

constructor TCryptoTextRandomNoiseRandomKey.Create(const Size: Byte);
begin
  _Size := Size;
end;

class function TCryptoTextRandomNoiseRandomKey.New(const Size: Byte = 15): ICryptoTextRandomKey;
begin
  Result := TCryptoTextRandomNoiseRandomKey.Create(Size);
end;

end.
