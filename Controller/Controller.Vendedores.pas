unit Controller.Vendedores;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  DataSet.Serialize;


  procedure Registry;
  procedure GetVendedores(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure GetVendedor(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses Model.Vendedores;

procedure GetVendedores(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Vendedores: TVendedores;
  QRY: TFDQuery;
  Erro: String;
  ArrayVendedores: TJSONArray;
begin

  try
    Vendedores := TVendedores.Create;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

  try
    QRY := Vendedores.Get('', Erro);
    if QRY.RecordCount > 0 then
      begin
        QRY := Vendedores.Get('', Erro);
        ArrayVendedores := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayVendedores);
      end
    else
      begin
        Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
      end;
  finally
    QRY.Free;
    Vendedores.Free;
  end;
end;

procedure GetVendedor(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Vendedores: TVendedores;
  QRY: TFDQuery;
  Erro: String;
  ArrayVendedores: TJSONArray;
begin

  try
    Vendedores := TVendedores.Create;
    Vendedores.CodUsur := Req.Params['CodUsur'].ToUpper;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

  try
    QRY := Vendedores.Get('', Erro);
    if QRY.RecordCount > 0 then
      begin
        QRY := Vendedores.Get('', Erro);
        ArrayVendedores := Qry.ToJSONArray();
        Res.Send<TJSONArray>(ArrayVendedores);
      end
    else
      begin
         Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
      end;
  finally
    QRY.Free;
    Vendedores.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('vendedores/v1/', GetVendedores);
  THorse.Get('vendedores/v1/:codusur', GetVendedor);
end;

end.
