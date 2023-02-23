unit pafLang;

interface

 uses
      Vcl.Controls, forms;

  function fCreateLangIniFiles(varPath:string):boolean;
  function fReadIniToVariable(varPath, varLang:string):boolean;
  function fSetLangToForm(varFmName:string; varObject:TWinControl):boolean;

implementation

uses

  System.SysUtils,
  System.IOUtils,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  json,
  gVariables,
  pafIni;

//******************************************************************************
//Создание INI файла с настройками языка для всех компонент программы
//varPath - путь до папки где лежат файлы с языкам
//******************************************************************************
function fCreateLangIniFiles(varPath:string):boolean;

begin
  Write_ini_str('fmStart', 'TabEnter', 'Enter', varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'TabEnter', 'Вход',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxUser', 'Login',         varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxUser', 'Пользователь',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxPassword', 'Password',  varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxPassword', 'Пароль',    varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'TabDatabase', 'Database',     varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'TabDatabase', 'База данных',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabasePath', 'Path',  varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabasePath', 'Путь',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabaseLogin', 'Login',        varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabaseLogin', 'Пользователь', varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabasePassword', 'Password',  varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabasePassword', 'Пароль',    varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabaseIPaddress', 'IP address', varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabaseIPaddress', 'IP адрес ',  varPath + '\RUS.ini');

end;
//******************************************************************************
//******************************************************************************




//******************************************************************************
//чтение ini файла с выбраным языком в глобальную переменную содержащая названия всех компонент в программе
//varPath - путь до папки с языком
//varLang - язык = имя файла
//******************************************************************************
function fReadIniToVariable(varPath, varLang:string):boolean;
var
  F : TextFile;
  S : String;
  varKey:string;
  varValue:string;
  varSection:string;
begin
  gvarLangIni.Clear;                                                            //очищаем словарь
  varPath := varPath + '\' + varLang + '.ini';                                  //модифицируем путь до файлы с ini файлом
  AssignFile(F,varPath);
  Reset(F);                                                                     // Читаем файл построчно, в цикле , где :
  while NOT EoF(F) do                                                           // EoF - конец файла, (End Of File). В цикле -
    begin
    ReadLn(F,S);                                                                // берем строку, и
    if Pos('[', S) <> 0 then varSection := Copy( S, 2, Length(S) - 2 );         // если это секция записываем название
    if Pos('=', S) <> 0 then                                                    // если это ключ=значение то начинаем получать значения
      begin
      if Pos('=', S) <> 0 then varKey := varSection + '.' + Copy(S, 1, Pos('=', S)-1);  //копируем  ключ, и делаем конкратинацию с секцией
      if Pos('=', S) <> 0 then varValue := Copy(S, Pos('=', S)+1, Length(S) - Pos('=',S));//копируем значение
      gvarLangIni.Add(varKey, varValue);                                        //добавляем пару ключ=значение в словарь
      end;
    end;
end;
//******************************************************************************
//******************************************************************************


//******************************************************************************
//устанавливаем имена объектов в компоненты
//varFmName - имя формы где будет менятся язык
//varObject - форма где находятся объекты
//******************************************************************************
function fSetLangToForm(varFmName:string; varObject:TWinControl):boolean;
var
  i:integer;
  varControl:Tcontrol;
  varText: string;
begin
  for i:=0 to varObject.ControlCount - 1 do                                     //перебираем все компоненты на форме
    begin
    varControl := varObject.Controls[i];                                        //записываем ссылку на объект в переменную
    varText    := varFmName + '.' + varControl.Name;                            //
    if gvarLangIni.ContainsKey(varText) then                                    //если есть ключ с этим именем (именеме формы + имя компонента на форме) то
      begin                                                                     //
      if (varControl is TTabSheet) then (varControl as TTabSheet).Caption := gvarLangIni[varText]; //проверяем что за объект и приводим его к этому виду присваивая описание
      if (varControl is TGroupBox) then (varControl as TGroupBox).Caption := gvarLangIni[varText];
      end;

    //проверяем является ли объект объектом которы может содержать другие элементы
    if (varControl is TPageControl) then fSetLangToForm(varFmName, (varControl as TPageControl));  //объект может содержать другие обеъкты, поэтому передаем имя формы (для поиска нужного ключа) и сам объект
    if (varControl is TTabSheet)    then fSetLangToForm(varFmName, (varControl as TTabSheet));
    end;
end;

end.

end.
