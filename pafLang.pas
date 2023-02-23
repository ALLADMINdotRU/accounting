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
//�������� INI ����� � ����������� ����� ��� ���� ��������� ���������
//varPath - ���� �� ����� ��� ����� ����� � ������
//******************************************************************************
function fCreateLangIniFiles(varPath:string):boolean;

begin
  Write_ini_str('fmStart', 'TabEnter', 'Enter', varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'TabEnter', '����',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxUser', 'Login',         varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxUser', '������������',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxPassword', 'Password',  varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxPassword', '������',    varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'TabDatabase', 'Database',     varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'TabDatabase', '���� ������',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabasePath', 'Path',  varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabasePath', '����',  varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabaseLogin', 'Login',        varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabaseLogin', '������������', varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabasePassword', 'Password',  varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabasePassword', '������',    varPath + '\RUS.ini');

  Write_ini_str('fmStart', 'GroupBoxDatabaseIPaddress', 'IP address', varPath + '\ENG.ini');
  Write_ini_str('fmStart', 'GroupBoxDatabaseIPaddress', 'IP ����� ',  varPath + '\RUS.ini');

end;
//******************************************************************************
//******************************************************************************




//******************************************************************************
//������ ini ����� � �������� ������ � ���������� ���������� ���������� �������� ���� ��������� � ���������
//varPath - ���� �� ����� � ������
//varLang - ���� = ��� �����
//******************************************************************************
function fReadIniToVariable(varPath, varLang:string):boolean;
var
  F : TextFile;
  S : String;
  varKey:string;
  varValue:string;
  varSection:string;
begin
  gvarLangIni.Clear;                                                            //������� �������
  varPath := varPath + '\' + varLang + '.ini';                                  //������������ ���� �� ����� � ini ������
  AssignFile(F,varPath);
  Reset(F);                                                                     // ������ ���� ���������, � ����� , ��� :
  while NOT EoF(F) do                                                           // EoF - ����� �����, (End Of File). � ����� -
    begin
    ReadLn(F,S);                                                                // ����� ������, �
    if Pos('[', S) <> 0 then varSection := Copy( S, 2, Length(S) - 2 );         // ���� ��� ������ ���������� ��������
    if Pos('=', S) <> 0 then                                                    // ���� ��� ����=�������� �� �������� �������� ��������
      begin
      if Pos('=', S) <> 0 then varKey := varSection + '.' + Copy(S, 1, Pos('=', S)-1);  //��������  ����, � ������ ������������� � �������
      if Pos('=', S) <> 0 then varValue := Copy(S, Pos('=', S)+1, Length(S) - Pos('=',S));//�������� ��������
      gvarLangIni.Add(varKey, varValue);                                        //��������� ���� ����=�������� � �������
      end;
    end;
end;
//******************************************************************************
//******************************************************************************


//******************************************************************************
//������������� ����� �������� � ����������
//varFmName - ��� ����� ��� ����� ������� ����
//varObject - ����� ��� ��������� �������
//******************************************************************************
function fSetLangToForm(varFmName:string; varObject:TWinControl):boolean;
var
  i:integer;
  varControl:Tcontrol;
  varText: string;
begin
  for i:=0 to varObject.ControlCount - 1 do                                     //���������� ��� ���������� �� �����
    begin
    varControl := varObject.Controls[i];                                        //���������� ������ �� ������ � ����������
    varText    := varFmName + '.' + varControl.Name;                            //
    if gvarLangIni.ContainsKey(varText) then                                    //���� ���� ���� � ���� ������ (������� ����� + ��� ���������� �� �����) ��
      begin                                                                     //
      if (varControl is TTabSheet) then (varControl as TTabSheet).Caption := gvarLangIni[varText]; //��������� ��� �� ������ � �������� ��� � ����� ���� ���������� ��������
      if (varControl is TGroupBox) then (varControl as TGroupBox).Caption := gvarLangIni[varText];
      end;

    //��������� �������� �� ������ �������� ������ ����� ��������� ������ ��������
    if (varControl is TPageControl) then fSetLangToForm(varFmName, (varControl as TPageControl));  //������ ����� ��������� ������ �������, ������� �������� ��� ����� (��� ������ ������� �����) � ��� ������
    if (varControl is TTabSheet)    then fSetLangToForm(varFmName, (varControl as TTabSheet));
    end;
end;

end.

end.
