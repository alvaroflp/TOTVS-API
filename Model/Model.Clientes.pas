unit Model.Clientes;

interface

uses
  FireDAC.Comp.Client,
  Data.DB,
  System.SysUtils;

type
  TClientes = class
      private
        FLongitute: string;
        FEmailNFe: string;
        FCepCob: string;
        FObs: string;
        FDtCadastro: string;
        FNumeroCob: string;
        FFantasia: string;
        FLatitude: string;
        FMunicCob: string;
        FCodUsurEcommerce: string;
        FDtVencLimCred: string;
        FCodPraca: string;
        FEmail: string;
        FDtBloq: string;
        FCodPlPag: string;
        FTipoFJ: string;
        FLimCred: string;
        FDtRegLim: string;
        FCodcli: string;
        FCGCEnt: string;
        FCodMunicipio: string;
        FCodCob: string;
        FAceitaVendaFracao: string;
        FDtPrimCompra: string;
        FCodcliPrinc: string;
        FConsumidorFinal: string;
        FDtUltComp: string;
        FCodATV1: string;
        FEnderCob: string;
        FEstCob: string;
        FMotivoExclusao: string;
        FBairroCob: string;
        FCodcliweb: string;
        FContribuinte: string;
        FDtExclusao: string;
        FCodUsur2: string;
        FCodUsur3: string;
        FBloqueio: string;
        FCodUsur1: string;
        FIEEnt: string;
    FLongitude: string;

      public
        constructor Create;
        destructor Destroy; override;
        function Get(OrderBy: String; Out Error: String): TFDQuery;
        property Codcli: string read FCodcli write FCodcli;
        property CodcliPrinc: string read FCodcliPrinc write FCodcliPrinc;
        property CodcliWeb: string read FCodcliweb write FCodcliweb;
        property Fantasia: string read FFantasia write FFantasia;
        property CGCEnt: string read FCGCEnt write FCGCEnt;
        property TipoFJ: string read FTipoFJ write FTipoFJ;
        property IEEnt: string read FIEEnt write FIEEnt;
        property Email: string read FEmail write FEmail;
        property EmailNFe: string read FEmailNFe write FEmailNFe;
        property CodATV1: string read FCodATV1 write FCodATV1;
        property EstCob: string read FEstCob write FEstCob;
        property CodMunicipio: string read FCodMunicipio write FCodMunicipio;
        property MunicCob: string read FMunicCob write FMunicCob;
        property EnderCob: string read FEnderCob write FEnderCob;
        property BairroCob: string read FBairroCob write FBairroCob;
        property NumeroCob: string read FNumeroCob write FNumeroCob;
        property CepCob: string read FCepCob write FCepCob;
        property Latitude: string read FLatitude write FLatitude;
        property Longitute: string read FLongitude write FLongitude;
        property CodPraca: string read FCodPraca write FCodPraca;
        property DtExclusao: string read FDtExclusao write FDtExclusao;
        property MotivoExclusao: string read FMotivoExclusao write FMotivoExclusao;
        property DtCadastro: string read FDtCadastro write FDtCadastro;
        property DtPrimCompra: string read FDtPrimCompra write FDtPrimCompra;
        property DtUltComp: string read FDtUltComp write FDtUltComp;
        property LimCred: string read FLimCred write FLimCred;
        property DtRegLim: string read FDtRegLim write FDtRegLim;
        property DtVencLimCred: string read FDtVencLimCred write FDtVencLimCred;
        property CodCob: string read FCodCob write FCodCob;
        property CodPlPag: string read FCodPlPag write FCodPlPag;
        property DtBlog: string read FDtBloq write FDtBloq;
        property Bloqueio: string read FBloqueio write FBloqueio;
        property Obs: string read FObs write FObs;
        property CodUsur1: string read FCodUsur1 write FCodUsur1;
        property CodUsur2: string read FCodUsur2 write FCodUsur2;
        property CodUsur3: string read FCodUsur3 write FCodUsur3;
        property CodUsurEcommerce: string read FCodUsurEcommerce write FCodUsurEcommerce;
        property Contribuinte: string read FContribuinte write FContribuinte;
        property ConsumidorFinal: string read FConsumidorFinal write FConsumidorFinal;
        property AceitaVendaFracao: string read FAceitaVendaFracao write FAceitaVendaFracao;

      protected

      published

  end;

implementation

uses Model.Connection;

{ TClientes }

constructor TClientes.Create;
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

destructor TClientes.Destroy;
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

function TClientes.Get(OrderBy: String; out Error: String): TFDQuery;
var
  FDC: TConnection;
  QRY: TFDQuery;
begin
  try
    FDC := TConnection.Create;
    QRY := TFDQuery.Create(nil);

    QRY.Connection := FDC.Connect;
    QRY.SQL.Text :=
      ' SELECT C.CODCLI, ' +
      ' C.CODCLIPRINC, ' +
      ' C.CODCLIWEB, ' +
      ' C.CLIENTE, ' +
      ' C.FANTASIA, ' +
      ' REPLACE(REPLACE(REPLACE(C.CGCENT, ''.'', ''''), ''-'', ''''), ''/'', '''') CGCENT, ' +
      ' C.TIPOFJ, ' +
      ' C.IEENT, ' +
      ' C.EMAIL, ' +
      ' C.EMAILNFE, ' +
      ' C.CODATV1, ' +
      ' C.ESTCOB, ' +
      ' C.CODMUNICIPIO, ' +
      ' C.MUNICCOB, ' +
      ' C.ENDERCOB, ' +
      ' C.BAIRROCOB, ' +
      ' C.NUMEROCOB, ' +
      ' C.CEPCOB, ' +
      ' C.LATITUDE, ' +
      ' C.LONGITUDE, ' +
      ' C.CODPRACA, ' +
      ' TO_CHAR(C.DTEXCLUSAO, ''DD-MM-RRRR'') DTEXCLUSAO, ' +
      ' C.MOTIVOEXCLUSAO, ' +
      ' TO_CHAR(C.DTCADASTRO, ''DD-MM-RRRR'') DTCADASTRO, ' +
      ' TO_CHAR(C.DTPRIMCOMPRA, ''DD-MM-RRRR'') DTPRIMCOMPRA, ' +
      ' TO_CHAR(C.DTULTCOMP, ''DD-MM-RRRR'') DTULTCOMP, ' +
      ' C.LIMCRED, ' +
      ' TO_CHAR(C.DTREGLIM, ''DD-MM-RRRR'') DTREGLIM, ' +
      ' TO_CHAR(C.DTVENCLIMCRED, ''DD-MM-RRRR'') DTVENCLIMCRED, ' +
      ' C.CODCOB, ' +
      ' C.CODPLPAG, ' +
      ' TO_CHAR(C.DTBLOQ, ''DD-MM-RRRR'') DTBLOQ, ' +
      ' C.BLOQUEIO, ' +
      ' C.OBS, ' +
      ' C.CODUSUR1, ' +
      ' C.CODUSUR2, ' +
      ' C.CODUSUR3, ' +
      ' C.CODUSURECOMMERCE, ' +
      ' C.CONTRIBUINTE, ' +
      ' C.CONSUMIDORFINAL, ' +
      ' C.ACEITAVENDAFRACAO ' +
      ' FROM PCCLIENT C ' +
      ' WHERE 1 = 1 ';

    if Codcli <> '' then
      begin
        QRY.SQL.Add('AND C.CODCLI = :CODCLI');
        QRY.ParamByName('CODCLI').Value := CodCli;
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
