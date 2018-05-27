{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to encrypt/decrypt text in base 64
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooCrypto.Text.Base64;

interface

uses
  ooCrypto.Text.Intf;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ICryptoText))
  Encode and decodete text using base 64 algorithm
  @member(Encode @SeeAlso(ICryptoText.Encode))
  @member(Decode @SeeAlso(ICryptoText.Decode))
  @member(
    ENCODE_TABLE Array characters text to use in algorithm
  )
  @member(
    FindInTable Find a position of char in the ENCODE_TABLE
    @param(Letter Char to find)
  )
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}
  TCryptoTextBase64 = class sealed(TInterfacedObject, ICryptoText)
  strict private
  const
    ENCODE_TABLE: array [1 .. 65] of AnsiChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
  private
    function FindInTable(const Letter: AnsiChar): Byte;
  public
    function Encode(const Text: string): string;
    function Decode(const Text: string): string;
    class function New: ICryptoText;
  end;

implementation

function TCryptoTextBase64.FindInTable(const Letter: AnsiChar): Byte;
begin
  Result := Pred(Pos(Letter, ENCODE_TABLE));
end;

function TCryptoTextBase64.Decode(const Text: string): string;
var
  SrcLen, Times, i: integer;
  x1, x2, x3, x4, xt: Byte;
  Encoded, Decoded: AnsiString;
begin
  Decoded := '';
  Encoded := AnsiString(Text);
  SrcLen := Length(Text);
  Times := SrcLen div 4;
  for i := 0 to Pred(Times) do
  begin
    x1 := FindInTable(Encoded[1 + i * 4]);
    x2 := FindInTable(Encoded[2 + i * 4]);
    x3 := FindInTable(Encoded[3 + i * 4]);
    x4 := FindInTable(Encoded[4 + i * 4]);
    x1 := Byte(x1 shl 2);
    xt := Byte(x2 shr 4);
    x1 := x1 or xt;
    x2 := Byte(x2 shl 4);
    Decoded := Decoded + AnsiChar(x1);
    if x3 = 64 then
      break;
    xt := Byte(x3 shr 2);
    x2 := x2 or xt;
    x3 := Byte(x3 shl 6);
    Decoded := Decoded + AnsiChar(x2);
    if x4 = 64 then
      break;
    x3 := x3 or x4;
    Decoded := Decoded + AnsiChar(x3);
  end;
  Result := String(Decoded);
end;

function TCryptoTextBase64.Encode(const Text: string): string;
var
  Times, LenSrc, i: integer;
  x1, x2, x3, x4: AnsiChar;
  xt: Byte;
  Encoded, Decoded: AnsiString;
begin
  Encoded := '';
  Decoded := AnsiString(Text);
  LenSrc := Length(Decoded);
  if LenSrc mod 3 = 0 then
    Times := LenSrc div 3
  else
    Times := Succ(LenSrc div 3);
  for i := 0 to Pred(Times) do
  begin
    if LenSrc >= (3 + i * 3) then
    begin
      x1 := ENCODE_TABLE[(ord(Decoded[1 + i * 3]) shr 2) + 1];
      xt := Byte(ord(Decoded[1 + i * 3]) shl 4) and 48;
      xt := xt or (ord(Decoded[2 + i * 3]) shr 4);
      x2 := ENCODE_TABLE[xt + 1];
      xt := Byte(ord(Decoded[2 + i * 3]) shl 2) and 60;
      xt := xt or (ord(Decoded[3 + i * 3]) shr 6);
      x3 := ENCODE_TABLE[xt + 1];
      xt := (ord(Decoded[3 + i * 3]) and 63);
      x4 := ENCODE_TABLE[xt + 1];
    end
    else
      if LenSrc >= (2 + i * 3) then
      begin
        x1 := ENCODE_TABLE[(ord(Decoded[1 + i * 3]) shr 2) + 1];
        xt := Byte(ord(Decoded[1 + i * 3]) shl 4) and 48;
        xt := xt or (ord(Decoded[2 + i * 3]) shr 4);
        x2 := ENCODE_TABLE[xt + 1];
        xt := Byte(ord(Decoded[2 + i * 3]) shl 2) and 60;
        x3 := ENCODE_TABLE[xt + 1];
        x4 := '=';
      end
      else
      begin
        x1 := ENCODE_TABLE[(ord(Decoded[1 + i * 3]) shr 2) + 1];
        xt := Byte(ord(Decoded[1 + i * 3]) shl 4) and 48;
        x2 := ENCODE_TABLE[xt + 1];
        x3 := '=';
        x4 := '=';
      end;
    Encoded := Encoded + x1 + x2 + x3 + x4;
  end;
  Result := String(Encoded);
end;

class function TCryptoTextBase64.New: ICryptoText;
begin
  Result := TCryptoTextBase64.Create;
end;

end.
