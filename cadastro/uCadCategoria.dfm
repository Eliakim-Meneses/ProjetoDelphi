inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientHeight = 465
  ClientWidth = 760
  ExplicitWidth = 766
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 760
    Height = 419
    ActivePage = tabManutencao
    ExplicitWidth = 760
    ExplicitHeight = 419
    inherited tabListagem: TTabSheet
      ExplicitWidth = 752
      ExplicitHeight = 391
      inherited pnlListagemTopo: TPanel
        Width = 752
        ExplicitWidth = 752
      end
      inherited grdListagem: TDBGrid
        Width = 752
        Height = 329
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 563
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 752
      ExplicitHeight = 391
      object edtCategoriaId: TLabeledEdit
        Tag = 1
        Left = 4
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
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 64
        Width = 400
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 1
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 419
    Width = 760
    ExplicitTop = 419
    ExplicitWidth = 760
    DesignSize = (
      760
      46)
    inherited btnFechar: TBitBtn
      Left = 681
      ExplicitLeft = 681
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId, descricao FROM categorias')
    Left = 536
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Left = 584
  end
end
