unit pafCreateAndUpdateTables;

interface
  uses
    IBX.IBQuery,
    IBX.IBDatabase,
    IBX.ib,
    gVariables;

  procedure pCreateTablesByDatabase;

implementation
  uses
   pafOtherFunction,
   Vcl.Dialogs,
   System.SysUtils,
   pafDatabase,
   pafTableUSERS_DB;

   const
   ModuleName = 'pafCreateAndUpdateTables';

procedure pCreateTablesByDatabase;
const
  FunctionName = 'pCreateTablesByDatabase';

  procedure RequestSQL(varSQLstring: string);
  var
    varIBQuery: TIBQuery;
    varErr: RResult;

    begin
      try
      pCreateIBQuery(varIBQuery);                                                 //инициализируем IBQuery
      varIBQuery.Active := false;
      varIBQuery.SQL.Clear;
      varIBQuery.SQL.Add(varSQLstring);
      varIBQuery.ExecSQL;
      gIBTransaction.Commit;
      FreeAndNil(varIBQuery);
      except
      on e:EIBInterBaseError do
        begin                                                                   //выводим информацию
        pExceptionEIBInterBaseErrorSQL(e, ModuleName, FunctionName, varIBQuery.SQL.Text);  //генерируем ошибку и выводим диалоговое окно
        end;
      end;
    end;

  begin
  //****************************************************************************
  //USER_DB
  //****************************************************************************
  //Table
  RequestSQL(
    'CREATE TABLE USERS_DB ('
    +'    ID        INTEGER NOT NULL,'
    +'    FULLNAME  CHAR(255),'
    +'    PASS      CHAR(50),'
    +'    DEL       INTEGER  DEFAULT 0'
    +');'
  );

  //Generators
  RequestSQL('CREATE SEQUENCE GEN_USERS_DB_ID;');
  RequestSQL('SET GENERATOR GEN_USERS_DB_ID TO 0;');

  //Primary Keys
  RequestSQL('ALTER TABLE USERS_DB ADD CONSTRAINT PK_USERS_DB PRIMARY KEY (ID);');

  //Description
  RequestSQL('COMMENT ON COLUMN USERS_DB.ID IS ' + '''' + 'ID' + '''');
  RequestSQL('COMMENT ON COLUMN USERS_DB.FULLNAME IS ' + '''' + 'Full name user' + '''');
  RequestSQL('COMMENT ON COLUMN USERS_DB.PASS IS ' + '''' + 'Password by user' + '''');

  //Add Data
  pUSERS_DBInsertData(fUSERS_DBGenID, 'admin', 'admin');                           //добавляем пользователя в БД
  //****************************************************************************
  //****************************************************************************


  end;




end.
