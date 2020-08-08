unit Horse.Attributes;
{$M+}

interface

uses
  System.RTTI,
  System.Variants,
  System.Classes;

type
  Header = class(TCustomAttribute)
  private
    FName: String;
  public
    constructor Create(aName: string);
    property Name: String read FName;
  end;

  Ignore = class(TCustomAttribute)

  end;

implementation

{ Header }

constructor Header.Create(aName: string);
begin
  FName := aName;
end;

end.
