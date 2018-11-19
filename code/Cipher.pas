{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text interface
  @created(19/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit Cipher;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
{
  Base class for cryptographic error object
}
{$ENDREGION}
  ECipher = class(Exception)
  end;
{$REGION 'documentation'}
{
  @abstract(Cryptographic interface)
  Define the cryptographic text interface
  @member(
    Encode Encode text unencoded
    @param(Text to encode)
    @returns(String encoded)
  )
  @member(
    Decode Decode text encoded
    @param(Text to decode)
    @returns(String decoded)
  )
}
{$ENDREGION}

  ICipher = interface
    ['{E1A41D6F-8DAE-414D-AA67-CDF1FE90854F}']
    function Encode(const Text: String): string;
    function Decode(const Text: String): string;
  end;

implementation

end.
