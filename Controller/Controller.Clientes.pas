unit Controller.Clientes;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  DataSet.Serialize;

procedure Registry;
procedure GetClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses Model.Clientes;

procedure GetClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Clientes: TClientes;
  QRY: TFDQuery;
  Erro: String;
  ArrayClientes: TJSONArray;
begin

  try
    Clientes := TClientes.Create;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

  try
    QRY := Clientes.Get('', Erro);
      if QRY.RecordCount >  0 then
      begin
        QRY := Clientes.Get('', Erro);
        ArrayClientes := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayClientes);
      end
      else
        begin
          Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
        end;
  finally
    QRY.Free;
    Clientes.Free;
  end;

end;

procedure GetCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Clientes: TClientes;
  QRY: TFDQuery;
  Erro: String;
  ArrayClientes: TJSONArray;
begin

  try
    Clientes := TClientes.Create;
    Clientes.Codcli := Req.Params['CodCli'].ToUpper;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

 try
    QRY := Clientes.Get('', Erro);
      if QRY.RecordCount >  0 then
      begin
        QRY := Clientes.Get('', Erro);
        ArrayClientes := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayClientes);
      end
      else
        begin
          Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
        end;
  finally
    QRY.Free;
    Clientes.Free;
  end;

end;

procedure Registry;
begin
  THorse.Get('clientes/v1/', GetClientes);
  THorse.Get('clientes/v1/:codcli', GetCliente);
end;
end.
