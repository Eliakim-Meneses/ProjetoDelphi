unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, uDTMConexao, cCadCliente, uEnum;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    lblCep: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtTelefone: TMaskEdit;
    lblTelefone: TLabel;
    edtEmail: TLabeledEdit;
    edtData: TDateEdit;
    Label1: TLabel;
    edtEstado: TLabeledEdit;
    qryListagemclienteId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemcep: TWideStringField;
    qryListagemendereco: TWideStringField;
    qryListagembairro: TWideStringField;
    qryListagemcidade: TWideStringField;
    qryListagemestado: TWideStringField;
    qryListagemtelefone: TWideStringField;
    qryListagememail: TWideStringField;
    qryListagemdataNascimento: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
  private
    oCliente: TCliente;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

{$region 'OVERRIDES'}
function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (edtClienteId.Text <> EmptyStr) then
    oCliente.codigo := StrToInt(edtClienteId.Text)
  else
    oCliente.codigo := 0;

  oCliente.nome := edtNome.Text;
  oCliente.endereco := edtEndereco.Text;
  oCliente.bairro := edtBairro.Text;
  oCliente.cidade := edtCidade.Text;
  oCliente.estado := edtEstado.Text;
  oCliente.cep := edtCEP.Text;
  oCliente.telefone := edtTelefone.Text;
  oCliente.email := edtEmail.Text;
  oCliente.dataNascimento := StrToDate(edtData.Text);
    
  if(EstadoDoCadastro = ecInserir) then
    Result := oCliente.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCliente.Atualizar;

end;

function TfrmCadCliente.Apagar: Boolean;
begin
  if (oCliente.Selecionar(qryListagem.FieldByName('clienteId').AsInteger)) then
    Result := oCliente.Apagar;
end;
{$endregion}

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if oCliente.Selecionar(qryListagem.FieldByName('clienteId').AsInteger) then begin
    edtClienteId.Text := IntToStr(oCliente.codigo);
    edtNome.Text := oCliente.nome;
    edtCEP.Text := oCliente.cep;
    edtEndereco.Text := oCliente.endereco;
    edtBairro.Text := oCliente.bairro;
    edtCidade.Text := oCliente.cidade;
    edtEstado.Text := oCliente.estado;
    edtTelefone.Text := oCliente.telefone;
    edtEmail.Text := oCliente.email;
    edtData.Text := DateToStr(oCliente.dataNascimento);
  end
  else begin
    btnCancelar.Click;
    abort;
  end;
  inherited;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtData.Date := Date;
  edtNome.SetFocus;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
    FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  indiceAtual := 'nome';
  oCliente := TCliente.Create(dtmPrincipal.ConexaoDB);
end;

end.
