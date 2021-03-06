unit Horse.Headers;

interface

uses
 Horse.Attributes;

type

  THorseHeaderRequest = class
  private
    FeTag: String;
    procedure SeteTag(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    [Header('If-None-Match')]
    property eTag: String read FeTag write SeteTag;
  end;

implementation

{ THorseHeaderRequest }

constructor THorseHeaderRequest.Create;
begin

end;

destructor THorseHeaderRequest.Destroy;
begin

  inherited;
end;

procedure THorseHeaderRequest.SeteTag(const Value: String);
begin
  FeTag := Value;
end;

end.
