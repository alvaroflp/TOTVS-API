unit Controller.Filiais;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  FireDAC.Comp.Client,
  Data.DB,
  DataSet.Serialize;

procedure Registry;
procedure GetFiliais(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetFilial(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses Model.Filiais;

procedure GetFiliais(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Filiais: TFiliais;
  QRY: TFDQuery;
  Erro: String;
  ArrayFiliais: TJSONArray;
begin

  try
    Filiais := TFiliais.Create;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

  try
    QRY := Filiais.Get('', Erro);
      if QRY.RecordCount >  0 then
      begin
        QRY := Filiais.Get('', Erro);
        ArrayFiliais := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayFiliais);
      end
      else
        begin
          Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
        end;
  finally
    QRY.Free;
    Filiais.Free;
  end;

end;

procedure GetFilial(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Filiais: TFiliais;
  QRY: TFDQuery;
  Erro: String;
  ArrayFiliais: TJSONArray;
begin

  try
    Filiais := TFiliais.Create;
    Filiais.Codcli := Req.Params['Codigo'].ToUpper;
  except
    if Res.Status = 401 then
      Res.Send('Falha na autenticação')
    else if Res.Status = 500 then
      Res.Send('Erro ao conectar no banco de dados');
    exit;
  end;

 try
    QRY := Filiais.Get('', Erro);
      if QRY.RecordCount >  0 then
      begin
        QRY := Filiais.Get('', Erro);
        ArrayFiliais := QRY.ToJSONArray();
        Res.Send<TJSONArray>(ArrayFiliais);
      end
      else
        begin
          Res.Send('Não foi possível encontrar o recurso solicitado. Verifique a consulta SQL').Status(404);
        end;
  finally
    QRY.Free;
    Filiais.Free;
  end;

end;

procedure Registry;
begin
  THorse.Get('filiais/v1/', GetFiliais);
  THorse.Get('filiais/v1/:codigo', GetFIlial);
end;
end.
