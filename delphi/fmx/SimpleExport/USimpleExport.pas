unit USimpleExport;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TMSBaseControl,
  FMX.TMSGridCell, FMX.TMSGridOptions, FMX.TMSGridData, FMX.TMSCustomGrid,
  FMX.TMSGrid, FMX.TMSGridExcelExport,
  FMX.TMSBitmapContainer, FMX.TMSGridPDFIO,
  {$IF COMPILERVERSION >= 25}
  FMX.StdCtrls, 
  FMX.ExtCtrls,
  {$IFEND} 
  {$IF COMPILERVERSION >= 31}  //Delphi 10.1 Berlin deprecated MessageDlg
  FMX.DialogService.Sync,
  {$ENDIF}
  FMX.TMSUtils,
  FMX.FlexCel.Core, FlexCel.XlsAdapter;

type
  TFSimpleExport = class(TForm)
    TMSFMXGrid1: TTMSFMXGrid;
    ToolBar1: TToolBar;
    btnExportToExcel: TButton;
    btnExportToHTML: TButton;
    btnExportToPDF: TButton;
    ExcelExport: TTMSFMXGridExcelExport;
    SaveDialogExcel: TSaveDialog;
    SaveDialogPdf: TSaveDialog;
    SaveDialogHtml: TSaveDialog;
    TMSFMXBitmapContainer1: TTMSFMXBitmapContainer;
    btnDark: TButton;
    StyleBookDark: TStyleBook;
    StyleBookDefault: TStyleBook;
    procedure btnExportToExcelClick(Sender: TObject);
    procedure TMSFMXGrid1GetCellLayout(Sender: TObject; ACol, ARow: Integer;
      ALayout: TTMSFMXGridCellLayout; ACellState: TCellState);
    procedure FormCreate(Sender: TObject);
    procedure btnDarkClick(Sender: TObject);
    procedure btnExportToPDFClick(Sender: TObject);
    procedure btnExportToHTMLClick(Sender: TObject);
  private
    procedure InitGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSimpleExport: TFSimpleExport;

implementation

{$R *.fmx}

procedure TFSimpleExport.btnDarkClick(Sender: TObject);
begin
  if btnDark.IsPressed then
  begin
    TMSFMXGrid1.StyleLookup := 'TMSFMXGrid1Style1';
    FSimpleExport.StyleBook := StyleBookDark;
  end
  else
  begin
    TMSFMXGrid1.StyleLookup := '';
    FSimpleExport.StyleBook := StyleBookDefault;
  end;
end;

procedure TFSimpleExport.btnExportToExcelClick(Sender: TObject);
begin
  if not SaveDialogExcel.Execute then exit;

  //SetExportoptions;
  ExcelExport.ExportOptions.HardBorders := true;
  ExcelExport.Export(SaveDialogExcel.FileName, 'Result');

{$IF COMPILERVERSION >= 31}  //Delphi 10.1 Berlin deprecated MessageDlg
  if TDialogServiceSync.MessageDialog('Do you want to open the generated file?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbYes, 0) = mrYes then
  begin
    TTMSFMXUtils.OpenFile(SaveDialogExcel.FileName);
  end;
{$ELSE}
  if MessageDlg('Do you want to open the generated file?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
  begin
    TTMSFMXUtils.OpenFile(SaveDialogExcel.FileName);
  end;
{$ENDIF}
  
end;

procedure TFSimpleExport.btnExportToHTMLClick(Sender: TObject);
begin
  if not SaveDialogHtml.Execute then exit;
  ExcelExport.ExportOptions.HardBorders := true;
  ExcelExport.ExportHtml(SaveDialogHtml.FileName, THtmlExportMode.SingleSheet);

{$IF COMPILERVERSION >= 31}  //Delphi 10.1 Berlin deprecated MessageDlg
  if TDialogServiceSync.MessageDialog('Do you want to open the generated file?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbYes, 0) = mrYes then
  begin
    TTMSFMXUtils.OpenFile(SaveDialogHtml.FileName);
  end;
{$ELSE}
  if MessageDlg('Do you want to open the generated file?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
  begin
    TTMSFMXUtils.OpenFile(SaveDialogHtml.FileName);
  end;
{$ENDIF}

end;

procedure TFSimpleExport.btnExportToPDFClick(Sender: TObject);
begin
  if not SaveDialogPdf.Execute then exit;
  ExcelExport.ExportOptions.HardBorders := true;
  ExcelExport.ExportPdf(SaveDialogPdf.FileName);

{$IF COMPILERVERSION >= 31}  //Delphi 10.1 Berlin deprecated MessageDlg
  if TDialogServiceSync.MessageDialog('Do you want to open the generated file?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbYes, 0) = mrYes then
  begin
    TTMSFMXUtils.OpenFile(SaveDialogPdf.FileName);
  end;
{$ELSE}
  if MessageDlg('Do you want to open the generated file?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
  begin
    TTMSFMXUtils.OpenFile(SaveDialogPdf.FileName);
  end;
{$ENDIF}
end;

procedure TFSimpleExport.FormCreate(Sender: TObject);
begin
  InitGrid;
end;

procedure TFSimpleExport.InitGrid;
var
  PrSet: TTMSFMXGridPrintingOptions;
begin
  TMSFMXGrid1.ColumnCount := 6;
  TMSFMXGrid1.RandomFill;
  TMSFMXGrid1.AutoNumberCol(0);
  TMSFMXGrid1.Colors[2,2] := TAlphaColors.Red;
  TMSFMXGrid1.Colors[3,3] := TAlphaColors.Lime;
  TMSFMXGrid1.Colors[4,4] := TAlphaColors.Yellow;

  {$IF COMPILERVERSION >= 27}
  TMSFMXGrid1.HorzAlignments[2,3] := TTextAlign.Center;
  TMSFMXGrid1.HorzAlignments[3,4] := TTextAlign.Trailing;
  {$ELSE}
  TMSFMXGrid1.HorzAlignments[2,3] := TTextAlign.taCenter;
  TMSFMXGrid1.HorzAlignments[3,4] := TTextAlign.taTrailing;
  {$IFEND}

  TMSFMXGrid1.FontStyles[1,1] := [TFontStyle.fsBold];
  TMSFMXGrid1.FontStyles[1,2] := [TFontStyle.fsItalic];

  TMSFMXGrid1.MergeCells(1,4,2,2);

  TMSFMXGrid1.AddBitmap(1,7,'1');
  TMSFMXGrid1.AddBitmap(1,8,'2');
  TMSFMXGrid1.AddBitmap(1,9,'3');

  TMSFMXGrid1.Comments[3,1] := 'This is an important comment!';

  TMSFMXGrid1.AddCheckBox(4,2, true);
  TMSFMXGrid1.AddCheckBox(5,2, false);

  TMSFMXGrid1.AddNode(2, 3);

  TMSFMXGrid1.Cells[1, 3] := 'Html: <br /><b>Bold</b> and <i>Italic</i>';
  TMSFMXGrid1.RowHeights[3] := 50;
  TMSFMXGrid1.ColumnWidths[1] := 100;

  PrSet := TMSFMXGrid1.Options.Printing;
  PrSet.TitlePosition := TTMSFMXGridPrintPosition.ppTopLeft;
  PrSet.Title := 'TMS FMX Grid & Exporting';
  PrSet.TitleFont.Family := 'Times New Roman';
  PrSet.TitleColor := TAlphaColors.Navy;

  PrSet.DescriptionPosition := TTMSFMXGridPrintPosition.ppBottomCenter;
  PrSet.Description := 'This demo shows how to export a grid using FMX Grid Excel Bridge';
  PrSet.DescriptionFont.Family := 'Tahoma';
  PrSet.DescriptionColor := TAlphaColors.Chocolate;

  PrSet.PageNumberPosition := TTMSFMXGridPrintPosition.ppTopRight;
  PrSet.PageNumberFont.Family := 'Times New Roman';
  PrSet.PageNumberFont.Size := 14;
  PrSet.PageNumberFont.Style := [TFontStyle.fsBold];
  PrSet.PageNumberColor := TAlphaColors.MoneyGreen;

end;


procedure TFSimpleExport.TMSFMXGrid1GetCellLayout(Sender: TObject; ACol,
  ARow: Integer; ALayout: TTMSFMXGridCellLayout; ACellState: TCellState);
begin
  if (ACol = 5) then
  begin
    ALayout.FontFill.Color := TAlphaColors.Red;
  {$IF COMPILERVERSION >= 27}
    ALayout.TextAlign := TTextAlign.Trailing;
  {$ELSE}
    ALayout.TextAlign := TTextAlign.taTrailing;
  {$IFEND}
  end;
end;

end.
