# readers-headers
 Package for reader to headers with Horse
Reading the headers with RTTI Delphi's.

<pre><code language:Delphi>
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LRtti: iHorseRtti < THorseHeaderRequest > ;
  I: Integer;
  lKey: String;
  lValue: String;
begin 
  LRtti := THorseRtti< THorseHeaderRequest >.New.GetHeaders(Req);
  for I := 0 to pred(LRtti.Headers.Count) do
  begin
    lKey := LRtti.Headers.Items[I];
    lValue := LRtti.Values.Items[I];
  end;
end;
</code></pre>
