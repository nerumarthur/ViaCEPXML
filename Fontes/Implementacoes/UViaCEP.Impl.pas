unit UViaCEP.Impl;

interface

uses
  UViaCEP.Intf;

type
  TCEP = class(TInterfacedObject, ICEP)
  strict private
    FLogradouro: string;
    FBairro: string;
    FLocalidade: string;
    FUF: shortstring;
  strict protected
    function GetLogradouro: string;
    procedure SetLogradouro(const pValor: string);
    function GetBairro: string;
    procedure SetBairro(const pValor: string);
    function GetLocalidade: string;
    procedure SetLocalidade(const pValor: string);
    function GetUF: string;
    procedure SetUF(const pValor: string);
  end;
  
  TViaCEP = class(TInterfacedObject, IViaCEP)
  strict private const
    URL_API = 
      'http://viacep.com.br/ws/';
  strict protected
    function ConsultarCEP(const pCEP: string): ICEP;   
  end;

implementation

uses
  System.SysUtils,
  xmldom, 
  XMLIntf, 
  StdCtrls, 
  msxmldom, 
  XMLDoc,
  IdSSLOpenSSL;

{ TCEP }

function TCEP.GetBairro: string;
begin
  Result := FBairro;
end;

function TCEP.GetLocalidade: string;
begin
  Result := FLocalidade;
end;

function TCEP.GetLogradouro: string;
begin
  Result := FLogradouro;
end;

function TCEP.GetUF: string;
begin
  Result := FUF;
end;

procedure TCEP.SetBairro(const pValor: string);
begin
  FBairro := pValor;
end;

procedure TCEP.SetLocalidade(const pValor: string);
begin
  FLocalidade := pValor;
end;

procedure TCEP.SetLogradouro(const pValor: string);
begin
  FLogradouro := pValor;
end;

procedure TCEP.SetUF(const pValor: string);
begin
  FUF := pValor;
end;

{ TViaCEP }

function TViaCEP.ConsultarCEP(const pCEP: string): ICEP;
var
  lXmlCep: TXMLDocument;
  lSSLIO: TIdSSLIOHandlerSocketOpenSSL;
  lTempXML: IXMLNode;
  lTempNodePAI: IXMLNode;
  lTempNodeFilho: IXMLNode;
  lI: UInt32;
begin
  Result := TCEP.Create;
  lXmlCep := TXMLDocument.Create(nil);
  try
    try
    lXmlCep.FileName := URL_API + pCEP + '/xml/';
    lXmlCep.Active := True;

    lTempXML := lXmlCep.DocumentElement;
    lTempNodePAI := lTempXML.ChildNodes.FindNode('logradouro');
    
    for lI := 0 to lTempNodePAI.ChildNodes.Count - 1 do
    begin
      lTempNodeFilho := lTempNodePAI.ChildNodes[lI];
      Result.Logradouro := lTempNodeFilho.Text;
    end;

    lTempNodePAI := lTempXML.ChildNodes.FindNode('bairro');
    for lI := 0 to lTempNodePAI.ChildNodes.Count - 1 do
    begin
      lTempNodeFilho := lTempNodePAI.ChildNodes[lI];
      Result.Bairro := lTempNodeFilho.Text;
    end;


    lTempNodePAI := lTempXML.ChildNodes.FindNode('localidade');
    for lI := 0 to lTempNodePAI.ChildNodes.Count - 1 do
    begin
      lTempNodeFilho := lTempNodePAI.ChildNodes[lI];
      Result.Localidade := lTempNodeFilho.Text;
    end;


    lTempNodePAI := lTempXML.ChildNodes.FindNode('uf');
    for lI := 0 to lTempNodePAI.ChildNodes.Count - 1 do
    begin
      lTempNodeFilho := lTempNodePAI.ChildNodes[lI];
      Result.UF := lTempNodeFilho.Text;
    end;
    except
      on E: Exception do
        raise Exception.Create('Erro ao Consultar: ' + E.Message);
    end;
  finally
    lXmlCep.Active := False;
  end;
end;

end.
