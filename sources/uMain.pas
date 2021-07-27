unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFMod,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    procedure PatchFile(Path: String; FileN: String; FileS: Integer;
      PatchT: Integer);
    procedure FormCreate(Sender: TObject);
    procedure tmrAboutTimer(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnPatchClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TEntry = record
    Offset: DWord;
    Value: Byte;
  end;

const
  PathFile = 'C:\EAGLE 8.0.1';
  FileName1 = 'eagle.exe';
  SizeOfFile1 = 8733696;
  FileName2 = 'eaglecon.exe';
  SizeOfFile2 = 8733184;
  FileName3 = 'main.js';
  SizeOfFile3 = 0;

  PatchCount = 9;
  PatchInfo: array [1 .. PatchCount] of TEntry = ((Offset: $002106FD;
    Value: $90), (Offset: $002106FE; Value: $90), (Offset: $002106FF;
    Value: $90), (Offset: $00210700; Value: $90), (Offset: $00210701;
    Value: $90), (Offset: $00210709; Value: $30), (Offset: $00210824;
    Value: $B0), (Offset: $00210825; Value: $01), (Offset: $0024EB53;
    Value: $00));

  MainJS: array [0 .. 1831] of Byte = ($76, $61, $72, $20, $76, $65, $72, $73,
    $69, $6F, $6E, $20, $3D, $20, $22, $37, $2E, $37, $2E, $30, $22, $3B, $0D,
    $0A, $0D, $0A, $2F, $2F, $20, $49, $4E, $54, $45, $52, $46, $41, $43, $45,
    $0D, $0A, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $73, $65, $74, $4C,
    $69, $63, $65, $6E, $73, $65, $4E, $61, $6D, $65, $28, $29, $7B, $0D, $0A,
    $20, $20, $20, $20, $5F, $68, $74, $6D, $6C, $28, $27, $6A, $73, $2D, $6C,
    $69, $63, $65, $6E, $73, $65, $5F, $5F, $6E, $61, $6D, $65, $27, $2C, $20,
    $22, $50, $68, $61, $74, $20, $56, $75, $22, $29, $3B, $0D, $0A, $7D, $0D,
    $0A, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $73, $65, $74, $4C, $69,
    $63, $65, $6E, $73, $65, $54, $79, $70, $65, $28, $29, $7B, $0D, $0A, $20,
    $20, $20, $20, $5F, $68, $74, $6D, $6C, $28, $27, $6A, $73, $2D, $6C, $69,
    $63, $65, $6E, $73, $65, $5F, $5F, $74, $79, $70, $65, $27, $2C, $20, $22,
    $45, $41, $47, $4C, $45, $20, $50, $72, $65, $6D, $69, $75, $6D, $20, $4C,
    $69, $63, $65, $6E, $73, $65, $20, $66, $6F, $72, $20, $63, $6F, $6D, $6D,
    $65, $72, $63, $69, $61, $6C, $20, $75, $73, $65, $22, $29, $3B, $0D, $0A,
    $20, $20, $20, $20, $5F, $68, $74, $6D, $6C, $28, $27, $6A, $73, $2D, $6C,
    $69, $63, $65, $6E, $73, $65, $5F, $5F, $75, $70, $67, $72, $61, $64, $65,
    $27, $2C, $20, $22, $22, $29, $3B, $0D, $0A, $7D, $0D, $0A, $66, $75, $6E,
    $63, $74, $69, $6F, $6E, $20, $73, $65, $74, $56, $65, $72, $73, $69, $6F,
    $6E, $28, $76, $65, $72, $73, $69, $6F, $6E, $4E, $75, $6D, $62, $65, $72,
    $29, $7B, $0D, $0A, $20, $20, $20, $20, $76, $65, $72, $73, $69, $6F, $6E,
    $20, $3D, $20, $76, $65, $72, $73, $69, $6F, $6E, $4E, $75, $6D, $62, $65,
    $72, $3B, $0D, $0A, $20, $20, $20, $20, $5F, $68, $74, $6D, $6C, $28, $27,
    $6A, $73, $2D, $6C, $6F, $67, $6F, $5F, $5F, $76, $65, $72, $73, $69, $6F,
    $6E, $27, $2C, $20, $76, $65, $72, $73, $69, $6F, $6E, $4E, $75, $6D, $62,
    $65, $72, $29, $3B, $0D, $0A, $7D, $0D, $0A, $66, $75, $6E, $63, $74, $69,
    $6F, $6E, $20, $63, $6F, $6D, $70, $61, $72, $65, $52, $65, $6D, $6F, $74,
    $65, $41, $6E, $64, $4C, $6F, $63, $61, $6C, $56, $65, $72, $73, $69, $6F,
    $6E, $73, $28, $72, $65, $6D, $6F, $74, $65, $53, $74, $72, $69, $6E, $67,
    $2C, $20, $6C, $6F, $63, $61, $6C, $53, $74, $72, $69, $6E, $67, $29, $7B,
    $0D, $0A, $20, $20, $20, $20, $76, $61, $72, $20, $72, $65, $6D, $6F, $74,
    $65, $56, $65, $72, $73, $69, $6F, $6E, $20, $3D, $20, $72, $65, $6D, $6F,
    $74, $65, $53, $74, $72, $69, $6E, $67, $2E, $73, $70, $6C, $69, $74, $28,
    $22, $2E, $22, $29, $3B, $0D, $0A, $20, $20, $20, $20, $76, $61, $72, $20,
    $6F, $75, $72, $56, $65, $72, $73, $69, $6F, $6E, $20, $3D, $20, $6C, $6F,
    $63, $61, $6C, $53, $74, $72, $69, $6E, $67, $2E, $73, $70, $6C, $69, $74,
    $28, $22, $2E, $22, $29, $3B, $0D, $0A, $20, $20, $20, $20, $66, $6F, $72,
    $28, $76, $61, $72, $20, $69, $3D, $30, $3B, $20, $69, $3C, $6F, $75, $72,
    $56, $65, $72, $73, $69, $6F, $6E, $2E, $6C, $65, $6E, $67, $74, $68, $3B,
    $20, $69, $2B, $2B, $29, $7B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
    $20, $76, $61, $72, $20, $72, $20, $3D, $20, $70, $61, $72, $73, $65, $49,
    $6E, $74, $28, $72, $65, $6D, $6F, $74, $65, $56, $65, $72, $73, $69, $6F,
    $6E, $5B, $69, $5D, $29, $3B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
    $20, $76, $61, $72, $20, $6F, $20, $3D, $20, $70, $61, $72, $73, $65, $49,
    $6E, $74, $28, $6F, $75, $72, $56, $65, $72, $73, $69, $6F, $6E, $5B, $69,
    $5D, $29, $3B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $69, $66,
    $28, $6F, $20, $3E, $20, $72, $29, $7B, $0D, $0A, $20, $20, $20, $20, $20,
    $20, $20, $20, $20, $20, $20, $20, $72, $65, $74, $75, $72, $6E, $20, $66,
    $61, $6C, $73, $65, $3B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20,
    $7D, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $69, $66, $28, $72,
    $20, $3E, $20, $6F, $29, $7B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
    $20, $20, $20, $20, $20, $72, $65, $74, $75, $72, $6E, $20, $74, $72, $75,
    $65, $3B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $7D, $0D, $0A,
    $20, $20, $20, $20, $7D, $0D, $0A, $0D, $0A, $20, $20, $20, $20, $72, $65,
    $74, $75, $72, $6E, $20, $66, $61, $6C, $73, $65, $3B, $0D, $0A, $7D, $0D,
    $0A, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $63, $68, $65, $63, $6B,
    $46, $6F, $72, $55, $70, $64, $61, $74, $65, $28, $29, $7B, $0D, $0A, $7D,
    $0D, $0A, $0D, $0A, $2F, $2F, $20, $53, $45, $54, $20, $43, $4F, $50, $59,
    $52, $49, $47, $48, $54, $20, $59, $45, $41, $52, $0D, $0A, $5F, $68, $74,
    $6D, $6C, $28, $27, $6A, $73, $2D, $6C, $6F, $67, $6F, $5F, $5F, $63, $6F,
    $70, $79, $5F, $5F, $79, $65, $61, $72, $27, $2C, $20, $6D, $6F, $6D, $65,
    $6E, $74, $28, $29, $2E, $66, $6F, $72, $6D, $61, $74, $28, $27, $59, $59,
    $59, $59, $27, $29, $29, $3B, $0D, $0A, $6E, $65, $77, $20, $51, $57, $65,
    $62, $43, $68, $61, $6E, $6E, $65, $6C, $28, $71, $74, $2E, $77, $65, $62,
    $43, $68, $61, $6E, $6E, $65, $6C, $54, $72, $61, $6E, $73, $70, $6F, $72,
    $74, $2C, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $28, $63, $68,
    $61, $6E, $6E, $65, $6C, $29, $20, $7B, $0D, $0A, $20, $20, $20, $20, $76,
    $61, $72, $20, $63, $70, $41, $50, $49, $20, $3D, $20, $63, $68, $61, $6E,
    $6E, $65, $6C, $2E, $6F, $62, $6A, $65, $63, $74, $73, $2E, $63, $6F, $6E,
    $74, $72, $6F, $6C, $50, $61, $6E, $65, $6C, $41, $50, $49, $49, $6E, $74,
    $65, $72, $66, $61, $63, $65, $3B, $0D, $0A, $20, $20, $20, $20, $63, $70,
    $41, $50, $49, $2E, $67, $65, $74, $46, $75, $6C, $6C, $4E, $61, $6D, $65,
    $28, $73, $65, $74, $4C, $69, $63, $65, $6E, $73, $65, $4E, $61, $6D, $65,
    $29, $3B, $0D, $0A, $20, $20, $20, $20, $63, $70, $41, $50, $49, $2E, $67,
    $65, $74, $45, $64, $69, $74, $69, $6F, $6E, $28, $73, $65, $74, $4C, $69,
    $63, $65, $6E, $73, $65, $54, $79, $70, $65, $29, $3B, $0D, $0A, $20, $20,
    $20, $20, $63, $70, $41, $50, $49, $2E, $67, $65, $74, $56, $65, $72, $73,
    $69, $6F, $6E, $28, $73, $65, $74, $56, $65, $72, $73, $69, $6F, $6E, $29,
    $3B, $0D, $0A, $20, $20, $20, $20, $77, $69, $6E, $64, $6F, $77, $2E, $6F,
    $6E, $63, $6C, $69, $63, $6B, $20, $3D, $20, $66, $75, $6E, $63, $74, $69,
    $6F, $6E, $28, $65, $29, $7B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
    $20, $69, $66, $28, $65, $2E, $74, $61, $72, $67, $65, $74, $2E, $6C, $6F,
    $63, $61, $6C, $4E, $61, $6D, $65, $20, $3D, $3D, $20, $27, $61, $27, $29,
    $7B, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20,
    $63, $70, $41, $50, $49, $2E, $6F, $70, $65, $6E, $45, $78, $74, $65, $72,
    $6E, $61, $6C, $57, $65, $62, $50, $61, $67, $65, $28, $65, $2E, $74, $61,
    $72, $67, $65, $74, $2E, $68, $72, $65, $66, $29, $3B, $0D, $0A, $20, $20,
    $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $65, $2E, $70, $72, $65,
    $76, $65, $6E, $74, $44, $65, $66, $61, $75, $6C, $74, $28, $29, $3B, $0D,
    $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $72, $65,
    $74, $75, $72, $6E, $20, $66, $61, $6C, $73, $65, $3B, $0D, $0A, $20, $20,
    $20, $20, $20, $20, $20, $20, $7D, $0D, $0A, $20, $20, $20, $20, $7D, $0D,
    $0A, $7D, $29, $3B, $0D, $0A, $0D, $0A, $2F, $2F, $20, $44, $4F, $4D, $20,
    $48, $45, $4C, $50, $45, $52, $0D, $0A, $66, $75, $6E, $63, $74, $69, $6F,
    $6E, $20, $5F, $68, $74, $6D, $6C, $28, $6B, $6C, $61, $73, $73, $2C, $20,
    $74, $78, $74, $29, $7B, $0D, $0A, $20, $20, $20, $20, $64, $6F, $63, $75,
    $6D, $65, $6E, $74, $2E, $67, $65, $74, $45, $6C, $65, $6D, $65, $6E, $74,
    $73, $42, $79, $43, $6C, $61, $73, $73, $4E, $61, $6D, $65, $28, $6B, $6C,
    $61, $73, $73, $29, $5B, $30, $5D, $2E, $69, $6E, $6E, $65, $72, $48, $54,
    $4D, $4C, $20, $3D, $20, $74, $78, $74, $3B, $0D, $0A, $7D, $0D, $0A, $66,
    $75, $6E, $63, $74, $69, $6F, $6E, $20, $5F, $61, $64, $64, $43, $6C, $61,
    $73, $73, $28, $74, $61, $72, $67, $65, $74, $2C, $20, $6B, $6C, $61, $73,
    $73, $29, $7B, $0D, $0A, $20, $20, $20, $20, $64, $6F, $63, $75, $6D, $65,
    $6E, $74, $2E, $67, $65, $74, $45, $6C, $65, $6D, $65, $6E, $74, $73, $42,
    $79, $43, $6C, $61, $73, $73, $4E, $61, $6D, $65, $28, $74, $61, $72, $67,
    $65, $74, $29, $5B, $30, $5D, $2E, $63, $6C, $61, $73, $73, $4C, $69, $73,
    $74, $2E, $61, $64, $64, $28, $6B, $6C, $61, $73, $73, $29, $3B, $0D, $0A,
    $7D, $0D, $0A, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $5F, $72, $65,
    $6D, $6F, $76, $65, $43, $6C, $61, $73, $73, $28, $74, $61, $72, $67, $65,
    $74, $2C, $20, $6B, $6C, $61, $73, $73, $29, $7B, $0D, $0A, $20, $20, $20,
    $20, $64, $6F, $63, $75, $6D, $65, $6E, $74, $2E, $67, $65, $74, $45, $6C,
    $65, $6D, $65, $6E, $74, $73, $42, $79, $43, $6C, $61, $73, $73, $4E, $61,
    $6D, $65, $28, $74, $61, $72, $67, $65, $74, $29, $5B, $30, $5D, $2E, $63,
    $6C, $61, $73, $73, $4C, $69, $73, $74, $2E, $72, $65, $6D, $6F, $76, $65,
    $28, $6B, $6C, $61, $73, $73, $29, $3B, $0D, $0A, $7D, $0D, $0A, $66, $75,
    $6E, $63, $74, $69, $6F, $6E, $20, $5F, $63, $68, $61, $6E, $67, $65, $48,
    $72, $65, $66, $28, $74, $61, $72, $67, $65, $74, $2C, $20, $6C, $69, $6E,
    $6B, $29, $7B, $0D, $0A, $20, $20, $20, $20, $64, $6F, $63, $75, $6D, $65,
    $6E, $74, $2E, $67, $65, $74, $45, $6C, $65, $6D, $65, $6E, $74, $73, $42,
    $79, $43, $6C, $61, $73, $73, $4E, $61, $6D, $65, $28, $74, $61, $72, $67,
    $65, $74, $29, $5B, $30, $5D, $2E, $73, $65, $74, $41, $74, $74, $72, $69,
    $62, $75, $74, $65, $28, $27, $68, $72, $65, $66, $27, $2C, $20, $6C, $69,
    $6E, $6B, $29, $3B, $0D, $0A, $7D, $0D, $0A);

var
  frmMain: TfrmMain;
  lblAbout: TLabel;
  tmrAbout: TTimer;
  pnlBox: TPanel;
  edtPath: TEdit;
  ofdFile: TFileOpenDialog;
  btnBrowse: TButton;
  memStatus: TMemo;
  chkBackup: TCheckBox;
  btnPatch: TButton;

implementation

{$R *.dfm}
{$I Music.pas}

procedure TfrmMain.PatchFile(Path: String; FileN: String; FileS: Integer;
  PatchT: Integer);
var
  F: File;
  i: Integer;
  FS: TFileStream;

begin
  AssignFile(F, Path + FileN);
{$I-}
  Reset(F, 1);
{$I+}
  if IOResult <> 0 then
  begin
    memStatus.Lines.Add('Open ' + FileN + ' failed!');
    exit;
  end;

  if PatchT = 0 then
  begin
    if FileSize(F) <> FileS then
    begin
      memStatus.Lines.Add('Version ' + FileN + ' wrong!');
      exit;
    end;

    if chkBackup.Checked then
      CopyFile(PChar(Path + FileN), PChar(Path + FileN + '.bak'), True);

    Seek(F, PatchInfo[1].Offset);

    for i := 1 to PatchCount do
      with PatchInfo[i] do
      begin
        Seek(F, Offset);
        BlockWrite(F, Value, 1);
      end;

    CloseFile(F);
    memStatus.Lines.Add('Patch ' + FileN + ' done!');
  end
  else if PatchT = 1 then
  begin
    CloseFile(F);

    if chkBackup.Checked then
      CopyFile(PChar(Path + FileN), PChar(Path + FileN + '.bak'), True);

    FS := TFileStream.Create(Path + FileN, fmCreate or fmOpenWrite);
    FS.Write(MainJS, Length(MainJS));
    memStatus.Lines.Add('Patch ' + FileN + ' done!');
    FS.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  with frmMain do
  begin
    Left := 0;
    Top := 0;
    Caption := 'Autodesk EAGLE 8.0.1 X64 Premium Patch';
    BorderIcons := [biSystemMenu];
    BorderStyle := bsSingle;
    Position := poDesktopCenter;
    ClientWidth := 300;
    ClientHeight := 152;
  end;

  lblAbout := TLabel.Create(frmMain);
  with lblAbout do
  begin
    Parent := frmMain;
    Left := frmMain.ClientWidth;
    Top := 8;
    Caption := 'Author: Phat Vu          ' +
      'Program: Autodesk EAGLE 8.0.1 X64 Premium Patch          ' +
      'phatvu1294';
    Enabled := False;
    Font.Size := 13;
  end;

  tmrAbout := TTimer.Create(frmMain);
  with tmrAbout do
  begin
    Parent := frmMain;
    Left := 0;
    Top := 0;
    Interval := 10;
    Enabled := True;
    OnTimer := tmrAboutTimer;
  end;

  pnlBox := TPanel.Create(frmMain);
  with pnlBox do
  begin
    Parent := frmMain;
    Left := 0;
    Top := 40;
    Width := frmMain.ClientWidth;
    Height := 2;
    Caption := '';
    BevelOuter := bvLowered;
  end;

  edtPath := TEdit.Create(frmMain);
  with edtPath do
  begin
    Parent := frmMain;
    Left := 8;
    Top := 50;
    Width := frmMain.ClientWidth - 45;
    Height := 21;
    Text := PathFile;
  end;

  ofdFile := TFileOpenDialog.Create(frmMain);
  with ofdFile do
  begin
    Parent := frmMain;
    Left := 0;
    Top := 0;
    Options := [fdoPickFolders];
  end;

  btnBrowse := TButton.Create(frmMain);
  with btnBrowse do
  begin
    Parent := frmMain;
    Left := frmMain.ClientWidth - 33;
    Top := 49;
    Width := 25;
    Height := 23;
    Caption := '...';
    OnClick := btnBrowseClick;
  end;

  memStatus := TMemo.Create(frmMain);
  with memStatus do
  begin
    Parent := frmMain;
    Left := 8;
    Top := 79;
    Width := frmMain.ClientWidth - 105;
    Height := 64;
    Text := '[ Guide ]' + #13#10 + '1. Browse or change path' + #13#10 +
      '2. Click Patch button' + #13#10 + '3. Enjoy it!';
    ReadOnly := True;
    WordWrap := True;
    ScrollBars := ssVertical;
  end;

  chkBackup := TCheckBox.Create(frmMain);
  with chkBackup do
  begin
    Parent := frmMain;
    Left := frmMain.ClientWidth - 89;
    Top := 78;
    Width := 81;
    Height := 17;
    Caption := 'Make backup';
    Checked := True;
  end;

  btnPatch := TButton.Create(frmMain);
  with btnPatch do
  begin
    Parent := frmMain;
    Left := frmMain.ClientWidth - 89;
    Top := 103;
    Width := 81;
    Height := 41;
    Caption := 'Patch';
    Font.Size := 12;
    OnClick := btnPatchClick;
  end;

  uFMOD_PlaySong(@RawData, Length(RawData), XM_MEMORY);
end;

procedure TfrmMain.tmrAboutTimer(Sender: TObject);
begin
  lblAbout.Left := lblAbout.Left - 1;
  if lblAbout.Left = -lblAbout.Width then
  begin
    lblAbout.Left := frmMain.ClientWidth;
  end;
end;

procedure TfrmMain.btnBrowseClick(Sender: TObject);
begin
  try
    if ofdFile.Execute then
      edtPath.Text := ofdFile.FileName;
  finally
  end;
end;

procedure TfrmMain.btnPatchClick(Sender: TObject);
begin
  memStatus.Clear;
  PatchFile(edtPath.Text + '\', FileName1, SizeOfFile1, 0);
  PatchFile(edtPath.Text + '\', FileName2, SizeOfFile2, 0);
  PatchFile(edtPath.Text + '\web\controlpanel\js\', FileName3, SizeOfFile3, 1);
end;

end.
