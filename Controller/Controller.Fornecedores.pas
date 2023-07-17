unit Controller.Fornecedores;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  DataSet.Serialize;

procedure Registry;
procedure GetFornecedores(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetFornecedor(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses Model.Fornecedores;

procedure GetFornecedores(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Fornecedores: TFornecedores;
  QRY: TFDQuery;
  Erro: String;
  ArrayFornecedores: TJSONArray;
begin

  try
    Fornecedores := TFornecedores.Create;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

  try
    QRY := Fornecedores.Get('', Erro);
      if QRY.RecordCount >  0 then
      begin
        QRY := Fornecedores.Get('', Erro);
        ArrayFornecedores := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayFornecedores);
      end
      else
        begin
          Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
        end;
  finally
    QRY.Free;
    Fornecedores.Free;
  end;
end;

procedure GetFornecedor(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Fornecedores: TFornecedores;
  QRY: TFDQuery;
  Erro: String;
  ArrayFornecedores: TJSONArray;
begin

  try
    Fornecedores := TFornecedores.Create;
    Fornecedores.CodFornec := Req.Params['CodFornec'].ToUpper;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

 try
    QRY := Fornecedores.Get('', Erro);
      if QRY.RecordCount >  0 then
      begin
        QRY := Fornecedores.Get('', Erro);
        ArrayFornecedores := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayFornecedores);
      end
      else
        begin
          Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
        end;
  finally
    QRY.Free;
    Fornecedores.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('fornecedores/v1/', GetFornecedores);
  THorse.Get('fornecedores/v1/:codcli', GetFornecedor);
end;

end.
