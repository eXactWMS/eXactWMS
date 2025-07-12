inherited FrmMotorista: TFrmMotorista
  Caption = 'FrmMotorista'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        ColumnHeaders.Strings = (
          'Id'
          'C'#243'd.ERP'
          'Nome'
          'Fantasia'
          'Cnpj/Cpf'
          'Email'
          'Home Page'
          'Status')
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Id'
            'Nome')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LblRota: TLabel
        Left = 665
        Top = 177
        Visible = False
        ExplicitLeft = 665
        ExplicitTop = 177
      end
      inherited LblTransportadora: TLabel
        Left = 168
        Top = 177
        Visible = True
        ExplicitLeft = 168
        ExplicitTop = 177
      end
      inherited EdtEmail: TLabeledEdit
        Left = 101
        EditLabel.ExplicitLeft = 67
        EditLabel.ExplicitTop = 137
        EditLabel.ExplicitWidth = 31
        ExplicitLeft = 101
      end
      inherited EdtFantasia: TLabeledEdit
        Visible = False
      end
      inherited EdtRazao: TLabeledEdit
        Left = 101
        EditLabel.Width = 36
        EditLabel.Caption = 'Nome'
        EditLabel.ExplicitLeft = 62
        EditLabel.ExplicitTop = 55
        EditLabel.ExplicitWidth = 36
        ExplicitLeft = 101
      end
      inherited edtCodigoErp: TLabeledEdit
        Left = 343
        EditLabel.ExplicitLeft = 267
        EditLabel.ExplicitTop = 11
        EditLabel.ExplicitWidth = 73
        Visible = False
        ExplicitLeft = 343
      end
      inherited EdtID: TLabeledEdit
        Left = 101
        EditLabel.ExplicitLeft = 82
        EditLabel.ExplicitTop = 11
        EditLabel.ExplicitWidth = 16
        Visible = True
        ExplicitLeft = 101
      end
      inherited EdtCNPJCPF: TLabeledEdit
        Left = 101
        EditLabel.ExplicitLeft = 21
        EditLabel.ExplicitTop = 96
        EditLabel.ExplicitWidth = 77
        ExplicitLeft = 101
      end
      inherited PgcEndereco: TcxPageControl
        inherited TbEndereco: TcxTabSheet
          ExplicitTop = 24
          ExplicitWidth = 1168
          ExplicitHeight = 128
        end
        inherited TbEndCobranca: TcxTabSheet
          ExplicitTop = 24
          ExplicitWidth = 1168
          ExplicitHeight = 128
        end
      end
      inherited EdtRotaId: TLabeledEdit
        Left = 598
        Top = 174
        EditLabel.ExplicitLeft = 568
        EditLabel.ExplicitTop = 178
        EditLabel.ExplicitWidth = 27
        Visible = False
        ExplicitLeft = 598
        ExplicitTop = 174
      end
      inherited BtnPesqRota: TBitBtn
        Left = 635
        Top = 174
        Visible = False
        ExplicitLeft = 635
        ExplicitTop = 174
      end
      inherited EdtTransportadoraid: TLabeledEdit
        Left = 101
        Top = 174
        EditLabel.ExplicitLeft = 7
        EditLabel.ExplicitTop = 178
        Visible = True
        ExplicitLeft = 101
        ExplicitTop = 174
      end
      inherited BtnTransportadoraPesq: TBitBtn
        Left = 138
        Top = 174
        Visible = True
        ExplicitLeft = 138
        ExplicitTop = 174
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
end
