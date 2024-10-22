unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao, uEnum;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    qryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
  private
    { Private declarations }

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator; pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): string;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
  public
    { Public declarations }
    EstadoDoCadastro: TEstadoDoCadastro;
    indiceAtual: string;
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation
{$R *.dfm}

{$region 'OBSERVA��ES'}
//TAG: 1 - Chave Prim�ria
//TAG: 2 - Campos Obrigat�rios
{$endregion}

{$region 'FUN��ES/PROCEDIMENTOS'}
//Procedures de controle de tela/bot�es
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
 pgcPrincipal: TPageControl; Flag: Boolean);
begin
  btnNovo.Enabled := Flag;
  btnAlterar.Enabled := Flag;
  btnCancelar.Enabled := not(Flag);
  BtnGravar.Enabled := not(Flag);
  btnApagar.Enabled := Flag;
  Navegador.Enabled := Flag;
  pgcPrincipal.Pages[0].TabVisible := Flag;
end;

//CTRL + SHIFT + C = declara a nova procedure automaticamente
procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
begin
  if(pgcPrincipal.Pages[Indice].TabVisible) then
    pgcPrincipal.TabIndex := Indice;
end;

//Retorna o nome definido(caption) para o campo(coluna) da database
function TfrmTelaHeranca.RetornarCampoTraduzido(Campo: String):string;
var  i: Integer;
begin
  for I := 0 to qryListagem.Fields.Count-1 do begin
    if (lowercase(qryListagem.Fields[i].FieldName) = lowercase(Campo)) then begin
      Result := qryListagem.Fields[i].DisplayLabel;
      Break;
    end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo: String; aLabel: TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio:Boolean;
var i: integer;
begin
  Result := false;
  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TLabeledEdit then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
          (TLabeledEdit(Components[i]).Text = EmptyStr) then begin
          //TAG 2 = PARA CAMPOS OBRIGAT�RIOS
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' � um campo obrigat�rio!', mtInformation,[mbOK],0);
        TLabeledEdit(Components[i]).SetFocus;
        Result := true;
        Break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.DesabilitarEditPK;
var i: integer;

begin
  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TLabeledEdit then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
        //TAG 1 = PARA CHAVE PRIM�RIA
        TLabeledEdit(Components[i]).Enabled := false;
        break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i: integer;
begin
  for i := 0 to ComponentCount-1 do begin
    if Components[i] is TLabeledEdit then
      TLabeledEdit(Components[i]).Text := EmptyStr
    else if Components[i] is TEdit then
      TEdit(Components[i]).Text := EmptyStr;
  end;
end;
{$endregion}

{$region 'M�TODOS VIRTUAIS'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('DELETADO');
  Result := true;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if(EstadoDoCadastro = ecInserir) then
    ShowMessage('Inserido')
  else if (EstadoDoCadastro = ecAlterar) then
    ShowMessage('Alterado');
  Result := true;
end;
{$endregion}

{$region '���ES DE BOT�ES'}
//Procedures bot�es
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecAlterar;

end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  try
    if (Apagar) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
        ControlarIndiceTab(pgcPrincipal, 0);
        LimparEdits;
        qryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na Exclus�o', mtError, [mbOK], 0);
    end;
  finally
    EstadoDoCadastro := ecNenhum;
  end;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits;
  end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
    if(ExisteCampoObrigatorio) then begin
      abort;
    end;
  Try
    if (Gravar(EstadoDoCadastro)) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      qryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro de grava��o', mtError, [mbOK], 0);
    end;
  Finally

  End;
end;
{$endregion}

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  qryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := qryListagem;
  grdListagem.DataSource := dtsListagem;
  btnNavigator.DataSource := dtsListagem;
  EstadoDoCadastro := ecNenhum;
  grdListagem.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if(qryListagem.SQL.Text <> EmptyStr) then begin
    qryListagem.IndexFieldNames := indiceAtual;
    ExibirLabelIndice(indiceAtual, lblIndice);
    qryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
end;



procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  indiceAtual := Column.FieldName;
  qryListagem.IndexFieldNames := indiceAtual;
  ExibirLabelIndice(indiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  qryListagem.Locate(indiceAtual, TMaskEdit(Sender).Text, [loPartialKey,loCaseInsensitive]);
end;

end.
