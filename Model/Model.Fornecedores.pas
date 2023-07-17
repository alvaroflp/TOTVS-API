unit Model.Fornecedores;

interface

uses
  FireDAC.Comp.Client,
  Data.DB,
  System.SysUtils;

type
  TFornecedores = class
    private
    FNumBancoDoc: string;
    FTipoPessoa: string;
    FContribuinteICMS: string;
    FDtCadastro: string;
    FTelCob: string;
    FEnder: string;
    FFantasia: string;
    FPrazo2: string;
    FPrazo3: string;
    FEmail: string;
    FBairro: string;
    FDtBloqueio: string;
    FPrazo1: string;
    FPrazo6: string;
    FRevenda: string;
    FCodCli: string;
    FEstrategio: string;
    FPrazo4: string;
    FPrazo5: string;
    FTelFab: string;
    FCodComprador: string;
    FTelRep: string;
    FNumeroEnd: string;
    FIE: string;
    FSuframa: string;
    FConsumidorFinal: string;
    FCodCidade: string;
    FCGCAux: string;
    FFornecedor: string;
    FCodFornecPrinc: string;
    FPrazoEntrega: string;
    FCodFornec: string;
    FDtExclusao: string;
    FNumAgenciaDoc: string;
    FTipoFornec: string;
    FBloqueio: string;
    FCidade: string;
    FCGC: string;
    FEstado: string;
    FEstrategico: string;

    public
      constructor Create;
      destructor Destroy; override;
      function Get(OrderBy: String; Out Error: String): TFDQuery;
      property CodFornec: string read FCodFornec write FCodFornec;
      property CodFornecPrinc: string read FCodFornecPrinc write FCodFornecPrinc;
      property CodCli: string read FCodCli write FCodCli;
      property Fornecedor: string read FFornecedor write FFornecedor;
      property Fantasia: string read FFantasia write FFantasia;
      property TipoPessoa: string read FTipoPessoa write FTipoPessoa;
      property CGC: string read FCGC write FCGC;
      property CGCAux: string read FCGCAux write FCGCAux;
      property IE: string read FIE write FIE;
      property Estado: string read FEstado write FEstado;
      property CodCidade: string read FCodCidade write FCodCidade;
      property Cidade: string read FCidade write FCidade;
      property Ender: string read FEnder write FEnder;
      property Bairro: string read FBairro write FBairro;
      property NumeroEnd: string read FNumeroEnd write FNumeroEnd;
      property TelRep: string read FTelRep write FTelRep;
      property TelFab: string read FTelFab write FTelFab;
      property TelCob: string read FTelCob write FTelCob;
      property Revenda: string read FRevenda write FRevenda;
      property TipoFornec: string read FTipoFornec write FTipoFornec;
      property PrazoEntrega: string read FPrazoEntrega write FPrazoEntrega;
      property Bloqueio: string read FBloqueio write FBloqueio;
      property DtBloqueio: string read FDtBloqueio write FDtBloqueio;
      property CodComprador: string read FCodComprador write FCodComprador;
      property DtCadastro: string read FDtCadastro write FDtCadastro;
      property DtExclusao: string read FDtExclusao write FDtExclusao;
      property Estrategico: string read FEstrategico write FEstrategico;
      property Email: string read FEmail write FEmail;
      property Prazo1: string read FPrazo1 write FPrazo1;
      property Prazo2: string read FPrazo2 write FPrazo2;
      property Prazo3: string read FPrazo3 write FPrazo3;
      property Prazo4: string read FPrazo4 write FPrazo4;
      property Prazo5: string read FPrazo5 write FPrazo5;
      property Prazo6: string read FPrazo6 write FPrazo6;
      property NumBancoDoc: string read FNumBancoDoc write FNumBancoDoc;
      property NumAgenciaDoc: string read FNumAgenciaDoc write FNumAgenciaDoc;
      property Suframa: string read FSuframa write FSuframa;
      property ContribuinteICMS: string read FContribuinteICMS write FContribuinteICMS;
      property ConsumidorFinal: string read FConsumidorFinal write FConsumidorFinal;

  end;

implementation

{ TFornecedores }

uses Model.Connection;

constructor TFornecedores.Create;
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

destructor TFornecedores.Destroy;
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

function TFornecedores.Get(OrderBy: String; out Error: String): TFDQuery;
var
  FDC: TConnection;
  QRY: TFDQuery;
begin

  try
    FDC := TConnection.Create;
    QRY := TFDQuery.Create(nil);

    QRY.Connection := FDC.Connect;
    QRY.SQL.Text :=
    ' SELECT F.CODFORNEC, ' +
    '        F.CODCLI, ' +
    '        F.CODFORNECPRINC, ' +
    '        F.FORNECEDOR, ' +
    '        F.FANTASIA, ' +
    '        F.TIPOPESSOA, ' +
    '        F.CGC, ' +
    '        F.CGCAUX, ' +
    '        F.IE, ' +
    '        F.ESTADO, ' +
    '        F.CODCIDADE, ' +
    '        F.CIDADE, ' +
    '        F.ENDER, ' +
    '        F.BAIRRO, ' +
    '        F.NUMEROEND, ' +
    '        F.TELREP, ' +
    '        F.TELFAB, ' +
    '        F.TELCOB, ' +
    '        F.REVENDA, ' +
    '        F.TIPOFORNEC, ' +
    '        F.PRAZOENTREGA, ' +
    '        F.BLOQUEIO, ' +
    '        TO_CHAR(F.DTBLOQUEIO, ''DD-MM-RRRR'') DTBLOQUEIO, ' +
    '        F.CODCOMPRADOR, ' +
    '        TO_CHAR(F.DTCADASTRO, ''DD-MM-RRRR'') DTCADASTRO, ' +
    '        TO_CHAR(F.DTEXCLUSAO, ''DD-MM-RRRR'') DTEXCLUSAO, ' +
    '        F.ESTRATEGICO, ' +
    '        F.EMAIL, ' +
    '        F.PRAZO1, ' +
    '        F.PRAZO2, ' +
    '        F.PRAZO3, ' +
    '        F.PRAZO4, ' +
    '        F.PRAZO5, ' +
    '        F.PRAZO6, ' +
    '        F.NUMBANCODOC, ' +
    '        F.NUMAGENCIADOC, ' +
    '        F.SUFRAMA, ' +
    '        F.CONTRIBUINTEICMS, ' +
    '        F.CONSUMIDORFINAL ' +
    '   FROM PCFORNEC F ' +
    '  WHERE 1 = 1 ';

   if CodFornec <> '' then
        begin
          QRY.SQL.Add('AND F.CODFORNEC = :CODFORNEC');
          QRY.ParamByName('CODFORNEC').Value := CodFornec;
        end;

    QRY.Open();
    Error := '';

    Result := QRY;

  except
    on e: exception do
      begin
        Error := 'Error ao realizar consulta no banco de dados' +
          sLineBreak + e.Message;
        Result := nil;
      end;
  end;

end;

end.
