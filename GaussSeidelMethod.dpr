program GaussSeidelMethod;

uses
  Vcl.Forms,
  gauss_seidel_method in 'gauss_seidel_method.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
