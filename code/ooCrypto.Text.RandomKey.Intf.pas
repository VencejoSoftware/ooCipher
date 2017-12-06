{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Cryptographic text random builder
  @created(08/04/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooCrypto.Text.RandomKey.Intf;

interface

type
{$REGION 'documentation'}
{
  @abstract(Cryptographic text random builder)
  Build text with random chars to use as crypto key
  @member(
    Build Create random string
    @returns(Random string)
  )
}
{$ENDREGION}
  ICryptoTextRandomKey = interface
    ['{E1A41D6F-8DAE-414D-AA67-CDF1FE90854F}']
    function Build: String;
  end;

implementation

end.
