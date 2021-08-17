## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo = FALSE, out.width = '100%'-----------------------------------------
knitr::include_graphics("tcs_reg.png")

## ----echo = FALSE, out.width = '100%'-----------------------------------------
knitr::include_graphics("token.png")

## ----eval = FALSE-------------------------------------------------------------
#  install.packages("tcsinvest")

## ----eval = FALSE-------------------------------------------------------------
#  devtools::install_github("arbuzovv/tcsinvest",build_vignettes = TRUE)

## ----eval = FALSE-------------------------------------------------------------
#  options(download.file.method = "libcurl")

## ----eval = FALSE-------------------------------------------------------------
#  Sys.timezone()
#  Sys.setenv(TZ='GMT')
#  Sys.timezone()

## -----------------------------------------------------------------------------
library(tcsinvest)

## ----eval = FALSE-------------------------------------------------------------
#  token = 'my_token'
#  live = FALSE

## ----eval = FALSE-------------------------------------------------------------
#  getStocks(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getETFs(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getCurrencies(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getBonds(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  universe = getUniverse(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  universe[ticker=='SBER']

## ----eval = FALSE-------------------------------------------------------------
#  universe[substr(name,1,3)=="ОФЗ"]

## ----eval = FALSE-------------------------------------------------------------
#  View(universe)

## ----eval = FALSE-------------------------------------------------------------
#  getSymbolInfo(token,live,figi = 'BBG005HLTYH9')
#  getTickerInfo(token,live,'SBER')

## ----eval = FALSE-------------------------------------------------------------
#  getQuotes(token,live,figi = 'BBG005HLTYH9')

## ----eval = FALSE-------------------------------------------------------------
#  getHistoricalData(token,live,figi = 'BBG005HLTYH9',from = Sys.Date() - 2,to = Sys.Date(),interval = "hour")

## ----eval = FALSE-------------------------------------------------------------
#  getOrderBook(token,live,figi = 'BBG005HLTYH9',depth = 10)

## ----eval = FALSE-------------------------------------------------------------
#  getAccounts(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getBalance(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getOperations(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getPortfolio(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  getOrders(token,live,only_live_orders = F)

## ----eval = FALSE-------------------------------------------------------------
#  getTrades(token,live)

## ----eval = FALSE-------------------------------------------------------------
#  marketOrder(token,live,figi='BBG005HLTYH9',direction='Buy',lots=1)

## ----eval = FALSE-------------------------------------------------------------
#  limitOrder(token,live,figi='BBG005HLTYH9',direction='Buy',lots=1,price=1)

## ----eval = FALSE-------------------------------------------------------------
#  cancelOrder(token,live,'orderId')

## ----eval = FALSE-------------------------------------------------------------
#  client = streamClient(token)

## ----eval = FALSE-------------------------------------------------------------
#  streamStatus(client)

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = TRUE,type='instrument_info',figi='BBG004730N88')

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = FALSE,type='instrument_info',figi='BBG004730N88')

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = TRUE,type='orderbook',figi='BBG004730N88',depth=1)

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = FALSE,type='orderbook',figi='BBG004730N88',depth=1)

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = TRUE,type='candle',figi='BBG004730N88',interval='1min')

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = FALSE,type='candle',figi='BBG004730N88',interval='1min')

## ----eval = FALSE-------------------------------------------------------------
#  streamClose(client)

## ----eval = FALSE-------------------------------------------------------------
#  bid_ask_spread = function(x)
#  {
#    spread = min(x$asks[,1])-max(x$bids[,1])
#    print(spread)
#  }

## ----eval = FALSE-------------------------------------------------------------
#  streamStatus(client)
#  streamSubscribe(client,subscribe = TRUE,type='orderbook',FUN = 'bid_ask_spread',figi='BBG004730N88',depth=5)

## ----eval = FALSE-------------------------------------------------------------
#  streamSubscribe(client,subscribe = FALSE,type='orderbook',FUN = 'bid_ask_spread',figi='BBG004730N88',depth=5)
#  streamClose(client)

## ----eval = FALSE-------------------------------------------------------------
#  sandboxRegister(token)

## ----eval = FALSE-------------------------------------------------------------
#  sandboxDeleteAccount(token)

## ----eval = FALSE-------------------------------------------------------------
#  sandboxBalance(token,balance = 10000,currency = 'USD')

## ----eval = FALSE-------------------------------------------------------------
#  sandboxPositions(token,balance = 100,figi = 'BBG000BMFNP4')

## ----eval = FALSE-------------------------------------------------------------
#  sandboxDeletePositions(token)

## ----eval = FALSE-------------------------------------------------------------
#  # задаем баланс в песочнице на который будем торговать
#  token = 'your_sandbox_token_from_tcs_account'
#  live = FALSE
#  sandboxBalance(token,balance = 100000,currency = 'RUB')
#  getBalance(token,live)
#  
#  # информация об инструменте
#  capital = 100000
#  ticker_info = getTickerInfo(token,live,ticker = 'SBER' )
#  lots = ticker_info$lot
#  figi_code = ticker_info$figi
#  
#  # бесконечный цикл торговли
#  while(2==2)
#  {
#  # инфомация о сигнале и необходимой позиции (теоретической)
#  history = getHistoricalData(token,live,figi_code,from = Sys.Date()-1,interval = '1min')
#  last_ret = tail(history$c/history$o-1,1)
#  size = floor(capital/getQuotes(token,live,figi_code)$lastPrice/lots)
#  theor_position = ifelse(last_ret>0,size,0)
#  
#  # фактическое состояние портфеля
#  my_portfolio = getPortfolio(token,live)
#  if(length(my_portfolio)>0)
#    current_position = my_portfolio[figi==figi_code]$lots
#  current_position = ifelse(length(current_position)==0,0,current_position)
#  
#  # приводим теоретическое состояние к фактическому
#  if(theor_position!=current_position)
#  {
#    direction = ifelse(theor_position-current_position>0,'Buy','Sell')
#    marketOrder(token,live,figi_code,direction=direction,lots=abs(theor_position-current_position))
#  }
#  
#  # печать совершенных сделок и ожидание следующей минуты
#  print(getTrades(token,live))
#  Sys.sleep(60)
#  }

