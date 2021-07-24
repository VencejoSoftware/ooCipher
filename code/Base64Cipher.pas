{$REGION 'documentation'}
{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to encrypt/decrypt text in base 64
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit Base64Cipher;

interface

uses
  SysUtils,
  Cipher;

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
    New Create a new @classname as interface
  )
}
{$ENDREGION}
  TBase64Cipher = class sealed(TInterfacedObject, ICipher)
  strict private
  const
    ENCODING_TABLE: array [0 .. 63] of Char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  public
    function Encode(const Text: WideString): WideString;
    function Decode(const Text: WideString): WideString;
    class function New: ICipher;
  end;

implementation

function TBase64Cipher.Decode(const Text: WideString): WideString;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(Text) do
  begin
    x := Pos(Text[i], ENCODING_TABLE) - 1;
    if x >= 0 then
    begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result + chr(x);
      end;
    end
    else
      Exit;
  end;
end;

function TBase64Cipher.Encode(const Text: WideString): WideString;
  function Encode3Bytes(const Byte1, Byte2, Byte3: Byte): string;
  begin
    Result := ENCODING_TABLE[Byte1 shr 2] + ENCODING_TABLE[((Byte1 shl 4) or (Byte2 shr 4)) and $3F] +
      ENCODING_TABLE[((Byte2 shl 2) or (Byte3 shr 6)) and $3F] + ENCODING_TABLE[Byte3 and $3F];
  end;

  function EncodeLast2Bytes(const Byte1, Byte2: Byte): string;
  begin
    Result := ENCODING_TABLE[Byte1 shr 2] + ENCODING_TABLE[((Byte1 shl 4) or (Byte2 shr 4)) and $3F] +
      ENCODING_TABLE[(Byte2 shl 2) and $3F] + '=';
  end;

  function EncodeLast1Byte(const Byte1: Byte): string;
  begin
    Result := ENCODING_TABLE[Byte1 shr 2] + ENCODING_TABLE[(Byte1 shl 4) and $3F] + '==';
  end;

var
  i, iLength: Cardinal;
  Input: TBytes;
begin
  Result := '';
  Input := BytesOf(Text);
  iLength := Length(Input);
  i := 0;
  while i < iLength do
  begin
    case iLength - i of
      3 .. MaxInt:
        Result := Result + Encode3Bytes(Input[i], Input[i + 1], Input[i + 2]);
      2:
        Result := Result + EncodeLast2Bytes(Input[i], Input[Succ(i)]);
      1:
        Result := Result + EncodeLast1Byte(Input[i]);
    end;
    Inc(i, 3);
  end;
end;

class function TBase64Cipher.New: ICipher;
begin
  Result := TBase64Cipher.Create;
end;

end.
