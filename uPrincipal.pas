unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrio1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    Vendas1: TMenuItem;
    Cliente2: TMenuItem;
    N3: TMenuItem;
    Produto2: TMenuItem;
    N4: TMenuItem;
    VendaPorData1: TMenuItem;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  {
  dtmPrincipal := TdtmPrincipal.Create(Self);
  dtmPrincipal.ConexaoDB.Protocol := 'mssql';
  dtmPrincipal.ConexaoDB.LibraryLocation := 'C:\ProjetoDelphi\ntwdblib.dll';
  dtmPrincipal.ConexaoDB.HostName := '.\SERVERCURSO';
  dtmPrincipal.ConexaoDB.Port := 1433;
  dtmPrincipal.ConexaoDB.User := 'sa';
  dtmPrincipal.ConexaoDB.Password := '123456';
  dtmPrincipal.ConexaoDB.Database := 'vendas';
  dtmPrincipal.ConexaoDB.SQLHourGlass := true;
  dtmPrincipal.ConexaoDB.Connected := true;
  }

  //Para simplificar, utilizar método abaixo que executa todas as operações sobre o objeto "ConexaoDB"
  dtmPrincipal := TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do begin
    Protocol := 'mssql';
    LibraryLocation := '..\ntwdblib.dll';
    HostName := '.\SERVERCURSO';
    Port := 1433;
    User := 'sa';
    Password := '123456';
    Database := 'vendas';
    SQLHourGlass := true;
    Connected := true;
  end;

end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

end.
