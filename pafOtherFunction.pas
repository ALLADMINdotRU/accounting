unit pafOtherFunction;

interface
  uses
  Vcl.Dialogs,
  gVariables

  ;

  function CreateTTaskDialog(varErrMessage:RResult):TTaskDialog;

implementation



function CreateTTaskDialog(varErrMessage:RResult):TTaskDialog;
var
  varTaskDialog: TTaskDialog;

begin
  result := TTaskDialog.Create(nil);
  result.Caption       := '';
  result.Title         := varErrMessage.errClass;
  result.MainIcon      := varErrMessage.varTaskIcon;                     //указываем иконку
  result.Text          := varErrMessage.varMessage;                      //указываем текст ошибки
  result.CommonButtons := varErrMessage.varButton;                       //указываем кнопки
  result.ExpandedText  := varErrMessage.errMessage;                      //указываем по€сн€ющий текст ќтображаетс€ в результате щелчка на кнопке ExpandButton
  //varTaskDialog.Execute;                                                        //выводим окно
end;

end.
