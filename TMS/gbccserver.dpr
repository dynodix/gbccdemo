program gbccserver;

uses
  Vcl.Forms,
  ServerUnit1 in 'ServerUnit1.pas' {ServerContainer: TDataModule},
  ServerUnit2 in 'ServerUnit2.pas' {MainForm},
  gbccentities in 'gbccentities.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
