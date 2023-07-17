unit Model.Fornecedores;

interface

uses
  FireDAC.Comp.Client,
  Data.DB,
  System.SysUtils;

type
  TFornecedores = class
    private

    public
      constructor Create;
      destructor Destroy; override;
      function Get(OrderBy: String; Out Error: String): TFDQuery;
      //property

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
        Error := 'Error ao realizar consulta no banco de dados' + sLineBreak + e.Message;
        Result := nil;
      end;
  end;

end;

end.
