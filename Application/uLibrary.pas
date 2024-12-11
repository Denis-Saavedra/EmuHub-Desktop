unit uLibrary;

interface

uses
  MyCustomPanel;
Function PegaDiretorio: String;
Function RetornaExtensao(Empresa, Emulador: String): String;
procedure HoverOn(Sender: TMyCustomPanel);
procedure HoverOff(Sender: TMyCustomPanel);

implementation

uses
  System.Win.Registry, Winapi.Windows;

procedure HoverOn(Sender: TMyCustomPanel);
begin
  Sender.BorderEnabled := True;
  Sender.Repaint;
end;

procedure HoverOff(Sender: TMyCustomPanel);
begin
  if Sender.Enabled then
  begin
    Sender.BorderEnabled := False;
  Sender.Repaint;
  end;
end;

Function PegaDiretorio: String;
var
  Reg: TRegistry;
begin
  // Cria a instância do TRegistry
  Reg := TRegistry.Create(KEY_READ);
  try
    // Define o root onde a chave está (HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE, etc.)
    Reg.RootKey := HKEY_CLASSES_ROOT;

    // Abre a chave onde o valor está armazenado
    if Reg.OpenKeyReadOnly('\EmuHub') then
    begin
      // Verifica se o valor existe
      if Reg.ValueExists('Diretorio') then
      begin
        // Lê o valor
        Result := Reg.ReadString('Diretorio');
      end;

      // Fecha a chave após ler o valor
      Reg.CloseKey;
    end;
  finally
    // Libera o recurso TRegistry
    Reg.Free;
  end;
end;

Function RetornaExtensao(Empresa, Emulador: String): String;
var
  Reg: TRegistry;
begin
  if Empresa = 'Nintendo' then
  begin
    if Emulador = 'DS' then
      Result := '.ds';
    if Emulador = 'GB' then
      Result := '.gb';
    if Emulador = 'GBA' then
      Result := '.gba';
    if Emulador = 'GBC' then
      Result := '.gbc';
    if Emulador = 'GC' then
      Result := '.rvz';
    if Emulador = 'N64' then
      Result := '.n64';
    if Emulador = 'NES' then
      Result := '.nes';
    if Emulador = 'SNES' then
      Result := '.smc';
  end
  else if Empresa = 'Sega' then
  begin
    if Emulador = 'DC' then
      Result := '.gdi';
    if Emulador = 'MD' then
      Result := '.bin';
  end
  else if Empresa = 'Sony' then
  begin
    if Emulador = 'PS1' then
      Result := '.iso';
    if Emulador = 'PS2' then
      Result := '.iso';
  end;


end;

end.
