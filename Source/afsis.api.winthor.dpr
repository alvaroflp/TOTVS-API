program afsis.api.winthor;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Compression,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  System.JSON,
  System.Classes,
  System.SysUtils,
  Model.Connection in '..\Model\Model.Connection.pas',
  Model.Clientes in '..\Model\Model.Clientes.pas',
  Controller.Clientes in '..\Controller\Controller.Clientes.pas';

const
    VersionAPI = '1.0.0';
    FUser = 'afsis';
    FPswd = 'af$1s';

begin
{$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
{$ELSE}
  ReportMemoryLeaksOnShutdown := False;
{$ENDIF}

  THorse.MaxConnections := 250;

  THorse
    .Use(HorseBasicAuthentication(
      function(const AUsername, APassword: string): Boolean
      begin
        Result := AUsername.Equals(FUser) and APassword.Equals(FPswd);
      end))
    .Use(Compression())
    .Use(Jhonson());

  Controller.Clientes.Registry;

  THorse.Listen(9000,
    procedure(Horse: THorse)
    begin
    {$IFDEF DEBUG}
      WriteLn('Vers�o em modo *** DEBUG ***');
      WriteLn('Build: Delphi and C++ Builder Architect 11 Update 3 [Alexandria]');
      WriteLn('Autor: �lvaro Felipe');
      WriteLn('Projeto: afsis.api.winthor');
      WriteLn(Format('Credenciais de uso: Usu�rio: %s, Senha: %s', [FUser, FPswd]));
      WriteLn('Source: github.com/alvaroflp');
      WriteLn(Format('afsis.api.winthor ouvindo a porta %d vers�o: %s',
        [THorse.Port, VersionAPI]));

    {$ELSE}
      WriteLn('Vers�o em modo *** RELEASE ***');
      WriteLn('Build: Delphi and C++ Builder Architect 11 Update 3 [Alexandria]');
      WriteLn('Autor: �lvaro Felipe');
      WriteLn('Projeto: afsis.api.winthor');
      WriteLn(Format('Credenciais de uso: Usu�rio: %s, Senha: %s', [FUser, FPswd]));
      WriteLn('Source: github.com/alvaroflp');
      WriteLn(Format('afsis.api.winthor ouvindo a porta %d vers�o: %s',
        [THorse.Port, VersionAPI]));
    {$ENDIF}

      Readln
    end);


end.