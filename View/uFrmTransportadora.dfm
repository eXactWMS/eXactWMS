inherited FrmTransportadora: TFrmTransportadora
  Caption = 'FrmTransportadora'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Id'
            'Raz'#227'o Social'
            'Fantasia')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited PgcEndereco: TcxPageControl
        inherited TbEndCobranca: TcxTabSheet
          ExplicitTop = 24
          ExplicitWidth = 1168
          ExplicitHeight = 128
        end
      end
      inherited PnlInfo: TPanel
        Left = 826
        Top = 206
        ExplicitLeft = 826
        ExplicitTop = 206
      end
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
end
