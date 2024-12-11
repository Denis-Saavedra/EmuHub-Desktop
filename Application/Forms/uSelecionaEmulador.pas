unit uSelecionaEmulador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TformSelecionaEmulador = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSelecionaEmulador: TformSelecionaEmulador;

implementation

uses
  uMenuPrincipal;

{$R *.dfm}

procedure TformSelecionaEmulador.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    TformMenuPrincipal(Owner).EmuladorSelecionado := ListBox1.Items[ListBox1.ItemIndex];
    Close;
  end;
end;

end.
