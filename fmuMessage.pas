unit fmuMessage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfmMessage = class(TForm)
    Label1: TLabel;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    BitBtnNo: TBitBtn;
    BitBtnYes: TBitBtn;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMessage: TfmMessage;

implementation

{$R *.dfm}

end.
