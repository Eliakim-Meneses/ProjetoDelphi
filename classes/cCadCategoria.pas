unit cCadCategoria;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZConnection, ZAbstractConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCategoria = Class // Declara��o do tipo de classe
  private
    ConexaoDB: TZConnection;
    F_categoriaId: integer; //Int
    f_descricao: String;
    function getCodigo: integer;
    function getDescricao: String;
    procedure setCodigo(const Value: integer);
    procedure setDescricao(const Value: String);    //Varchar
    //Vars privadas, apenas para classe
  public
    constructor Create(aConexao: TZConnection); //Construtor da classe
    destructor Destroy; override; //Destroi a classe
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: integer): Boolean;
    //Vars publicas, acessiveis para todos
  published
    property codigo: integer read getCodigo write setCodigo;
    property descricao: String read getDescricao write setDescricao;
    //Vars publicas para propriedades da classe e informa��es em tempo de execu��o
  end;

implementation

{ TCategoria }

{$region 'CONSTRUCTOR/DESTRUCTOR'}
constructor TCategoria.Create(aConexao: TZConnection);  //Obriga a passagem de uma conex�o
begin
  ConexaoDB := aConexao; //Desta forma a conex�o � criada em tempo de execu��o
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'Fun��es CRUD'}
{ //c�digo pessoal para teste
function TCategoria.Apagar: Boolean;
var Qry: TZQuery; conf: TModalResult;

begin
  try
    Result := true;
    conf := MessageDlg('Tem certeza que deseja apagar o registro?'+#13+'C�digo: '+IntToStr(F_categoriaId)+#13+'Descri��o: '+f_descricao, mtConfirmation, [mbYes,mbNo], 0, mbNo);
    if (conf= mrNo) then begin
      Result := false;
      abort
    end
    else begin
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.add('DELETE FROM categorias WHERE categoriaId = :categoriaId');
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;
      Try
        Qry.ExecSQL;
        FreeAndNil(Qry);
      Except
        Result := false;
      End;
    end;
  finally
    if (Assigned(Qry)) then

  end;
end;}

function TCategoria.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o registro: '+#13+'C�digo: '+IntToStr(Self.F_categoriaId)+#13+'Descri��o: '+Self.f_descricao, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := false;
    abort;
  end;
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM categorias WHERE categoriaId = :categoriaId');
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;
  finally
    if (Assigned(Qry)) then
      FreeAndNil(Qry);
  end;

end;

function TCategoria.Atualizar: Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil); //n�o existe "self" em classes por ser algo criado din�micamente, utiliza-se "nil" para representar a falta de dono.
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.add('UPDATE categorias SET descricao = :descricao WHERE categoriaId = :categoriaId');
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString := Self.f_descricao;
    Try
      Qry.ExecSQL;
    Except
      Result := false;
    End;
  finally
    if (Assigned(Qry)) then
      FreeAndNil(Qry);
  end;
end;

function TCategoria.Inserir: Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil); //n�o existe "self" em classes por ser algo criado din�micamente, utiliza-se "nil" para representar a falta de dono.
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.add('INSERT INTO categorias (descricao) VALUES (:descricao)');
    Qry.ParamByName('descricao').AsString := Self.f_descricao;
    Try
      Qry.ExecSQL;
    Except
      Result := false;
    End;
  finally
    if (Assigned(Qry)) then
      FreeAndNil(Qry);
  end;
end;

function TCategoria.Selecionar(id: integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil); //n�o existe "self" em classes por ser algo criado din�micamente, utiliza-se "nil" para representar a falta de dono.
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.add('SELECT categoriaId, descricao FROM categorias WHERE categoriaId = :categoriaId');
    Qry.ParamByName('categoriaId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      Self.f_descricao := Qry.FieldByName('descricao').AsString;
    Except
      Result := false;
    End;
  finally
    if (Assigned(Qry)) then
      FreeAndNil(Qry);
  end;
end;
{$endregion}

{$region 'Encapsulamento'}
function TCategoria.getCodigo: integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;

procedure TCategoria.setCodigo(const Value: integer);
begin
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := Value;
end;
{$endregion}
end.
