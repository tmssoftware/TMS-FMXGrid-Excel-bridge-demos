unit USimpleImport;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TMSGridExcelImport,
  FMX.TMSBaseControl, FMX.TMSGridCell, FMX.TMSGridOptions, FMX.TMSGridData,
  {$IF COMPILERVERSION >= 25}
  FMX.StdCtrls, FMX.ExtCtrls,
  {$IFEND}  
 FMX.TMSCustomGrid, FMX.TMSGrid;

type
  TFSimpleImport = class(TForm)
    Panel1: TPanel;
    TMSFMXGrid: TTMSFMXGrid;
    TMSFMXGridExcelImport: TTMSFMXGridExcelImport;
    btnImport: TButton;
    OpenDialog: TOpenDialog;
    cbFormulas: TCheckBox;
    cbImages: TCheckBox;
    cbComments: TCheckBox;
    cbFormatting: TCheckBox;
    cbCellSizes: TCheckBox;
    cbReadOnlyToLocked: TCheckBox;
    cbHTML: TCheckBox;
    cbPrintOptions: TCheckBox;
    procedure btnImportClick(Sender: TObject);
  private
    procedure SetImportOptions;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSimpleImport: TFSimpleImport;

implementation

{$R *.fmx}

procedure TFSimpleImport.btnImportClick(Sender: TObject);
begin
  if not OpenDialog.Execute then exit;

  SetImportOptions;
  TMSFMXGridExcelImport.Import(OpenDialog.FileName);

end;

procedure TFSimpleImport.SetImportOptions;
begin
  TMSFMXGridExcelImport.ImportOptions.Formulas := cbFormulas.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.Images := cbImages.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.Comments := cbComments.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.CellFormatting := cbFormatting.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.CellSizes := cbCellSizes.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.LockedCellsAsReadonly := cbReadOnlyToLocked.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.Html := cbHtml.IsChecked;
  TMSFMXGridExcelImport.ImportOptions.PrintOptions := cbPrintOptions.IsChecked;
end;

end.
