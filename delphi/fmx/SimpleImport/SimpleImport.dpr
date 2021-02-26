program SimpleImport;

uses
  FMX.Forms,
  USimpleImport in 'USimpleImport.pas' {FSimpleImport};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFSimpleImport, FSimpleImport);
  Application.Run;
end.
