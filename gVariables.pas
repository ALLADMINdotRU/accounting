unit gVariables;

interface
uses
  Vcl.Dialogs,
  IBX.IBDatabase,
  System.Generics.Collections; //TDictionary
  //gVariablesLang;

  type
    RDatabaseParams=record  //��������� ����������� � ��
      Path:string;             //���� � ��
      Login:string;
      Password:string;
      IP:string;

      create:boolean; //�������� �������� ��
    end;

    RResult=record                                                              //��������� ���������� ����� �� ���� �������
      status: boolean;                                                          //������� ��� ��� ����������
      errMessage: string;                                                       //��������� ��������� �� ������ ���� ��� ����
      errClass:string;                                                          //����� ������ ����������
      varMessage:string;                                                        //�������������� ���������
      varClassErr:string;                                                       //��� ������ ����������

      varTaskIcon : TTaskDialogIcon ;                                           //������� ��� TtaskDialog
      varButton:  TTaskDialogCommonButtons;                                     //������ ��� TtaskDialog
    end;

var
gvarPathApp:string;                                                             //���� �� ����� � ����������
gvarPathConfigIni:string;                                                       //���� �� ����� � ����������� ���������

gvarLANG:string;                                                                //������� ����

gvarLangIni: TDictionary<string, string>;                                       //�������� ������� ���� ��������� ��� �������� �����
gIBDatabase: TIBDatabase;

gvarDatabaseParams:RDatabaseParams;                                             //�������� ��������� ����������� � ��

//gvarLangIni:typeLangIni;        //�������� ������� ���� ��������� ��� �������� �����
implementation

end.
