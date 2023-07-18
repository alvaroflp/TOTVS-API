unit Model.Vendedores;

interface

uses
  FireDAC.Comp.Client,
  Data.DB,
  System.SysUtils;

type
  TVendedores = class
    private
    FPraca2: string;
    FCodUsur: string;
    FUsaDebCredRCA: string;
    FEmail: string;
    FBairro: string;
    FCPFAux: string;
    FPraca1: string;
    FCI: string;
    FUsurFTP: string;
    FCPF: string;
    FDtUltVenda: string;
    FTipoComissao: string;
    FSenhaFTP: string;
    FTelefone2: string;
    FTipoVend: string;
    FDtNasc: string;
    FTelefone1: string;
    FDtTermino: string;
    FNome: string;
    FBloqueio: string;
    FCidade: string;
    FCodFilial: string;
    FEndereco: string;
    FCodSupervidor: string;
    FAreaAtuacao: string;
    FEstado: string;
    FDtInicio: string;
    FCodSupervisor: string;

    public
      constructor Create;
      destructor Destroy; override;
      function Get(OrderBy: String; Out Error: String): TFDQuery;
      property CodFilial: string read FCodFilial write FCodFilial;
      property CodSupervisor: string read FCodSupervisor write FCodSupervisor;
      property CodUsur: string read FCodUsur write FCodUsur;
      property Nome: string read FNome write FNome;
      property CPF: string read FCPF write FCPF;
      property CPFAux: string read FCPFAux write FCPFAux;
      property CI: string read FCI write FCI;
      property TipoVend: string read FTipoVend write FTipoVend;
      property Telefone1: string read FTelefone1 write FTelefone1;
      property Telefone2: string read FTelefone2 write FTelefone2;
      property Estado: string read FEstado write FEstado;
      property Cidade: string read FCidade write FCidade;
      property Endereco: string read FEndereco write FEndereco;
      property Bairro: string read FBairro write FBairro;
      property Email: string read FEmail write FEmail;
      property Bloqueio: string read FBloqueio write FBloqueio;
      property DtInicio: string read FDtInicio write FDtInicio;
      property DtTermino: string read FDtTermino write FDtTermino;
      property DtNasc: string read FDtNasc write FDtNasc;
      property DtUltVenda: string read FDtUltVenda write FDtUltVenda;
      property AreaAtuacao: string read FAreaAtuacao write FAreaAtuacao;
      property TipoComissao: string read FTipoComissao write FTipoComissao;
      property UsaDebCredRCA: string read FUsaDebCredRCA write FUsaDebCredRCA;
      property UsurFTP: string read FUsurFTP write FUsurFTP;
      property SenhaFTP: string read FSenhaFTP write FSenhaFTP;
      property Praca1: string read FPraca1 write FPraca1;
      property Praca2: string read FPraca2 write FPraca2;

  end;

implementation

uses Model.Connection;

{ TVendedores }

constructor TVendedores.Create;
var
  FDC: TConnection;
begin
  inherited Create;
  try
    FDC := TConnection.Create;
  finally
    FDC.Connect;
  end
end;

destructor TVendedores.Destroy;
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

function TVendedores.Get(OrderBy: String; out Error: String): TFDQuery;
var
  FDC: TConnection;
  QRY: TFDQuery;
begin
  try
    FDC := TConnection.Create;
    QRY := TFDQuery.Create(nil);

    QRY.Connection := FDC.Connect;
    QRY.SQL.Text :=
        ' SELECT U.CODFILIAL,  ' +
        '        U.CODSUPERVISOR,  ' +
        '        U.CODUSUR, ' +
        '        U.NOME, ' +
        '        U.CPF, ' +
        '        U.CPFAUX, ' +
        '        U.CI, ' +
        '        U.TIPOVEND, ' +
        '        U.TELEFONE1, ' +
        '        U.TELEFONE2, ' +
        '        U.ESTADO, ' +
        '        U.CIDADE, ' +
        '        U.ENDERECO, ' +
        '        U.BAIRRO, ' +
        '        U.EMAIL,  ' +
        '        U.BLOQUEIO, ' +
        '        TO_CHAR(U.DTINICIO, ''DD-MM-RRRR'') DTINICIO, ' +
        '        TO_CHAR(U.DTTERMINO, ''DD-MM-RRRR'') DTTERMINO, ' +
        '        TO_CHAR(U.DTNASC, ''DD-MM-RRRR'') DTNASC, ' +
        '        TO_CHAR(U.DTULTVENDA, ''DD-MM-RRRR'') DTULTVENDA,  ' +
        '        U.AREAATUACAO,  ' +
        '        U.TIPOCOMISSAO,  ' +
        '        U.USADEBCREDRCA,  ' +
        '        U.USURFTP, ' +
        '        U.SENHAFTP, ' +
        '        U.PRACA1,  ' +
        '        U.PRACA2 ' +
        '   FROM PCUSUARI U ' +
        '   WHERE 1 = 1 ';

    if CodUsur <> '' then
      begin
        QRY.SQL.Add('AND U.CODUSUR = :CODUSUR');
        QRY.ParamByName('CODUSUR').Value :=  CodUsur;
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
