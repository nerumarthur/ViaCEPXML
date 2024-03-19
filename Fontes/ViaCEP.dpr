program ViaCEP;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UViaCEP.Intf in 'Interfaces\UViaCEP.Intf.pas',
  UViaCEP.Impl in 'Implementacoes\UViaCEP.Impl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
