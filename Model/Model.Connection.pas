unit Model.Connection;

interface

uses
FireDAC.DApt,
  FireDAC.Stan.Option,
  FireDAC.Stan.Intf,
  FireDAC.UI.Intf,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDaC.Phys.Oracle,
  FireDAC.Phys.OracleDef,
  System.Classes,
  System.IniFiles,
  System.SysUtils;

type
  TConnection = class
    private
      FDC: TFDConnection;

    public
      constructor Create;
      Destructor Destroy; override;
      function Connect: TFDConnection;
      procedure Disconnect;

  end;

implementation

{ TConnection }

function TConnection.Connect: TFDConnection;
var
  IniConfigFile: String;
  IniFile: TIniFile;
begin
  IniConfigFile := GetCurrentDir + '\config.ini';
  if not FileExists(IniConfigFile) then
    raise Exception.Create('Arquivo .ini não localizado: '+ IniConfigFile);

  IniFile := TIniFile.Create(IniConfigFile);

  try
    FDC.Params.Values['DRIVERID'] := IniFile.ReadString('AFSIS.API.WINTHOR', 'DRIVERID', '');
    FDC.Params.Values['DATABASE'] := IniFile.ReadString('AFSIS.API.WINTHOR', 'DATABASE', '');
    FDC.Params.Values['USER_NAME'] := IniFile.ReadString('AFSIS.API.WINTHOR', 'USER_NAME', '');
    FDC.Params.Values['PASSWORD'] := IniFile.ReadString('AFSIS.API.WINTHOR', 'PASSWORD', '');
    FDC.Params.Values['PORT'] := IniFile.ReadString('AFSIS.API.WINTHOR', 'PORT', '');
    FDC.Params.Values['SERVER'] := IniFile.ReadString('AFSIS.API.WINTHOR', 'SERVER', '');

    FDC.Connected := True;
    Result := FDC;
  finally
    IniFile.Free;
  end;
end;

constructor TConnection.Create;
begin
  inherited Create;
  FDC := TFDConnection.Create(nil);
end;

destructor TConnection.Destroy;
begin
  Disconnect;
  FDC.Free;
  inherited Destroy;
end;

procedure TConnection.Disconnect;
begin
  if Assigned(FDC) and FDC.Connected then
    FDC.Connected := False;
end;

end.
