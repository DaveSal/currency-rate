module CurrencyRate
  class PoloniexAdapter < Adapter
    SUPPORTED_CURRENCIES = %w(BTS DASH DOGE LTC NXT STR XEM XMR XRP USDT
                              ETH SC DCR LSK STEEM ETC REP ARDR ZEC STRAT
                              GNT ZRX CVC OMG GAS STORJ EOS SNT KNC BAT
                              LOOM QTUM USDC MANA BNT BCHABC BCHSV FOAM
                              NMR POLY LPT ATOM TRX ETHBNT LINK XTZ PAX
                              USDJ SNX MATIC MKR DAI NEO SWFTC FXC AVA
                              CHR BNB BUSD MDT XFIL LEND REN LRC WRX SXP
                              STPT SWAP EXE).freeze

    ANCHOR_CURRENCY = "BTC".freeze

    FETCH_URL = "https://poloniex.com/public?command=returnTicker".freeze

    def normalize(data)
      return nil unless super

      data.each_with_object({ "anchor" => ANCHOR_CURRENCY }) do |(pair_name, pair_info), result|
        next unless pair_name.include?(ANCHOR_CURRENCY)

        key = pair_name.sub(ANCHOR_CURRENCY, "").sub("_", "")

        result[key] =
          if pair_name.index(ANCHOR_CURRENCY) == 0
            1 / BigDecimal(pair_info["last"])
          else
            BigDecimal(pair_info["last"])
          end
      end
    end
  end
end
