unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Imaging.pngimage;

type
  TFrmPrincipal = class(TForm)
    imgLogoViaCEP: TImage;
    pnlTop: TPanel;
    btnConsultar: TButton;
    mmLog: TMemo;
    edCEP: TLabeledEdit;
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    function SomenteNumeros(const pValor: string): string;
    procedure ConsultarCEP(const pCEP: string);
    procedure Log(const pMensagem: string);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  UViaCEP.Intf,
  UViaCEP.Impl;

{ TFrmPrincipal }

function TFrmPrincipal.SomenteNumeros(const pValor: string) : string;
var
  lI : Integer;
begin
  Result := '';

  for lI := 1 to Length(pValor) do
  begin
    if pValor[lI] in ['0'..'9'] then
      Result := Result + pValor[lI];
  end;
end;

procedure TFrmPrincipal.btnConsultarClick(Sender: TObject);
var
  lCEP: string;
begin
  lCEP := SomenteNumeros(edCEP.Text);
  ConsultarCEP(lCEP);
end;

procedure TFrmPrincipal.ConsultarCEP(const pCEP: string);
var
  lViaCep: IViaCEP;
  lCEP: ICEP;
  lMensagem: string;
begin
  if pCEP <> '' then
  begin
    lViaCep := TViaCEP.Create;
    lCEP := lViaCep.ConsultarCEP(pCEP);
    lMensagem := 'Logradouro: ' + lCEP.Logradouro + sLineBreak +
      'Bairro: ' + lCEP.Bairro + sLineBreak +
      'Localidade: ' + lCEP.Localidade + sLineBreak +
      'UF: ' + lCEP.UF;
    Log(lMensagem);
  end else
  begin
    ShowMessage('Digite um CEP para poder realizar a consulta!');
  end;
end;

procedure TFrmPrincipal.Log(const pMensagem: string);
begin
  mmLog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm', now) + ' - ' + pMensagem);
end;

end.
