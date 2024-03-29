{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  Cipher, RandomNoiseCipher, NoiseRandomKey;

type
  TMainForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  NewMainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
var
  SC, Encoded, Decoded: String;
  CryptoTextRandomNoise: ICipher;
begin
  SC := TNoiseRandomKey.New.Build;
  CryptoTextRandomNoise := TRandomNoiseCipher.New(SC);
  Encoded := CryptoTextRandomNoise.Encode(Edit1.Text);
  Memo1.Lines.Add(Encoded);
  Decoded := CryptoTextRandomNoise.Decode(Encoded);
  Memo1.Lines.Add(Decoded);
  Caption := BoolToStr(Decoded = Edit1.Text, True);
end;

procedure TMainForm.Button2Click(Sender: TObject);
const
  MAX_ITEMS = 10000;
var
  SC, Normal, Encoded, Decoded: String;
  CryptoTextRandomNoise: ICipher;
  i: Integer;
begin
  SC := TNoiseRandomKey.New.Build;
  Memo1.Clear;
  Memo1.Lines.BeginUpdate;
  try
    for i := 0 to MAX_ITEMS do
    begin
      Normal := TNoiseRandomKey.New.Build;
      CryptoTextRandomNoise := TRandomNoiseCipher.New(SC);
      Encoded := CryptoTextRandomNoise.Encode(Normal);
      Memo1.Lines.Add(Encoded);
      Decoded := CryptoTextRandomNoise.Decode(Encoded);
      Memo1.Lines.Add(Decoded);
      Caption := Format('Encoded %d of %d', [i, MAX_ITEMS]);
      if not (Decoded = Normal) then
        Break;
    end;
  finally
    Memo1.Lines.EndUpdate;
  end;
end;

end.
