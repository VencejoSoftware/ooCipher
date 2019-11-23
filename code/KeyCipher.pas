{$REGION 'documentation'}
{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text based in defined keys interface
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit KeyCipher;

interface

uses
  Cipher;

type
{$REGION 'documentation'}
{
  @abstract(Key Cryptographic interface)
  Define the cryptographic text based in a defined keyinterface
  @member(
    IsValidKey Checks if the key is valid
    @param(Key Key to encode/decode)
    @returns(@true if the key is valid, @false if not)
  )
  @member(
    ChangeKey Changes current secret key
    @param(Key Key to encode/decode)
  )
}
{$ENDREGION}
  IKeyCipher = interface(ICipher)
    ['{F9E23081-F0F7-4E26-B365-BFADE5F3D639}']
    function IsValidKey(const Key: WideString): Boolean;
    procedure ChangeKey(const Key: WideString);
  end;

implementation

end.
