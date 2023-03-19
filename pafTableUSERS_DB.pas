unit pafTableUSERS_DB;

interface
  uses

    gVariables;

  function fUSERS_DBGenID:integer;
  procedure pUSERS_DBInsertData(varID:integer; varFULLNAME, varPASS:string);
  function fUSERS_DBSelectFULLNAMEandID:TArray<Tusers_db>;
  function fUSERS_DBGetPASSbyID(varID: integer):string;


implementation

   uses
    IBX.ib,
    IBX.IBQuery,
    pafOtherFunction,
    System.SysUtils,
    pafDatabase
    ;

    const
    ModuleName = 'pafTableUSERS_DB';


//                            ---USERS_DB---
//******************************************************************************
//USERS_DB // генерация ID таблицы  USERS_DB
//******************************************************************************
function fUSERS_DBGenID:integer;
begin
result := fSQLGenID('select GEN_ID(GEN_USERS_DB_ID, 1) from RDB$DATABASE ');    //вызываем запрос на генерацию и получение результата
end;
//******************************************************************************
//******************************************************************************


//******************************************************************************
//USERS_DB // Добавление записи в таблицу USER_DB
//******************************************************************************
procedure pUSERS_DBInsertData(varID:integer; varFULLNAME, varPASS:string);
var
  varIBQuery: TIBQuery;
const
  FunctionName = 'pInsert_USERS_DB';

begin
  try
  pCreateIBQuery(varIBQuery);                                                   //инициализируем IBQuery
  varIBQuery.Active := false;
  varIBQuery.SQL.Clear;
  varIBQuery.SQL.Add(
      'insert into USERS_DB '
    + '('
    + 'ID, '
    + 'FULLNAME, '
    + 'PASS '
    + ') '
    + 'values ('
    + ':varID, '
    + ':varFULLNAME, '
    + ':varPASS '
    + ')'
    );

  if  varID = 0               then varIBQuery.ParamByName('varID').IsNull              else  varIBQuery.ParamByName('varID').AsInteger:= varID;
  if  trim(varFULLNAME)=''    then varIBQuery.ParamByName('varFULLNAME').IsNull        else  varIBQuery.ParamByName('varFULLNAME').asstring:=trim(varFULLNAME);
  if  trim(varPASS)=''        then varIBQuery.ParamByName('varPASS').IsNull            else  varIBQuery.ParamByName('varPASS').asstring:=trim(varPASS);

  varIBQuery.ExecSQL;
  gIBTransaction.Commit;
  FreeAndNil(varIBQuery);
  except
  on e:EIBInterBaseError do
    begin                                                                       //выводим информацию
    pExceptionEIBInterBaseErrorSQL(e, ModuleName, FunctionName, varIBQuery.SQL.Text); //генерируем ошибку и выводим диалоговое окно
    end;
  end;
end;
//******************************************************************************
//******************************************************************************


//******************************************************************************
//USERS_DB // получаем ID и FULLNAEM из таблицы USERS_DB
//******************************************************************************
function fUSERS_DBSelectFULLNAMEandID:TArray<Tusers_db>;
var
  varIBQuery: TIBQuery;
  i: integer;
  r: Tusers_db;
const
  FunctionName = 'fUSERS_DBSelectFULLNAMEandID';
begin
  try
  pCreateIBQuery(varIBQuery);                                                   //инициализируем IBQuery
  varIBQuery.Active := false;
  varIBQuery.SQL.Clear;
  varIBQuery.SQL.Add(
      'select ID, FULLNAME '
    + 'from '
    + 'USERS_DB '
    + 'where '
    + 'DEL = 0 '
    );
  varIBQuery.Open;

  except                                                                        //вызываем исключение при ошибки в SQL запросе
  on e:EIBInterBaseError do
    begin                                                                       //выводим информацию
    pExceptionEIBInterBaseErrorSQL(e, ModuleName, FunctionName, varIBQuery.SQL.Text); //генерируем ошибку и выводим диалоговое окно
    end;
  end;

  try
  //помещаем результат в массив TArray                                          //возможно для ускорения работы требуется использвоать Tlist
  Result := nil;
  while not varIBQuery.Eof do
    begin
    r.ID := varIBQuery.FieldByName('ID').AsInteger;
    r.FULLNAME := trim(varIBQuery.FieldByName('FULLNAME').AsString);
    insert( r ,result, length(result));
    varIBQuery.Next;
    end;

  except
  on e:Exception do
    begin
    pException(e, ModuleName, FunctionName);                                    //генерируем ошибку и выводим диалоговое окно
    end;
  end;

  FreeAndNil(varIBQuery);
end;
//******************************************************************************
//******************************************************************************

//******************************************************************************
//USERS_DB // получаем пароль по ID таблицы USERS_DB
//******************************************************************************
function fUSERS_DBGetPASSbyID(varID: integer):string;
var
  varIBQuery: TIBQuery;
const
  FunctionName = 'fSelect_PASSWORDbyID_USERS_DB';
begin
  try
  pCreateIBQuery(varIBQuery);                                                   //инициализируем IBQuery
  varIBQuery.Active := false;
  varIBQuery.SQL.Clear;
  varIBQuery.SQL.Add(
      'select PASS '
    + 'from '
    + 'USERS_DB '
    + 'where '
    + 'ID = :varID '
    );

  if  varID = 0               then varIBQuery.ParamByName('varID').IsNull              else  varIBQuery.ParamByName('varID').AsInteger:= varID;
  varIBQuery.Open;

  except                                                                        //вызываем исключение при ошибки в SQL запросе
  on e:EIBInterBaseError do
    begin                                                                       //выводим информацию
    pExceptionEIBInterBaseErrorSQL(e, ModuleName, FunctionName, varIBQuery.SQL.Text); //генерируем ошибку и выводим диалоговое окно
    end;
  end;

  try
  result := trim(varIBQuery.FieldByName('PASS').AsString);                      //получаем строку с паролем

  except
  on e:Exception do
    begin
    pException(e, ModuleName, FunctionName);                                    //генерируем ошибку и выводим диалоговое окно
    end;
  end;

  FreeAndNil(varIBQuery);
end;
//******************************************************************************
//******************************************************************************
end.
