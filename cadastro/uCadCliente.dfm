inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 470
  ClientWidth = 919
  ExplicitWidth = 925
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 919
    Height = 424
    ExplicitWidth = 919
    ExplicitHeight = 424
    inherited tabListagem: TTabSheet
      ExplicitWidth = 911
      ExplicitHeight = 396
      inherited pnlListagemTopo: TPanel
        Width = 911
        ExplicitWidth = 911
      end
      inherited grdListagem: TDBGrid
        Width = 911
        Height = 334
        Columns = <
          item
            Expanded = False
            FieldName = 'clienteId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 911
      ExplicitHeight = 396
      object lblCep: TLabel
        Left = 428
        Top = 48
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lblTelefone: TLabel
        Left = 428
        Top = 192
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label1: TLabel
        Left = 3
        Top = 240
        Width = 96
        Height = 13
        Caption = 'Data de Nascimento'
      end
      object edtClienteId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 21
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 64
        Width = 400
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 30
        TabOrder = 1
      end
      object edtCEP: TMaskEdit
        Left = 428
        Top = 64
        Width = 140
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 3
        Top = 112
        Width = 400
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 30
        TabOrder = 3
      end
      object edtBairro: TLabeledEdit
        Left = 428
        Top = 112
        Width = 220
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 30
        TabOrder = 4
      end
      object edtCidade: TLabeledEdit
        Left = 3
        Top = 160
        Width = 400
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 30
        TabOrder = 5
      end
      object edtEmail: TLabeledEdit
        Left = 3
        Top = 208
        Width = 400
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'E-mail'
        MaxLength = 30
        TabOrder = 7
      end
      object edtData: TDateEdit
        Left = 3
        Top = 256
        Width = 137
        Height = 21
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 9
      end
      object edtTelefone: TMaskEdit
        Left = 428
        Top = 208
        Width = 137
        Height = 21
        EditMask = '(99) 9999-9999;1;_'
        MaxLength = 14
        TabOrder = 8
        Text = '(  )     -    '
      end
      object edtEstado: TLabeledEdit
        Left = 428
        Top = 160
        Width = 53
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Estado'
        MaxLength = 30
        TabOrder = 6
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 424
    Width = 919
    ExplicitTop = 424
    ExplicitWidth = 919
    inherited btnFechar: TBitBtn
      Left = 840
      ExplicitLeft = 840
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT * FROM clientes')
    Left = 632
    object qryListagemclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 32
      FieldName = 'nome'
      Required = True
      Size = 64
    end
    object qryListagemtelefone: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 14
    end
    object qryListagememail: TWideStringField
      DisplayLabel = 'E-mail'
      DisplayWidth = 48
      FieldName = 'email'
      Size = 128
    end
    object qryListagemcep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object qryListagemendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 32
      FieldName = 'endereco'
      Size = 64
    end
    object qryListagembairro: TWideStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 16
      FieldName = 'bairro'
      Size = 32
    end
    object qryListagemcidade: TWideStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 16
      FieldName = 'cidade'
      Size = 32
    end
    object qryListagemestado: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object qryListagemdataNascimento: TDateTimeField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'dataNascimento'
    end
  end
  inherited dtsListagem: TDataSource
    Left = 688
  end
end
