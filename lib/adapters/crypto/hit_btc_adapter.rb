module CurrencyRate
  class HitBTCAdapter < Adapter
    SUPPORTED_CURRENCIES = %w(ZRC EDG IHT AEON SOC HBAR ZRX OPT APPC DRGN PTOY
                              XDN OKB CHSB NCT GUSD GET FUN EXP EMRX REV GHOST
                              BMH SNC DTR ERD SCL HMQ ACT ETC QTUM MTX SBTC
                              KIND SMT BTB SWFTC 1ST UTT AXPR NMR EVX IOTA XPRM
                              STMX SALT DGB NTK AMM ALGO ORMEUS BDG BQX EKO FYP
                              IPX HOT MG BTS ADX CRPT WAXP POA PLBT SHIP HTML
                              BOX GNO UBT BTT ZEN VEO POA20 BCPT SRN XPR ETHBNT
                              MANA QKC MLN FLP SOLO TRUE VSYS JST GNT BOS PHB
                              ZEC ESH SWM NANO VIBE HVN SOLVE ELEC LRC AGI LNC
                              WAVES WTC ONT STRAT GNX NEU BCN XPNT ECA ARDR KIN
                              LSK USE IOTX CRO IDH LINK OAX CPT NGC XNS KEY TKY
                              HSR TNT SMART TRST DCR WINGS GT MKR ONE DOGE ARN
                              ACAT BMC RAISE EXM TIME REX FDZ HT MTH SCC BET
                              DENT IDRT IPL ZAP CMCT TDP XAUR MTL NEBL SUSDT BAT
                              STEEM CUR BYTZ PRO LOOM USD DRG DICE ADK COMP DRT
                              XTZ WETH EURS CHZ NEO NPLC XCON LEVL PAX AIM PART
                              PRE ERK HEDG FET PAXG DAG AVA CUTE NEXO DAY PITCH
                              MITX NXT POWR PLR CVCOIN TUSD MYST DLT REM RLC DNA
                              FOTA SBD ELF TEL C20 PNT CND UTK ASI CVC ETP ETH
                              ZIL ARPA INK NPXS LEO MESH NIM DATX FXT PBT GST
                              BSV GAS CBC MCO SENT GBX XRC POE SUR LOC WIKI PPT
                              CVT APM LEND NUT DOV KMD AYA LUN XEM RVN BCD XMR
                              NWC USG CLO NLC2 BBTC BERRY ART GRIN VITAE XBP OMG
                              MDA KRL BCH POLY PLA BANCA ENJ TRIGX UUU PASS ANT
                              LAMB BIZZ RFR AMB ROOBEE BST LCC RCN MIN BUSD DIT
                              PPC AE IQ BNK CENNZ SUB OCN DGD VRA STX AERGO HGT
                              TRAD IGNIS REP DAPP DNT CDT YCC SNGLS ICX PKT COV
                              PAY ABYSS BLZ DAV TKN ERT SPC SEELE XZC MAID AUTO
                              REN DATA AUC TV LAVA KAVA DAI DAPS ADA COCOS MITH
                              SETH NRG PHX DASH VLX CHAT VET EOSDT ZSC KNC DGTX
                              CEL SHORTUSD IOST BNB PBTT XMC EMC VIB BNT STORJ
                              ATOM LCX SC FTT BTM XLM TRX CELR BRD DBIX ETN SNT
                              MOF HEX XUC PLU FACE TNC SIG PXG BDP BTX TAU DCT
                              YOYOW SYBC SWT MAN GLEEC EOS XVG NAV CURE XRP KICK
                              BRDG LTC USDC MATIC FTX BTG PMA).freeze

    ANCHOR_CURRENCY = "BTC".freeze

    FETCH_URL = "https://api.hitbtc.com/api/2/public/ticker".freeze

    def normalize(data)
      return nil unless super

      data.each_with_object({ "anchor" => ANCHOR_CURRENCY }) do |pair_info, result|
        pair_name = pair_info["symbol"]
        next unless pair_name.include?(ANCHOR_CURRENCY)

        key = pair_name.sub(ANCHOR_CURRENCY, "")

        result[key] =
          if pair_name.index(ANCHOR_CURRENCY) == 0
            BigDecimal(pair_info["last"])
          else
            1 / BigDecimal(pair_info["last"])
          end
      end
    end
  end
end
