unit UViaCEP.Intf;

interface

type
  ICEP = interface
    ['{414334FB-A9A4-4E18-BE4C-318A944AA9A3}']

    function GetLogradouro: string;
    procedure SetLogradouro(const pValor: string);
    function GetBairro: string;
    procedure SetBairro(const pValor: string);
    function GetLocalidade: string;
    procedure SetLocalidade(const pValor: string);
    function GetUF: string;
    procedure SetUF(const pValor: string);

    property Logradouro: string read GetLogradouro write SetLogradouro;
    property Bairro: string read GetBairro write SetBairro;
    property Localidade: string read GetLocalidade write SetLocalidade;
    property UF: string read GetUF write SetUF;
  end;

  IViaCEP = interface
    ['{66CEE56F-40FB-4F16-8E13-104234C386DF}']

    function ConsultarCEP(const pCEP: string): ICEP;
  end;

implementation

end.
