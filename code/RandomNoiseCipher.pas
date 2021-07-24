{$REGION 'documentation'}
{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to encrypt/decrypt text with random noise algorithm
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit RandomNoiseCipher;

interface

uses
  Cipher,
  KeyCipher;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ICipher))
  Use a random noise algorithm to encrypt/decrypt text
  @member(Encode @SeeAlso(ICipher.Encode))
  @member(Decode @SeeAlso(ICipher.Decode))
  @member(ChangeKey @SeeAlso(ICipher.ChangeKey))
  @member(Codes64 Base text to use in algorithm)
  @member(
    DecodePWDEx Decode algorithm
    @param(Text Uncrypted text to encrypt)
    @param(SecurityString Key to use in crypt algorithm)
  )
  @member(
    EncodePWDEx Encode algorithm
    @param(Text Uncrypted text to encrypt)
    @param(SecurityString Key to use in crypt algorithm)
    @param(MinNoise Minimun noise algorithm parameter)
    @param(MaxNoise Maximun noise algorithm parameter)
  )
  @member(
    MakeRNDString Generate random string using any characters from "CHARS" string and length of "COUNT" -
      it will be used in encode routine to add "noise" into your encoded data.
    @param(Chars Base of characters to use when randomize)
    @param(Count Size of randomize)
  )
  @member(
    IsValidSecurityString Create a random text to create several result in algorithm
    @param(SecurityString Key to use in crypt algorithm)
  )
  @member(
    Create Object constructor
    @param(Key Key to use in crypt algorithm)
    @param(MinNoise Minimun noise algorithm parameter)
    @param(MaxNoise Maximun noise algorithm parameter)
  )
  @member(
    New Create a new @classname as interface
    @param(Key Key to use in crypt algorithm)
    @param(MinNoise Minimun noise algorithm parameter)
    @param(MaxNoise Maximun noise algorithm parameter)
  )
}
{$ENDREGION}
  TRandomNoiseCipher = class sealed(TInterfacedObject, IKeyCipher)
  strict private
  type
    TCryptoNoise = 0 .. 100;
  strict private
    _Key: WideString;
    _MinNoise, _MaxNoise: TCryptoNoise;
  public const
    CODES_64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
  private
    function DecodePWDEx(const Text, SecurityString: WideString): WideString;
    function EncodePWDEx(const Text, SecurityString: WideString; const MinNoise, MaxNoise: TCryptoNoise): WideString;
    function MakeRNDString(const Chars: WideString; const Count: Cardinal): WideString;
    function IsValidSecurityString(const SecurityString: WideString): Boolean;
  public
    function Encode(const Text: WideString): WideString;
    function Decode(const Text: WideString): WideString;
    function IsValidKey(const Key: WideString): Boolean;
    procedure ChangeKey(const Key: WideString);
    constructor Create(const Key: WideString; const MinNoise, MaxNoise: TCryptoNoise);
    class function New(const Key: WideString; const MinNoise: TCryptoNoise = 0; MaxNoise: TCryptoNoise = 5): IKeyCipher;
  end;

implementation

function TRandomNoiseCipher.Decode(const Text: WideString): WideString;
begin
  Result := DecodePWDEx(Text, _Key);
end;

function TRandomNoiseCipher.Encode(const Text: WideString): WideString;
begin
  Result := EncodePWDEx(Text, _Key, _MinNoise, _MaxNoise);
end;

function TRandomNoiseCipher.MakeRNDString(const Chars: WideString; const Count: Cardinal): WideString;
var
  i, x, LenBaseChars: Cardinal;
  BaseChars: WideString;
begin
  Result := '';
  BaseChars := Chars;
  for i := 0 to Pred(Count) do
  begin
    LenBaseChars := Length(BaseChars);
    x := LenBaseChars - Cardinal(Random(LenBaseChars));
    Result := Result + BaseChars[x];
    BaseChars := Copy(BaseChars, 1, Pred(x)) + Copy(BaseChars, Succ(x), LenBaseChars);
  end;
end;

function TRandomNoiseCipher.IsValidSecurityString(const SecurityString: WideString): Boolean;
var
  i, LenSecStr: integer;
  s1: string;
begin
  Result := False;
  LenSecStr := Length(SecurityString);
  if LenSecStr < 16 then
    raise ECipher.Create('Security string is too small');
  for i := 1 to LenSecStr do
  begin
    s1 := Copy(SecurityString, Succ(i), LenSecStr);
    Result := (Pos(SecurityString[i], s1) < 1) and (Pos(SecurityString[i], CODES_64) > 0);
    if not Result then
      raise ECipher.Create('Can not validate security string');
  end;
end;

function TRandomNoiseCipher.EncodePWDEx(const Text, SecurityString: WideString; const MinNoise, MaxNoise: TCryptoNoise)
  : WideString;
var
  i, x: integer;
  s1, s2, ss: WideString;
begin
  Result := '';
  s1 := CODES_64;
  s2 := '';
  for i := 1 to Length(SecurityString) do
  begin
    x := Pos(SecurityString[i], s1);
    if x > 0 then
      s1 := Copy(s1, 1, Pred(x)) + Copy(s1, Succ(x), Length(s1));
  end;
  ss := SecurityString;
  for i := 1 to Length(Text) do
  begin
    s2 := s2 + ss[Ord(Text[i]) mod 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1, Pred(Length(ss)));
    s2 := s2 + ss[Ord(Text[i]) div 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1, Pred(Length(ss)));
  end;
  Result := MakeRNDString(s1, Succ(Random(MaxNoise - MinNoise) + MinNoise));
  for i := 1 to Length(s2) do
    Result := Result + s2[i] + MakeRNDString(s1, Succ(Random(MaxNoise - MinNoise) + MinNoise));
end;

function TRandomNoiseCipher.DecodePWDEx(const Text, SecurityString: WideString): WideString;
var
  i, x, x2: integer;
  Data, s1, s2, ss: WideString;
begin
  Result := #1;
  Data := Text;
  s1 := CODES_64;
  s2 := '';
  ss := SecurityString;
  for i := 1 to Length(Data) do
    if Pos(Data[i], ss) > 0 then
      s2 := s2 + Data[i];
  Data := s2;
  s2 := '';
  if Length(Data) mod 2 <> 0 then
    Exit;
  for i := 0 to Length(Data) div 2 - 1 do
  begin
    x := Pred(Pos(Data[i * 2 + 1], ss));
    if x < 0 then
      Exit;
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1, Pred(Length(ss)));
    x2 := Pred(Pos(Data[i * 2 + 2], ss));
    if x2 < 0 then
      Exit;
    x := x + x2 * 16;
    s2 := s2 + chr(x);
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1, Pred(Length(ss)));
  end;
  Result := s2;
end;

function TRandomNoiseCipher.IsValidKey(const Key: WideString): Boolean;
begin
  Result := Key = _Key;
end;

procedure TRandomNoiseCipher.ChangeKey(const Key: WideString);
begin
  _Key := Key;
end;

constructor TRandomNoiseCipher.Create(const Key: WideString; const MinNoise, MaxNoise: TCryptoNoise);
begin
  if not IsValidSecurityString(Key) then
    Exit;
  if MinNoise > MaxNoise then
  begin
    _MinNoise := MaxNoise;
    _MaxNoise := MinNoise;
  end
  else
  begin
    _MinNoise := MinNoise;
    _MaxNoise := MaxNoise;
  end;
  _Key := Key;
end;

class function TRandomNoiseCipher.New(const Key: WideString; const MinNoise: TCryptoNoise = 0;
  MaxNoise: TCryptoNoise = 5): IKeyCipher;
begin
  Result := TRandomNoiseCipher.Create(Key, MinNoise, MaxNoise);
end;

end.
