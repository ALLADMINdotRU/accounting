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
  result.MainIcon      := varErrMessage.varTaskIcon;                     //��������� ������
  result.Text          := varErrMessage.varMessage;                      //��������� ����� ������
  result.CommonButtons := varErrMessage.varButton;                       //��������� ������
  result.ExpandedText  := varErrMessage.errMessage;                      //��������� ���������� ����� ������������ � ���������� ������ �� ������ ExpandButton
  //varTaskDialog.Execute;                                                        //������� ����
end;

end.
