program SimpleExport;

uses
  FMX.Forms,
  USimpleExport in 'USimpleExport.pas' {FSimpleExport};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFSimpleExport, FSimpleExport);
  Application.Run;
end.
