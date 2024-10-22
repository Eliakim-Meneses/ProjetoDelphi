unit cCadCliente;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZConnection, ZAbstractConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCliente = Class
  private
    ConexaoDB: TZConnection;
    //F_ = field
    F_clienteId: integer;
    F_nome, F_cep, F_endereco, F_bairro, F_cidade, F_estado, F_telefone, F_email: string;
    F_dataNascimento: TDateTime;

  public
    constructor Create(conexao: TZConnection);
    destructor Destroy; override;
    function Inserir: boolean;
    function Atualizar: boolean;
    function Selecionar(id: integer): boolean;
    function Apagar: boolean;


  published

  //Se n�o houver um tratamento espec�fico para o encapsulamento, o delphi permite realizar as opera��es diretamente
  //nas vari�vels privadas
    property codigo         :integer    read F_clienteId      write F_clienteId;
    property nome           :string     read F_nome           write F_nome;
    property cep            :string     read F_cep            write F_cep;
    property endereco       :string     read F_endereco       write F_endereco;
    property bairro         :string     read F_bairro         write F_bairro;
    property cidade         :string     read F_cidade         write F_cidade;
    property estado         :string     read F_estado         write F_estado;
    property telefone       :string     read F_telefone       write F_telefone;
    property email          :string     read F_email          write F_email;
    property dataNascimento :TDateTime  read F_dataNascimento write F_dataNascimento;

  end;


implementation

{ TCliente }

{$region 'CONSTRUTOR/DESTRUTOR'}
constructor TCliente.Create(conexao: TZConnection);
begin
  ConexaoDB := conexao;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}

function TCliente.Inserir: boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO clientes VALUES (:nome, :cep, :endereco, :bairro, :cidade, :estado, :telefone, :email, :dataNascimento)');
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('cep').AsString := Self.F_cep;
    Qry.ParamByName('endereco').AsString := Self.F_endereco;
    Qry.ParamByName('bairro').AsString := Self.F_bairro;
    Qry.ParamByName('cidade').AsString := Self.F_cidade;
    Qry.ParamByName('estado').AsString := Self.F_estado;
    Qry.ParamByName('telefone').AsString := Self.F_telefone;
    Qry.ParamByName('email').AsString := Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

function TCliente.Atualizar: boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE clientes '+
                'SET nome = :nome, cep = :cep, endereco = :endereco, '+
                  'bairro = :bairro, cidade = :cidade, estado = :estado, '+
                  'telefone = :telefone, email = :email, dataNascimento = :dataNascimento '+
                'WHERE clienteId = :clienteId');
    Qry.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('cep').AsString := Self.F_cep;
    Qry.ParamByName('endereco').AsString := Self.F_endereco;
    Qry.ParamByName('bairro').AsString := Self.F_bairro;
    Qry.ParamByName('cidade').AsString := Self.F_cidade;
    Qry.ParamByName('estado').AsString := Self.F_estado;
    Qry.ParamByName('telefone').AsString := Self.F_telefone;
    Qry.ParamByName('email').AsString := Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TCliente.Selecionar(id: integer): boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT * FROM clientes WHERE clienteId = :clienteId');
    //parambyname = passar par�metro
    Qry.ParamByName('clienteId').AsInteger := id;
    try
      Qry.Open; //abrir a query
      //fieldbyname = visualizar o par�metro
      Self.F_clienteId := Qry.FieldByName('clienteId').AsInteger;
      Self.F_nome := Qry.FieldByName('nome').AsString;
      Self.F_cep := Qry.FieldByName('cep').AsString;
      Self.F_endereco := Qry.FieldByName('endereco').AsString;
      Self.F_bairro := Qry.FieldByName('bairro').AsString;
      Self.F_cidade := Qry.FieldByName('cidade').AsString;
      Self.F_estado := Qry.FieldByName('estado').AsString;
      Self.F_telefone := Qry.FieldByName('telefone').AsString;
      Self.F_email := Qry.FieldByName('email').AsString;
      Self.F_dataNascimento := Qry.FieldByName('dataNascimento').AsDateTime;
    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;

function TCliente.Apagar: boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o registro: '+#13+'C�digo: '+IntToStr(F_clienteId)+#13+'Nome: '+F_nome,mtConfirmation,[mbYes,mbNo],0, mbNo) = mrNo then
  begin
    Result := false;
    abort
  end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM clientes WHERE clienteId = :clienteId');
    Qry.ParamByName('clienteId').AsInteger := F_clienteId;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;
  finally
    if(Assigned(Qry)) then
      FreeAndNil(Qry);
  end;
end;

{$endregion}

{$region 'ENCAPSULAMENTO'}
//N�o possui pelo uso particular das properties no inicio do c�digo
{$endregion}

end.
