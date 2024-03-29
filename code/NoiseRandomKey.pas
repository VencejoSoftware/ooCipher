{$REGION 'documentation'}
{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text for random noise crypt
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit NoiseRandomKey;

interface

uses
  RandomNoiseCipher,
  RandomKey;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ICipherRandomKey))
  @member(Build @SeeAlso(ICipherRandomKey.Build))
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
  TNoiseRandomKey = class sealed(TInterfacedObject, IRandomKey)
  strict private
    _Size: Byte;
  public
    function Build: WideString;
    constructor Create(Const Size: Byte);
    class function New(Const Size: Byte = 15): IRandomKey;
  end;

implementation

function TNoiseRandomKey.Build: WideString;
var
  i, NewCharIndex, LenGenerated: integer;
  BaseText: WideString;
begin
  BaseText := TRandomNoiseCipher.CODES_64;
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

constructor TNoiseRandomKey.Create(const Size: Byte);
begin
  _Size := Size;
end;

class function TNoiseRandomKey.New(const Size: Byte = 15): IRandomKey;
begin
  Result := TNoiseRandomKey.Create(Size);
end;

end.
