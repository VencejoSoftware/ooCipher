{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text interface
  @created(08/04/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooCrypto.Text.Intf;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
{
  Base class for cryptographic error object
}
{$ENDREGION}
  ECryptoText = class(Exception)
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

  ICryptoText = interface
    ['{E1A41D6F-8DAE-414D-AA67-CDF1FE90854F}']
    function Encode(const Text: String): string;
    function Decode(const Text: String): string;
  end;

implementation

end.
