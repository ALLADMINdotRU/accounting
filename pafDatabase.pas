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
//инициализируем TIBDatabase
//******************************************************************************
function fCreateIBDatabase(var varIBDatabase: TIBDatabase; varDatabaseParams:RDatabaseParams):RResult;
begin
   try
  if  varIBDatabase <> nil then
    varIBDatabase.Destroy;                        //если объект уже есть то самоуничтожение

  varIBDatabase := TIBDatabase.Create(application);                                     //выделяем память
  varIBDatabase.LoginPrompt := false;                                           //указываем что не будем запрашивать пароль при подключении
  varIBDatabase.SQLDialect := 3;
  varIBDatabase.Params.Clear;
  varIBDatabase.Params.Add('LC_CTYPE=WIN1251');
  varIBDatabase.Params.Add('USER_NAME=' + varDatabaseParams.Login);
  varIBDatabase.Params.Add('PASSWORD=' + varDatabaseParams.Password);
  varIBDatabase.DatabaseName := varDatabaseParams.IP + ':' + varDatabaseParams.Path;
  if varDatabaseParams.create then varIBDatabase.CreateDatabase;                //создаем БД
  varIBDatabase.Connected := true;                                              //подключение к БД
  result.status:=true;                                                          //если все выполнилось хорошо , то возвращаем результат
  except                                                                        //если во время создания объекта произошла ошибка
    on e:EIBError  do
      ShowMessage( inttostr(e.IBErrorCode ));


       {e.Message + '   ' + e.ClassName}
      //inttostr(e.IBErrorCode)
    {  begin
      result.status     := false;                                               //указываем что произошла ошибка во время создаиня объякта
      result.errMessage := e.Message;                                           //системное сообщение об ошибке
      result.errClass   := e.ClassName;                                         //системный класс ошибки

      if pos('Error while trying to create file', e.Message)<> 0 then           //если БД не создается
        begin
        result.varMessage := '(pafDatabase#fCreateIBDatabase)' + #10#13 + 'IBDatabase can not create Database ';
        result.varClassErr := 'CreateDatabaseErr';                              //указываем что ошибка при попытке созаднии БД
        result.varButton := [tcbCancel]  ;                                      //указываем какие кнопки мы будем показывать
        result.varTaskIcon := tdiError;                                         //указываем тип иконки
        end;

      if pos('Your user name and password are not defined', e.Message)<> 0 then //если не верный логин или пароль
        begin
        result.varMessage := '(pafDatabase#fCreateIBDatabase)' + #10#13 + 'IBDatabase incorrect login or password ';
        result.varClassErr := 'LoginPasswordErr';                               //указываем что ошибка логина или пароля
        result.varButton := [tcbCancel]  ;                                      //указываем какие кнопки мы будем показывать
        result.varTaskIcon := tdiError;                                         //указываем тип иконки
        end;

      if pos('Error while trying to open file', e.Message)<> 0 then             //если базы нету
        begin
        result.varMessage := '(pafDatabase#fCreateIBDatabase)' + #10#13 + 'IBDatabase can not connect because database not exist' + #10#13 + 'Create a database?';
        result.varClassErr := 'OpenDatabaseErr';                                //указываем что базы нет
        result.varButton := [tcbYes, tcbCancel]  ;                              //указываем какие кнопки мы будем показывать
        result.varTaskIcon := tdiError;                                         //указываем тип иконки
        end;
      end; }
  end;
end;

end.
