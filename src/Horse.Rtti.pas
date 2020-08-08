unit Horse.Rtti;

interface

uses
  Horse,
  Horse.Rtti.Interfaces,
  Web.HTTPApp,
  System.Rtti,
  System.TypInfo,
  System.Generics.Collections;

type
  THorseRtti<T: class, constructor> = class(TInterfacedObject, iHorseRtti<T>)
  private
    FTypeRtti: TRttiType;
    FContext: TRttiContext;
    FTypeInfo: PTypeInfo;
    FWebRequest: TWebRequest;
    FWebResponse: TWebResponse;
    FHeaders: TDictionary<integer, string>;
    FValues: TDictionary<integer, string>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iHorseRtti<T>;
    function GetHeaders(Req: THorseRequest): iHorseRtti<T>; overload;
    function GetHeaders(Res: THorseResponse): iHorseRtti<T>; overload;
    function Headers: TDictionary<integer, string>;
    function Values: TDictionary<integer, string>;
  end;

implementation

{ THorseRtti<T><T> }

uses
  Horse.Headers,
  Horse.Attributes;

constructor THorseRtti<T>.Create;
begin
  FContext := TRttiContext.Create;
  FHeaders := TDictionary<integer, string>.Create;
  FValues := TDictionary<integer, string>.Create;
end;

destructor THorseRtti<T>.Destroy;
begin
  FHeaders.Free;
  FValues.Free;
  inherited;
end;

function THorseRtti<T>.GetHeaders(Res: THorseResponse): iHorseRtti<T>;
var
  lValue: String;
  FAttributes: TCustomAttribute;
  FPropertyRtti: TRttiProperty;
  lCount: integer;
  lIgnore: boolean;
begin
  lCount := 0;
  FHeaders.Clear;
  FValues.Clear;
  FWebResponse := THorseHackResponse(Res).GetWebResponse;
  FTypeInfo := TypeInfo(T);
  FTypeRtti := FContext.GetType(FTypeInfo);

  try
    FWebResponse := THorseHackResponse(Res).GetWebResponse;
    FTypeInfo := System.TypeInfo(T);
    FTypeRtti := FContext.GetType(FTypeInfo);
    for FPropertyRtti in FTypeRtti.GetProperties do
    begin
      for FAttributes in FPropertyRtti.GetAttributes do
      begin

        if (FAttributes is Header) then
        begin
          lValue := FWebResponse.GetCustomHeader(Header(FAttributes).Name);
        end;

        if (FAttributes is Ignore) then
        begin
          lIgnore := true;
        end;

      end;

      if not lIgnore then
      begin
        FHeaders.Add(lCount, Header(FAttributes).Name);
        FValues.Add(lCount, lValue);
        Inc(lCount);
      end;

    end;

  finally
    FContext.Free;
  end;

  Result := self;

end;

function THorseRtti<T>.GetHeaders(Req: THorseRequest): iHorseRtti<T>;
var
  lValue: String;
  lCount: integer;
  lIgnore: boolean;
  FPropertyRtti: TRttiProperty;
  FAttributes: TCustomAttribute;
begin
  lIgnore := false;
  lCount := 0;
  FHeaders.Clear;
  FValues.Clear;

  try
    FWebRequest := THorseHackRequest(Req).GetWebRequest;
    FTypeInfo := System.TypeInfo(T);
    FTypeRtti := FContext.GetType(FTypeInfo);
    for FPropertyRtti in FTypeRtti.GetProperties do
    begin
      for FAttributes in FPropertyRtti.GetAttributes do
      begin
        if (FAttributes is Header) then
        begin
          lValue := FWebRequest.GetFieldByName(Header(FAttributes).Name);
        end;

        if (FAttributes is Ignore) then
        begin
          lIgnore := true;
        end;
      end;

      if not lIgnore then
      begin
        FHeaders.Add(lCount, Header(FAttributes).Name);
        FValues.Add(lCount, lValue);
        Inc(lCount);
      end;

    end;

  finally
    FContext.Free;
  end;

  Result := self;

end;

function THorseRtti<T>.Headers: TDictionary<integer, string>;
begin
  Result := FHeaders;
end;

class function THorseRtti<T>.New: iHorseRtti<T>;
begin
  Result := self.Create;
end;

function THorseRtti<T>.Values: TDictionary<integer, string>;
begin
  Result := FValues;
end;

end.
