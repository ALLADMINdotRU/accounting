unit pafIni; //тут производится работа с ini файлами

interface
uses
inifiles,  //подклчаем модуль дабы работать с ini файлами
SysUtils;



function Write_ini_str(perUnit,perKey,perValue,perPathIni:string):boolean;
function Read_ini_str(perUnit,perKey,perPathIni:string):string;
function Read_ini_bool(perUnit,perKey,perPathIni:string):Boolean;  //секция , ключ, на выходе получим параметр
function Write_ini_bool(perUnit,perKey,perPathIni:string;perValue:Boolean):boolean;  // секция, ключ, параметр
function Write_ini_int(perUnit,perKey,perPathIni:string; perValue:Integer):boolean;  // секция, ключ, параметр
function Read_ini_int(perUnit,perKey,perPathIni:string):Integer;  //секция , ключ, на выходе получим параметр

implementation


//функция для вытаскивания параметров из ini файла
function Read_ini_str(perUnit,perKey,perPathIni:string):string;  //секция , ключ, на выходе получим параметр
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //указываем путь до файла ini если его нету , то он создаться сам
  Result:=config_ini.ReadString(perUnit,perKey,''); //секция, ключ, по дефолту
  config_ini.Free;
end;


//функция для вытаскивания параметров из ini файла
function Read_ini_int(perUnit,perKey,perPathIni:string):Integer;  //секция , ключ, на выходе получим параметр
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //указываем путь до файла ini если его нету , то он создаться сам
  Result:=config_ini.ReadInteger(perUnit,perKey,-1); //секция, ключ, по дефолту
  config_ini.Free;
end;

//функция для вгоняния параметров в ini файл строковых параметров
function Write_ini_str(perUnit,perKey,perValue,perPathIni:string):boolean;  // секция, ключ, параметр
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //указываем путь до файла ini если его нету , то он создаться сам
  config_ini.WriteString(perUnit,perKey,perValue);
  config_ini.Free;
end;


//функция для вгоняния параметров в ini файл числов параметров
function Write_ini_int(perUnit,perKey,perPathIni:string; perValue:Integer):boolean;  // секция, ключ, параметр
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //указываем путь до файла ini если его нету , то он создаться сам
  config_ini.WriteInteger(perUnit,perKey,perValue);
  config_ini.Free;
end;

function Read_ini_bool(perUnit,perKey,perPathIni:string):Boolean;  //секция , ключ, на выходе получим параметр
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //указываем путь до файла ini если его нету , то он создаться сам
  Result:=config_ini.ReadBool(perUnit,perKey,false); //секция, ключ, по дефолту
  config_ini.Free;
end;


//функция для вгоняния параметров в ini файл булевых параметров
function Write_ini_bool(perUnit,perKey,perPathIni:string;perValue:Boolean):boolean;  // секция, ключ, параметр
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //указываем путь до файла ini если его нету , то он создаться сам
  config_ini.WriteBool(perUnit,perKey,perValue);
  config_ini.Free;
end;
end.
