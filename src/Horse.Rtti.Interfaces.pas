unit Horse.Rtti.Interfaces;

interface

uses
  Horse,
  System.Generics.Collections;

type
  iHorseRtti<T: Class> = interface
    ['{1729F1DA-AF5E-4162-8A76-7DE5E8D25BBB}']
    function Headers: TDictionary<integer, string>;
    function GetHeaders(Req: THorseRequest): iHorseRtti<T>; overload;
    function GetHeaders(Res: THorseResponse): iHorseRtti<T>; overload;
    function Values: TDictionary<integer, string>;
  end;

implementation

end.
