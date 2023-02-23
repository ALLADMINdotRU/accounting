unit pafDatabase;

interface
uses

  IBX.IBDatabase,
  IBX.ib,
  gVariables;

  function fCreateIBDatabase(var varIBDatabase: TIBDatabase; varDatabaseParams:RDatabaseParams):RResult;


implementation
   uses
    Vcl.Dialogs, System.SysUtils, vcl.forms;

//******************************************************************************
//�������������� TIBDatabase
//******************************************************************************
function fCreateIBDatabase(var varIBDatabase: TIBDatabase; varDatabaseParams:RDatabaseParams):RResult;
begin
   try
  if  varIBDatabase <> nil then
    varIBDatabase.Destroy;                        //���� ������ ��� ���� �� ���������������

  varIBDatabase := TIBDatabase.Create(application);                                     //�������� ������
  varIBDatabase.LoginPrompt := false;                                           //��������� ��� �� ����� ����������� ������ ��� �����������
  varIBDatabase.SQLDialect := 3;
  varIBDatabase.Params.Clear;
  varIBDatabase.Params.Add('LC_CTYPE=WIN1251');
  varIBDatabase.Params.Add('USER_NAME=' + varDatabaseParams.Login);
  varIBDatabase.Params.Add('PASSWORD=' + varDatabaseParams.Password);
  varIBDatabase.DatabaseName := varDatabaseParams.IP + ':' + varDatabaseParams.Path;
  if varDatabaseParams.create then varIBDatabase.CreateDatabase;                //������� ��
  varIBDatabase.Connected := true;                                              //����������� � ��
  result.status:=true;                                                          //���� ��� ����������� ������ , �� ���������� ���������
  except                                                                        //���� �� ����� �������� ������� ��������� ������
    on e:EIBError  do
      ShowMessage( inttostr(e.IBErrorCode ));


       {e.Message + '   ' + e.ClassName}
      //inttostr(e.IBErrorCode)
    {  begin
      result.status     := false;                                               //��������� ��� ��������� ������ �� ����� �������� �������
      result.errMessage := e.Message;                                           //��������� ��������� �� ������
      result.errClass   := e.ClassName;                                         //��������� ����� ������

      if pos('Error while trying to create file', e.Message)<> 0 then           //���� �� �� ���������
        begin
        result.varMessage := '(pafDatabase#fCreateIBDatabase)' + #10#13 + 'IBDatabase can not create Database ';
        result.varClassErr := 'CreateDatabaseErr';                              //��������� ��� ������ ��� ������� �������� ��
        result.varButton := [tcbCancel]  ;                                      //��������� ����� ������ �� ����� ����������
        result.varTaskIcon := tdiError;                                         //��������� ��� ������
        end;

      if pos('Your user name and password are not defined', e.Message)<> 0 then //���� �� ������ ����� ��� ������
        begin
        result.varMessage := '(pafDatabase#fCreateIBDatabase)' + #10#13 + 'IBDatabase incorrect login or password ';
        result.varClassErr := 'LoginPasswordErr';                               //��������� ��� ������ ������ ��� ������
        result.varButton := [tcbCancel]  ;                                      //��������� ����� ������ �� ����� ����������
        result.varTaskIcon := tdiError;                                         //��������� ��� ������
        end;

      if pos('Error while trying to open file', e.Message)<> 0 then             //���� ���� ����
        begin
        result.varMessage := '(pafDatabase#fCreateIBDatabase)' + #10#13 + 'IBDatabase can not connect because database not exist' + #10#13 + 'Create a database?';
        result.varClassErr := 'OpenDatabaseErr';                                //��������� ��� ���� ���
        result.varButton := [tcbYes, tcbCancel]  ;                              //��������� ����� ������ �� ����� ����������
        result.varTaskIcon := tdiError;                                         //��������� ��� ������
        end;
      end; }
  end;
end;

end.
