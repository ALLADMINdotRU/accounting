unit pafIni; //��� ������������ ������ � ini �������

interface
uses
inifiles,  //��������� ������ ���� �������� � ini �������
SysUtils;



function Write_ini_str(perUnit,perKey,perValue,perPathIni:string):boolean;
function Read_ini_str(perUnit,perKey,perPathIni:string):string;
function Read_ini_bool(perUnit,perKey,perPathIni:string):Boolean;  //������ , ����, �� ������ ������� ��������
function Write_ini_bool(perUnit,perKey,perPathIni:string;perValue:Boolean):boolean;  // ������, ����, ��������
function Write_ini_int(perUnit,perKey,perPathIni:string; perValue:Integer):boolean;  // ������, ����, ��������
function Read_ini_int(perUnit,perKey,perPathIni:string):Integer;  //������ , ����, �� ������ ������� ��������

implementation


//������� ��� ������������ ���������� �� ini �����
function Read_ini_str(perUnit,perKey,perPathIni:string):string;  //������ , ����, �� ������ ������� ��������
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //��������� ���� �� ����� ini ���� ��� ���� , �� �� ��������� ���
  Result:=config_ini.ReadString(perUnit,perKey,''); //������, ����, �� �������
  config_ini.Free;
end;


//������� ��� ������������ ���������� �� ini �����
function Read_ini_int(perUnit,perKey,perPathIni:string):Integer;  //������ , ����, �� ������ ������� ��������
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //��������� ���� �� ����� ini ���� ��� ���� , �� �� ��������� ���
  Result:=config_ini.ReadInteger(perUnit,perKey,-1); //������, ����, �� �������
  config_ini.Free;
end;

//������� ��� �������� ���������� � ini ���� ��������� ����������
function Write_ini_str(perUnit,perKey,perValue,perPathIni:string):boolean;  // ������, ����, ��������
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //��������� ���� �� ����� ini ���� ��� ���� , �� �� ��������� ���
  config_ini.WriteString(perUnit,perKey,perValue);
  config_ini.Free;
end;


//������� ��� �������� ���������� � ini ���� ������ ����������
function Write_ini_int(perUnit,perKey,perPathIni:string; perValue:Integer):boolean;  // ������, ����, ��������
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //��������� ���� �� ����� ini ���� ��� ���� , �� �� ��������� ���
  config_ini.WriteInteger(perUnit,perKey,perValue);
  config_ini.Free;
end;

function Read_ini_bool(perUnit,perKey,perPathIni:string):Boolean;  //������ , ����, �� ������ ������� ��������
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //��������� ���� �� ����� ini ���� ��� ���� , �� �� ��������� ���
  Result:=config_ini.ReadBool(perUnit,perKey,false); //������, ����, �� �������
  config_ini.Free;
end;


//������� ��� �������� ���������� � ini ���� ������� ����������
function Write_ini_bool(perUnit,perKey,perPathIni:string;perValue:Boolean):boolean;  // ������, ����, ��������
var
 config_ini:TIniFile;
begin
  config_ini:=TIniFile.Create(perPathIni); //��������� ���� �� ����� ini ���� ��� ���� , �� �� ��������� ���
  config_ini.WriteBool(perUnit,perKey,perValue);
  config_ini.Free;
end;
end.
