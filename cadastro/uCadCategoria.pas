unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, cCadCategoria, uDTMConexao, uEnum;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    qryListagemcategoriaId: TIntegerField;
    qryListagemdescricao: TWideStringField;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
  private
    oCategoria: TCategoria;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  if (oCategoria.Selecionar(qryListagem.FieldByName('categoriaId').AsInteger)) then begin

{    oCategoria.codigo := qryListagem.FieldByName('categoriaId').AsInteger;
    oCategoria.descricao := qryListagem.FieldByName('descricao').AsString;}
    Result := oCategoria.Apagar;
  end;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if(edtCategoriaId.Text <> EmptyStr) then
    oCategoria.codigo := StrToInt(edtCategoriaId.Text)
  else
    oCategoria.codigo := 0;
  oCategoria.descricao := edtDescricao.Text;
  if(EstadoDoCadastro = ecInserir) then
    Result := oCategoria.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCategoria.Atualizar;
end;
{$endregion}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if(oCategoria.Selecionar(qryListagem.FieldByName('categoriaId').AsInteger)) then begin
    edtCategoriaId.Text := IntToStr(oCategoria.codigo);
    edtDescricao.Text := oCategoria.descricao;
  end
  else begin
    btnCancelar.Click;
    abort
  end;
  inherited;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //Assigned checa se a vari�vel est� instanciada na memoria
  if Assigned(oCategoria) then
    FreeAndNil(oCategoria);
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  indiceAtual := 'descricao';
  oCategoria := TCategoria.Create(dtmPrincipal.ConexaoDB);
end;



end.
