{$REGION 'documentation'}
{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text for XOR crypt
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit XorCipher;

interface

uses
  SysUtils, Classes,
  KeyCipher;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ICipher))
  Simple XOR encrypt/decrypt text
  @member(Encode @SeeAlso(ICipher.Encode))
  @member(Decode @SeeAlso(ICipher.Decode))
  @member(ChangeKey @SeeAlso(ICipher.ChangeKey))
  @member(
    Hex2String Converts hexadecimal string to string
    @param(Text Hexadecimal text)
    @return(Text)
  )
  @member(
    String2Hex Converts string chars into hexadecimal (2 digits format)
    @param(Text Text to convert)
    @return(Hexadecimal text)
  )
  @member(
    Create Object constructor
    @param(Key Key to use in crypt algorithm)
  )
  @member(
    New Create a new @classname as interface
    @param(Key Key to use in crypt algorithm)
  )
}
{$ENDREGION}
  TXorCipher = class sealed(TInterfacedObject, IKeyCipher)
  strict private
    _Key: WideString;
  private
    function Hex2String(const Text: WideString): WideString;
    function String2Hex(const Text: WideString): WideString;
    function XorText(const Text: WideString): WideString;
  public
    function Encode(const Text: WideString): WideString;
    function Decode(const Text: WideString): WideString;
    function IsValidKey(const Key: WideString): Boolean;
    procedure ChangeKey(const Key: WideString);
    constructor Create(const Key: WideString);
    class function New(const Key: WideString): IKeyCipher;
  end;

implementation

function TXorCipher.String2Hex(const Text: WideString): WideString;
var
  Buffer, Return: AnsiString;
begin
  Buffer := AnsiString(Text);
  SetLength(Return, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PAnsiChar(Return), Length(Buffer));
  Result := WideString(Return);
end;

function TXorCipher.Hex2String(const Text: WideString): WideString;
var
  Buffer, Return: AnsiString;
begin
  Buffer := AnsiString(Text);
  SetLength(Return, Length(Buffer) div 2);
  HexToBin(PAnsiChar(Buffer), PAnsiChar(Return), Length(Return));
  Result := WideString(Return);
end;

function TXorCipher.XorText(const Text: WideString): WideString;
var
  Letter: WideChar;
  c, b, y: Word;
begin
  Result := EmptyWideStr;
  y := 1;
  for Letter in Text do
  begin
    if y = Length(_Key) then
      y := 1
    else
      Inc(y);
    c := Ord(Letter);
    b := Ord(_Key[y]) + y;
    Result := Result + WideChar(c xor b shr 5);
  end;
end;

function TXorCipher.Encode(const Text: WideString): WideString;
begin
  Result := String2Hex(XorText(Text));
end;

function TXorCipher.Decode(const Text: WideString): WideString;
begin
  Result := XorText(Hex2String(Text));
end;

procedure TXorCipher.ChangeKey(const Key: WideString);
begin
  _Key := Key;
end;

function TXorCipher.IsValidKey(const Key: WideString): Boolean;
begin
  Result := _Key = Key;
end;

constructor TXorCipher.Create(const Key: WideString);
begin
  _Key := Key;
end;

class function TXorCipher.New(const Key: WideString): IKeyCipher;
begin
  Result := TXorCipher.Create(Key);
end;

end.
