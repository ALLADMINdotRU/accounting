unit gVariablesLang;

interface

{  type
    typeIniLangFmStart=record  //описываем форму fmStart
      TabEnter:string;
      test2:string;
    end;

    typeLangIni = record   //описываем самый корень
      fmStart:typeIniLangFmStart;
      test1:string;
    end;
              }
implementation
end.
