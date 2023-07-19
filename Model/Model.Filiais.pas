unit Model.Filiais;

interface

uses
  FireDAC.Comp.Client,
  Data.DB,
  System.SysUtils;

type
  TFiliais = class
    private
    FDtViradaRF: string;
    FDtUtilizaNFe: string;
    FFantasia: string;
    FEmail: string;
    FBairro: string;
    FNumero2: string;
    FCodCLi: string;
    FUF: string;
    FString: string;
    FDtRegistro: string;
    FNumero: string;
    FIE: string;
    FEndereco: string;
    FRazaoSocial: string;
    FDtFimAtividade: string;
    FOrgao: string;
    FCodNaturezaJuridica: string;
    FAtividade: string;
    FCodCNAEFiscal: string;
    FCodFornec: string;
    FUsaWMS: string;
    FUsaRFWinThor: string;
    FCidade: string;
    FCodRegistro: string;
    FCGC: string;

    public
      constructor Create;
      destructor Destroy; override;
      function Get(OrderBy: String; Out Error: String): TFDQuery;
      property Codigo: string read FString write FString;
      property CodCli: string read FCodCLi write FCodCli;
      property CodFornec: string read FCodFornec write FCodFornec;
      property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
      property Fantasia: string read FFantasia write FFantasia;
      property UF: string read FUF write FUF;
      property CGC: string read FCGC write FCGC;
      property IE: string read FIE write FIE;
      property CodRegistro: string read FCodRegistro write FCodRegistro;
      property Orgao: string read FOrgao write FOrgao;
      property DtRegistro: string read FDtRegistro write FDtRegistro;
      property CodNaturezaJuridica: string read FCodNaturezaJuridica write FCodNaturezaJuridica;
      property CodCNAEFiscal: string read FCodCNAEFiscal write FCodCNAEFiscal;
      property Atividade: string read FAtividade write FAtividade;
      property DtFimAtividade: string read FDtFimAtividade write FDtFimAtividade;
      property DtUtilizaNFe: string read FDtUtilizaNFe write FDtUtilizaNFe;
      property Cidade: string read FCidade write FCidade;
      property Endereco: string read FEndereco write FEndereco;
      property ComplementoEndereco: string read FEndereco write FEndereco;
      property Bairro: string read FBairro write FBairro;
      property Numero: string read FNumero write FNumero;
      property Numero2: string read FNumero2 write FNumero2;
      property Email: string read FEmail write FEmail;
      property UsaWMS: string read FUsaWMS write FUsaWMS;
      property UsaRFWinthor: string read FUsaRFWinThor write FUsaRFWinThor;
      property DtViradaRF: string read FDtViradaRF write FDtViradaRF;
end;

implementation

uses Model.Connection;

{ TFiliais }

constructor TFiliais.Create;
var
  FDC: TConnection;
begin
  inherited Create;
  try
    FDC := TConnection.Create;
  finally
    FDC.Connect;
  end;
end;

destructor TFiliais.Destroy;
var
  FDC: TConnection;
begin
  try
    FDC := TConnection.Create;
  finally
    FDC.Disconnect;
  end;
  inherited;
end;

function TFiliais.Get(OrderBy: String; out Error: String): TFDQuery;
var
  FDC: TConnection;
  QRY: TFDQuery;
begin
  try
    FDC := TConnection.Create;
    QRY := TFDQuery.Create(nil);

    QRY.Connection := FDC.Connect;
    QRY.SQL.Text :=
    ' SELECT F.CODIGO, ' +
    '        F.CODCLI, ' +
    '        F.CODFORNEC, ' +
    '        F.RAZAOSOCIAL, ' +
    '        F.FANTASIA, ' +
    '        F.UF, ' +
    '        F.CGC, ' +
    '        F.IE, ' +
    '        F.CODREGISTRO, ' +
    '        F.ORGAO, ' +
    '        TO_CHAR(F.DTREGISTRO, ''DD-MM-RRRR'') DTREGISTRO, ' +
    '        F.CODNATUREZAJURIDICA, ' +
    '        F.CODCNAEFISCAL, ' +
    '        F.ATIVIDADE, ' +
    '        TO_CHAR(F.DTFIMATIVIDADE, ''DD-MM-RRRR'') DTFIMATIVIDADE, ' +
    '        TO_CHAR(F.DTUTILIZANFE, ''DD-MM-RRRR'') DTUTILIZANFE, ' +
    '        F.CIDADE, ' +
    '        F.ENDERECO, ' +
    '        F.COMPLEMENTOENDERECO, ' +
    '        F.BAIRRO, ' +
    '        F.NUMERO, ' +
    '        F.NUMERO2, ' +
    '        F.EMAIL, ' +
    '        F.USAWMS,  ' +
    '        F.USARFWINTHOR, ' +
    '        TO_CHAR(F.DTVIRADARF, ''DD-MM-RRRR'') DTVIRADANF ' +
    '   FROM PCFILIAL F ' +
    '   WHERE 1 = 1 ';

    if Codigo <> '' then
      begin
        QRY.SQL.Add('AND F.CODIGO = :CODIGO');
        QRY.ParamByName('CODIGO').Value := Codigo;
      end;

    QRY.Open();
    Error := '';

    Result := QRY;

  except
    on e: exception do
      begin
        Error := 'Error ao realizar consulta no banco de dados' + sLineBreak + e.Message;
        Result := nil;
      end;
  end;
end;

end.
