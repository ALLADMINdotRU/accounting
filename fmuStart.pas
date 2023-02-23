unit fmuStart;

interface

uses
  IBX.IBDatabase,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  pafOtherFunction
  ;

type
  TfmStart = class(TForm)
    PageControl1: TPageControl;
    TabEnter: TTabSheet;
    BitBtn1: TBitBtn;
    GroupBoxUser: TGroupBox;
    ComboBoxUser: TComboBox;
    GroupBoxPassword: TGroupBox;
    EditPassword: TEdit;
    TabDatabase: TTabSheet;
    GroupBoxDatabasePath: TGroupBox;
    EditDatabasePath: TEdit;
    GroupBoxDatabaseLogin: TGroupBox;
    EditDatabaseLogin: TEdit;
    GroupBoxDatabasePassword: TGroupBox;
    EditDatabasePassword: TEdit;
    GroupBoxDatabaseIPaddress: TGroupBox;
    EditDatabaseIPaddress: TEdit;
    BitBtnSaveDatabase: TBitBtn;
    TaskDialog1: TTaskDialog;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnSaveDatabaseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStart: TfmStart;

implementation

uses   System.Generics.Collections, //TDictionary
  pafDatabase,
  gVariables,
  gVariablesLang,
  pafLang, rtti,
  pafIni
  ;

{$R *.dfm}

//******************************************************************************
//������� ���� ������������ ��������� � ���������� �����������
//******************************************************************************
function fCreateConfigFileWithDefaultSetings(varFile:string):boolean;
begin
  Write_ini_str('GLOBAL', 'LANG', 'RUS', varFile);

  Write_ini_str('DATABASE', 'PATH',     ExtractFilePath(paramstr(0)) + 'base.fdb', varFile); //���� �� ��
  Write_ini_str('DATABASE', 'LOGIN',    'SYSDBA', varFile);
  Write_ini_str('DATABASE', 'PASSWORD', 'masterkey', varFile);
  Write_ini_str('DATABASE', 'IPADDRESS','127.0.0.1', varFile);
end;
//******************************************************************************
//******************************************************************************


procedure TfmStart.BitBtn1Click(Sender: TObject);
var
varControl:Tcontrol;
begin


  { gvarLangIni.Add('sdff', 'sdf');
     gvarLangIni.Add('xcv', 'ggff') ;
      gvarLangIni.Add('ghr', 'bnbn') ;

     showmessage(gvarLangIni.Items['xcv']);         }

 // if gvarLangIni.ContainsKey('xcv') then

 try

 except
   on E:Exception do

 end;

end;

procedure TfmStart.BitBtnSaveDatabaseClick(Sender: TObject);
var
  varErrMessage:  RResult;
label
  varGoToLabel1;
begin
   inttostr(8) ;

  gvarDatabaseParams.Path     := EditDatabasePath.Text;
  gvarDatabaseParams.Login    := EditDatabaseLogin.Text;
  gvarDatabaseParams.Password := EditDatabasePassword.Text;
  gvarDatabaseParams.IP       := EditDatabaseIPaddress.Text;

  Write_ini_str('DATABASE', 'PATH',     gvarDatabaseParams.Path,      gvarPathConfigIni); //���� �� ��
  Write_ini_str('DATABASE', 'LOGIN',    gvarDatabaseParams.Login,     gvarPathConfigIni);
  Write_ini_str('DATABASE', 'PASSWORD', gvarDatabaseParams.Password,  gvarPathConfigIni);
  Write_ini_str('DATABASE', 'IPADDRESS',gvarDatabaseParams.IP,        gvarPathConfigIni);

  gvarDatabaseParams.create:=true;                                             //��������� ��� �� �� ������� ��
varGoToLabel1:                                                                  //����� ��� GoTo
  varErrMessage := fCreateIBDatabase(gIBDatabase, gvarDatabaseParams);          //�������������� IBDatabase
  if not varErrMessage.status then                                              //���� �� ������ ������� ������
    with CreateTTaskDialog(varErrMessage) do                                    //������� ��������� ���� � ������������ ������ ��������
      begin
      if Execute then
        if ModalResult = mrYes then                                             //��� ���� �� ������ �� ������� ��
          begin
          gvarDatabaseParams.create:=true;                                      //�������� ��� ��� ���� ������� ��
          goto  varGoToLabel1                                                   //��������� �� �����
          end;
      end;

  //ShowMessage(gIBDatabase.DatabaseName);

    {
  with fCreateIBDatabase(gIBDatabase, gvarDatabaseParams) do                    //�������������� IBDatabase
    if not status then                                                          //���� �� ������
      CreateTTaskDialog();

      showmessage(varMessage + #10#13 + #10#13 + errClass + #10#13 + #10#13 +  errMessage);                             //������� ������� ������
      }
end;



procedure TfmStart.FormCreate(Sender: TObject);
begin
  //����� ��������� � ��� ������ ��������
  gvarLangIni:= TDictionary<String,String>.create;                              //������� ������� ��� ������ �������� ����� ���������
  gvarPathApp :=  ExtractFilePath(paramstr(0));                                 //���� �� ����� � ����������
  gvarPathConfigIni := gvarPathApp + 'config.ini';                              //��������� ���� �� ����� � ����������� ���������  config.ini

  if not FileExists(gvarPathConfigIni) then                                     //��������� ������������� ����� config.ini
    begin
    fCreateConfigFileWithDefaultSetings(gvarPathConfigIni);                     //������� ���� ������������ � ���������� �����������
    end;

  if not DirectoryExists(gvarPathApp + 'Lang') then                             //���� ����� � ��������� ������� �� ���������� ��                                                                        //���� ����� ����
    if CreateDir(gvarPathApp + 'Lang') then                                     //������� �����
      begin
      fCreateLangIniFiles(gvarPathApp + 'Lang');                                //������� ����� ini � ������� RUS � ENG
      end;


  gvarLANG := Read_ini_str('GLOBAL','LANG',gvarPathConfigIni);                  //�������� ���� ���������
  fReadIniToVariable(gvarPathApp + 'Lang', gvarLANG) ;                          //��������� ���� � ���������� ����������

  //��������� ��������� ����������� � �� + ������� �� �� �����
  gvarDatabaseParams.Path     := Read_ini_str('DATABASE', 'PATH',     gvarPathConfigIni); //���� �� ��
  gvarDatabaseParams.Login    := Read_ini_str('DATABASE', 'LOGIN',    gvarPathConfigIni);
  gvarDatabaseParams.Password := Read_ini_str('DATABASE', 'PASSWORD', gvarPathConfigIni);
  gvarDatabaseParams.IP       := Read_ini_str('DATABASE', 'IPADDRESS',gvarPathConfigIni);
  EditDatabasePath.Text       := gvarDatabaseParams.Path;
  EditDatabaseLogin.Text      := gvarDatabaseParams.Login;
  EditDatabasePassword.Text   := gvarDatabaseParams.Password;
  EditDatabaseIPaddress.Text  := gvarDatabaseParams.IP;

  fSetLangToForm(fmstart.Name, fmstart);                                        //������ ������� ��������� (������ �����)
end;

end.
