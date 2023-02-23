unit gVariables;

interface
uses
  Vcl.Dialogs,
  IBX.IBDatabase,
  System.Generics.Collections; //TDictionary
  //gVariablesLang;

  type
    RDatabaseParams=record  //параметры подключения к БД
      Path:string;             //путь к БД
      Login:string;
      Password:string;
      IP:string;

      create:boolean; //комманда создания БД
    end;

    RResult=record                                                              //результат выполнения какой ни будь функции
      status: boolean;                                                          //успешно или нет выполнение
      errMessage: string;                                                       //системное сообщение об ошибке если оно есть
      errClass:string;                                                          //класс ошибки исключения
      varMessage:string;                                                        //дополнительное сообщение
      varClassErr:string;                                                       //тип ошибки самописный

      varTaskIcon : TTaskDialogIcon ;                                           //икондля для TtaskDialog
      varButton:  TTaskDialogCommonButtons;                                     //кнопки для TtaskDialog
    end;

var
gvarPathApp:string;                                                             //путь до папки с программой
gvarPathConfigIni:string;                                                       //путь до файла с настройками программы

gvarLANG:string;                                                                //текущий язык

gvarLangIni: TDictionary<string, string>;                                       //содержит перевод всех компонент для текущего языка
gIBDatabase: TIBDatabase;

gvarDatabaseParams:RDatabaseParams;                                             //содержит параметры подключения к БД

//gvarLangIni:typeLangIni;        //содержит перевод всех компонент для текущего языка
implementation

end.
