##Trend LineTrend Line
## 計算大盤 2022-06-29 融資維持率
#
#import numpy as np
#import pandas as pd
#import requests
#
#from finlab import data
#
#融資今日餘額 = data.get('margin_transactions:融資今日餘額')
#融資券總餘額 = data.get('margin_balance:融資券總餘額')
#融資券總餘額 = 融資券總餘額.loc[融資今日餘額.index.intersection(融資券總餘額.index)]
#融資券總餘額['上市融資買賣超'] = (融資券總餘額['上市融資交易金額']-融資券總餘額['上市融資交易金額'].shift()).fillna(0)/100000000
#融資券總餘額['上櫃融資買賣超'] = (融資券總餘額['上櫃融資交易金額']-融資券總餘額['上櫃融資交易金額'].shift()).fillna(0)/100000000
#
#close = data.get('price:收盤價')
#benchmark = data.get('benchmark_return:發行量加權股價報酬指數').squeeze()
#融資總餘額 = 融資券總餘額[['上市融資交易金額','上櫃融資交易金額']].sum(axis=1)
#融資餘額市值 = (融資今日餘額*close*1000).sum(axis=1)
#融資維持率 = (融資餘額市值/融資總餘額)
#融資維持率
#
#exit()
#
#
#token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoiMjAyNC0xMC0xNyAxMjozNTo0NiIsInVzZXJfaWQiOiJqbmpuMDAyMiIsImlwIjoiMjcuMjQ3LjEwMi42MyJ9.4BfGHxPU-M05uFp7HvEINgQrqCcSbug8SdlW8SJv8po"
#url = "https://api.finmindtrade.com/api/v4/data"
#
##url = "https://api.web.finmindtrade.com/v2/user_info"
##payload = {
##    "token": token
##}
##resp = requests.get(url, params=payload)
##print(resp.json()["user_count"])  # 使用次數
##print(resp.json()["api_request_limit"])  # api 使用上限
##exit()
#
#from FinMind.data import DataLoader
#
#api = DataLoader()
## api.login_by_token(api_token='token')
## api.login(user_id='user_id',password='password')
##df = api.taiwan_stock_government_bank_buy_sell(
##    start_date='2023-01-17',
##)
#
#api = DataLoader()
#api.login_by_token(api_token=token)
#api.login(user_id='jnjn0022',password='jason0022')
#df = api.taiwan_total_exchange_margin_maintenance(
#)
#print(df)
#exit()
#
## filter stock_id
#parameter = {
#    "dataset": "TaiwanStockInfo",
#    "token": token, # 參考登入，獲取金鑰
#}
#data = requests.get(url, params=parameter)
#TaiwanStockInfo = data.json()
#TaiwanStockInfo = pd.DataFrame(TaiwanStockInfo['data'])
#TaiwanStockInfo['is_bt'] = TaiwanStockInfo['stock_name'].map(lambda x: True if '乙特' in x else False)
#TaiwanStockInfo['is_at'] = TaiwanStockInfo['stock_name'].map(lambda x: True if '甲特' in x else False)
#
#mask = (
#    TaiwanStockInfo['type'].isin(['twse']) & 
#    ~TaiwanStockInfo['industry_category'].isin(['ETF', '大盤']) &
#    ~TaiwanStockInfo['is_bt'] &
#    ~TaiwanStockInfo['is_at']
#)
#print(TaiwanStockInfo[mask].tail())
#stock_type_list = TaiwanStockInfo[mask]['stock_id'].unique()
#
## 獲得個股每日收盤價
##parameter = {
##    "dataset": "TaiwanStockPrice",
##    "start_date": "2022-06-29",
##    "token": token, # 參考登入，獲取金鑰
##}
##resp = requests.get(url, params=parameter)
##TaiwanStockPrice = resp.json()
##
###TaiwanStockPrice = pd.DataFrame(TaiwanStockPrice["data"])
##print(TaiwanStockPrice); exit()
##TaiwanStockPrice = pd.DataFrame(TaiwanStockPrice["data"])
##print(TaiwanStockPrice[["date", "stock_id", "close"]].head())
#
## 獲得個股每日融資張數
##parameter = {
##    "dataset": "TaiwanStockMarginPurchaseShortSale",
##    "start_date": "2022-06-29",
##    "token": token, # 參考登入，獲取金鑰
##}
##resp = requests.get(url, params=parameter)
##TaiwanStockMarginPurchaseShortSale = resp.json()
##TaiwanStockMarginPurchaseShortSale = pd.DataFrame(TaiwanStockMarginPurchaseShortSale["data"])
##TaiwanStockMarginPurchaseShortSale = TaiwanStockMarginPurchaseShortSale[
##    ['date', 'stock_id', 'MarginPurchaseTodayBalance']
##]
##print(TaiwanStockMarginPurchaseShortSale.head())
#
#
## 獲得大盤融資餘額
#parameter = {
#    "dataset": "TaiwanStockTotalMarginPurchaseShortSale",
#    "start_date": "2022-06-29",
#    "token": token, # 參考登入，獲取金鑰
#}
#data = requests.get(url, params=parameter)
#TaiwanStockTotalMarginPurchaseShortSale = data.json()
#TaiwanStockTotalMarginPurchaseShortSale = pd.DataFrame(TaiwanStockTotalMarginPurchaseShortSale['data'])
#TaiwanStockTotalMarginPurchaseShortSale = TaiwanStockTotalMarginPurchaseShortSale[TaiwanStockTotalMarginPurchaseShortSale['name']=='MarginPurchaseMoney']
#TaiwanStockTotalMarginPurchaseShortSale = TaiwanStockTotalMarginPurchaseShortSale[TaiwanStockTotalMarginPurchaseShortSale['date']=='2022-06-29']
#print(TaiwanStockTotalMarginPurchaseShortSale[["date", "TodayBalance"]].tail())
#exit()
#
## 計算2022-06-29 大盤融資維持率
#merge_data = pd.merge(TaiwanStockPrice, TaiwanStockMarginPurchaseShortSale, on=['date', 'stock_id'], how='left')
#merge_data['MarginPurchaseTotalValue'] = merge_data['MarginPurchaseTodayBalance'] * merge_data['close'] * 1000
#value = merge_data[merge_data['stock_id'].isin(stock_type_list)]['MarginPurchaseTotalValue'].sum()
#print(f"2022-06-29 大盤融資維持率:{value / TaiwanStockTotalMarginPurchaseShortSale['TodayBalance'].values[0]}")
#
#import requests



#https://www.youtube.com/watch?v=58G-wrOx8Mk
import pandas as pd
#{{{ tv data access
from tvDatafeed import TvDatafeed, Interval
from datetime import datetime

username = 'jnjn0022'
password = 'jasonliwenjie0022'
tv = TvDatafeed(username, password)

df = tv.get_hist(symbol='TWSE:IX0001', exchange='NSE', interval=Interval.in_daily,n_bars=100000)
df = df.reset_index()
df = df.drop(columns = ["symbol"])
df = df.rename(columns={'datetime': 'Date', 'open': 'Open', 'high': 'High', 'low': 'Low', 'close': 'Close', 'volume': 'Volume'})
df['Date'] = pd.to_datetime(df['Date']).dt.date
df['Date'] = pd.to_datetime(df['Date'])
df.set_index('Date',inplace=True)
#df = df[df.index > '1993-01-01']
#}}}
##{{{ yf data access
#import yfinance as yf
##df = yf.download('2882.TW')
##df = yf.download('2882.TW', start = '2001-01-01')
##df = yf.download('1736.TW', start = '2001-01-01')
#df = yf.download('1301.TW')
##df = yf.download('2357.TW',start = '2004-09-01')
##df = yf.download('2454.TW')
##df = yf.download('00687b.TW', start = '2008-01-01')
##df = yf.download('2330.TW', start = '2008-01-01')
##stock = yf.Ticker('2882.TW')
##eps = stock.info['trailingEps']
##print(eps)
##stock_price = stock.history(period="max")
##stock_price = stock_price.reset_index()
##stock_price = stock_price.drop(columns = ["Date"])
##print(stock_price); print(stock_price.dtypes);
##stock_price.to_excel('df.xlsx', index=True); exit()
##df = yf.download('^TWII ')
##df = yf.download('0050.TW', start = '2010-01-01')
#df=df[df['Volume']!=0]
##print(df.isna().sum())
## }}} yf data access
#{{{ create timeline
time = pd.date_range(start='1900-01-01', end=pd.Timestamp.today(), freq='D')
time = pd.DataFrame(time, columns=['Date'])
time.set_index('Date',inplace=True)
#}}}
##{{{ statements data access
##https://www.youtube.com/watch?v=FWF3KMj_AA8&list=PLF4auM3DnsfLQroX9WV0nzczYJ9Dtuy6G
#import requests
#import json
#from pprint import pprint
#
#def stmt(TYPEK, year, season):
#    url = 'https://mops.twse.com.tw/mops/web/ajax_t163sb04'
#    #url = 'https://mops.twse.com.tw/mops/web/ajax_t163sb05'
#    #url = 'https://mops.twse.com.tw/mops/web/ajax_t163sb20'
#    parameter = {'firstin' :'1', TYPEK: TYPEK, 'year': str(year), 'season': str(season)}
#    response = requests.post(url, data = parameter)
#    df = pd.read_html(response.text)[1]
#    pprint(df)
#    print('here1')
#    df = pd.read_html(response.text)[2]
#    pprint(df)
#    print('here2')
#    df = pd.read_html(response.text)[3]
#    pprint(df)
#    exit()
#    df.insert(1, 'year', year)
#    df.insert(2, 'season', season)
#    return df
#
#data = stmt('sii', 110, 4)
#print(data)
#for x in range(109,101,-1):
#    row = stmt('sii',x , 4)
#    data = pd.concat([data,row])
#print(data); print(data.dtypes); data.to_excel('data.xlsx', index=True); exit()
#
##}}} statements data access
#{{{ website data access
# https://index.ndc.gov.tw/n/zh_tw/data/eco/indicators#/
# https://yhhuang1966.blogspot.com/2024/06/python_21.html
# https://www.youtube.com/watch?v=oeSNa1cHB3o
import requests
import json
from pprint import pprint
url='https://index.ndc.gov.tw/n/json/data/eco/indicators'
response=requests.post(url)
data = json.loads(response.text) #; pprint(data)
#data = pd.json_normalize(data['line']['33']['data']) # detect the highest indicator
data = pd.json_normalize(data['line']['34']['data']) # save indicator

# https://utrustcorp.com/python-pandas/
# https://medium.com/ntu-data-analytics-club/python-advanced-pandas-%E5%A5%97%E4%BB%B6%E5%BF%85%E5%AD%B8%E8%B3%87%E6%96%99%E8%99%95%E7%90%86%E5%87%BD%E6%95%B8%E4%BB%8B%E7%B4%B9%E8%88%87%E6%87%89%E7%94%A8-9b53ff16fab2
data = data.drop(columns = ["id"])
data = data.rename(columns={'x': 'Date'})
data = data.rename(columns={'y': 'L'})
data['Date'] = data['Date'] + '27'
data['Date'] = pd.to_datetime(data['Date'], format='%Y%m%d')
data['Date'] = data['Date'] + pd.DateOffset(months=1)
data['LDiff1'] = data['L'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
data['LDiff2'] = data['LDiff1'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)

def l_cycle_fun(row):
    ldiff1 = row['LDiff1']
    ldiff2 = row['LDiff2']
    if(ldiff1 > 0 and ldiff2 > 0):
        return 0.5
    elif(ldiff1 > 0 and ldiff2 < 0):
        return 1
    elif(ldiff1 < 0 and ldiff2 < 0):
        return -0.5
    elif(ldiff1 < 0 and ldiff2 > 0):
        return -1
data['LCycle'] = data.apply(lambda row: l_cycle_fun(row), axis=1)

data.set_index('Date',inplace=True)
data = pd.concat([time,data],axis=1)
data = data.ffill()
df = pd.concat([df,data],axis=1)
#}}} website data access
df = df.dropna()
#{{{ LCycle
#https://www.youtube.com/watch?v=WVNB_6JRbl0
import numpy as np

def l_cycle_signal(now, pre):
    if(now > 0 and pre < 0):
        return 1
    elif(now < 0 and pre > 0):
        return -1
    else:
        return 0
df['LCycleSignal'] = df['LDiff1'].rolling(window=2).apply(lambda row: l_cycle_signal(row.iloc[1], row.iloc[0]), raw=False)

def l_cycle_pos(x):
    if x['LCycleSignal'] == 1:
        return -1
    elif x['LCycleSignal'] == -1:
        return 1
    else:
        return np.nan
df['LCyclePos'] = df.apply(lambda row: l_cycle_pos(row), axis=1)
#}}} singal_lcycle
#{{{ EMA
import pandas_ta as ta
df['EMA_35d'] = ta.ema(df['Close'], length=35*1)
df['EMA_13w'] = ta.ema(df['Close'], length=13*5)
df['EMA_34w'] = ta.ema(df['Close'], length=34*5)
df['EMA_10y'] = ta.ema(df['Close'], length=10*240)
df['EMA_20y'] = ta.ema(df['Close'], length=20*240)
#}}} EMA
#{{{ RSI
df['RSI_6d'] = ta.rsi(df['Close'], length=6)

def rsi_6d_pos(x):
    if x['RSI_6d'] > 90:
        return 101
    elif x['RSI_6d'] < 10:
        return -1
    else:
        return np.nan
df['RSI_6dPos'] = df.apply(lambda row: rsi_6d_pos(row), axis=1)

def rsi_6d_eff_pos(x):
    if (x['RSI_6dPos'] == 101) and (x['LCycle'] > 0):
        return 101
    elif (x['RSI_6dPos'] == -1) and (x['LCycle'] == -1):
        return -1
    else:
        return np.nan
df['RSI_6dEffPos'] = df.apply(lambda row: rsi_6d_eff_pos(row), axis=1)
#}}} RSI
#{{{ figure
import plotly.graph_objs as go
from plotly.subplots import make_subplots
fig = make_subplots(rows=3, cols=1, shared_xaxes=True, row_heights=[20,4,1], vertical_spacing=0)
fig.append_trace(go.Candlestick(x = df.index, open = df['Open'], high = df['High'], low = df['Low'], close = df['Close']), row=1, col=1)
fig.add_scatter(x = df.index, y = df['EMA_35d'], name = 'EMA_35d', mode = "lines", line_color= "Purple", row=1,col=1)
fig.add_scatter(x = df.index, y = df['EMA_13w'], name = 'EMA_13w', mode = "lines", line_color= "Blue", row=1,col=1)
fig.add_scatter(x = df.index, y = df['EMA_34w'], name = 'EMA_34w', mode = "lines", line_color= "Red",row=1,col=1)
fig.add_scatter(x = df.index, y = df['EMA_10y'], name = 'EMA_10y', mode = "lines", line_color= "Blue",row=1,col=1)
fig.add_scatter(x = df.index, y = df['EMA_20y'], name = 'EMA_20y', mode = "lines", line_color= "Red",row=1,col=1)
fig.add_scatter(x = df.index, y = df['RSI_6d'], name = 'RSI_6d', mode = "lines", line_color= "Black",row=2,col=1)
fig.add_scatter(x = df.index, y = df['RSI_6dPos'], name = "RSI_6dPos", mode = "markers", marker=dict(size=10, color='Black'), row=2 ,col=1)
fig.add_scatter(x = df.index, y = df['RSI_6dEffPos'], name = "RSI_6dPos", mode = "markers", marker=dict(size=10, color='Red'), row=2 ,col=1)
fig.add_scatter(x = df.index, y = df['LCycle'], name = 'LCycle', mode = "lines", line_color= "Black", row=3 ,col=1)
fig.add_scatter(x = df.index, y = df['LCyclePos'], name = "LCyclePos", mode = "markers", marker=dict(size=10, color='Black'), row=3 ,col=1)
fig.update_layout(xaxis_rangeslider_visible=False)
#fig.update_layout(hovermode="x unified")
fig.update_layout(hovermode="x")
fig.update_layout(hoversubplots="axis")
fig.update_traces(xaxis='x1')
fig.update_layout(margin=dict(l=0.01,r=0.01,t=30,b=0.01))
config = {'scrollZoom' : True}
fig.show(config)
#}}} figure
#{{{ backtesting
from backtesting import Strategy
from backtesting import Backtest
import backtesting

def SIGNAL():
    return df.LCycleSignal

class BreakOut(Strategy):
    def init(self):
        super().init()

        self.signal1 = self.I(SIGNAL)

    def next(self):
        super().next()

        if self.signal1 == 1:
            self.buy()
        elif self.signal1 == -1:
            self.position.close()

bt = Backtest(df, BreakOut, cash=10000000, commission=.000, exclusive_orders=True)
stat = bt.run()
print(stat)
bt.plot()
#}}}
#print(df); print(df.dtypes); exit()
#print(df); print(df.dtypes); df.to_excel('df.xlsx', index=True); exit()


# reference
#https://lglbengo.wordpress.com/



#{{{ example
#import pandas as pd
#import numpy as np
#import plotly.graph_objects as go
#from scipy import stats
#
#
#df = pd.read_csv("EURUSD_Candlestick_1_D_BID_04.05.2003-21.01.2023.csv")
#print(df.dtypes)
#backcandles = 45
#def isPivot(candle, window):
#    """
#    function that detects if a candle is a pivot/fractal point
#    args: candle index, window before and after candle to test if pivot
#    returns: 1 if pivot high, 2 if pivot low, 3 if both and 0 default
#    """
#    if candle-window < 0 or candle+window >= len(df):
#        return 0
#    
#    pivotHigh = 1
#    pivotLow = 2
#    for i in range(candle-window, candle+window+1):
#        if df.iloc[candle].Low > df.iloc[i].Low:
#            pivotLow=0
#        if df.iloc[candle].High < df.iloc[i].High:
#            pivotHigh=0
#    if (pivotHigh and pivotLow):
#        return 3
#    elif pivotHigh:
#        return pivotHigh
#    elif pivotLow:
#        return pivotLow
#    else:
#        return 0
#window=3
#df['isPivot'] = df.apply(lambda x: isPivot(x.name,window), axis=1)
#
#def collect_channel(candle, backcandles, window):
#    localdf = df[candle-backcandles-window:candle-window]
#    #localdf['isPivot'] = localdf.apply(lambda x: isPivot(x.name,window), axis=1)
#    highs = localdf[localdf['isPivot']==1].High.values
#    idxhighs = localdf[localdf['isPivot']==1].High.index
#    lows = localdf[localdf['isPivot']==2].Low.values
#    idxlows = localdf[localdf['isPivot']==2].Low.index
#    
#    if len(lows)>=3 and len(highs)>=3:
#        sl_lows, interc_lows, r_value_l, _, _ = stats.linregress(idxlows,lows)
#        sl_highs, interc_highs, r_value_h, _, _ = stats.linregress(idxhighs,highs)
#    
#        return(sl_lows, interc_lows, sl_highs, interc_highs, r_value_l**2, r_value_h**2)
#    else:
#        return(0,0,0,0,0,0)
#df['Channel'] = [collect_channel(candle, backcandles, window) for candle in df.index]
#def isBreakOut(candle, backcandles, window):
#    if (candle-backcandles-window)<0:
#        return 0
#    
#    sl_lows, interc_lows, sl_highs, interc_highs, r_sq_l, r_sq_h = df.iloc[candle].Channel
#    
#    prev_idx = candle-1
#    prev_high = df.iloc[candle-1].High
#    prev_low = df.iloc[candle-1].Low
#    prev_close = df.iloc[candle-1].Close
#    
#    curr_idx = candle
#    curr_high = df.iloc[candle].High
#    curr_low = df.iloc[candle].Low
#    curr_close = df.iloc[candle].Close
#    curr_open = df.iloc[candle].Open
#
#    if ( prev_high > (sl_lows*prev_idx + interc_lows) and
#        prev_close < (sl_lows*prev_idx + interc_lows) and
#        curr_open < (sl_lows*curr_idx + interc_lows) and
#        curr_close < (sl_lows*prev_idx + interc_lows)): #and r_sq_l > 0.9
#        return 1
#    
#    elif ( prev_low < (sl_highs*prev_idx + interc_highs) and
#        prev_close > (sl_highs*prev_idx + interc_highs) and
#        curr_open > (sl_highs*curr_idx + interc_highs) and
#        curr_close > (sl_highs*prev_idx + interc_highs)): #and r_sq_h > 0.9
#        return 2
#    
#    else:
#        return 0
#df["isBreakOut"] = [isBreakOut(candle, backcandles, window) for candle in df.index]
#def SIGNAL():
#    return df.isBreakOut
#
#from backtesting import Strategy
#from backtesting import Backtest
#import backtesting
#
#class BreakOut(Strategy):
#    initsize = 0.1
#    mysize = initsize
#    def init(self):
#        super().init()
#        self.signal1 = self.I(SIGNAL)
#
#    def next(self):
#        super().next()
#        TPSLRatio = 1.2
#
#        if self.signal1==2 and len(self.trades)==0:   
#            print('in 2')
#            print(self.signal1)
#            sl1 = self.data.Low[-2]
#            tp1 = self.data.Close[-1] + abs(self.data.Close[-1]-sl1)*TPSLRatio
#            #tp2 = self.data.Close[-1] + abs(self.data.Close[-1]-sl1)*TPSLRatio/3
#            self.buy(sl=sl1, tp=tp1, size=self.mysize)
#            #self.buy(sl=sl1, tp=tp2, size=self.mysize)
#        
#        elif self.signal1==1 and len(self.trades)==0:         
#            print('in 1')
#            print(self.signal1)
#            sl1 = self.data.High[-2]
#            tp1 = self.data.Close[-1] - abs(sl1-self.data.Close[-1])*TPSLRatio
#            #tp2 = self.data.Close[-1] - abs(sl1-self.data.Close[-1])*TPSLRatio/3
#            self.sell(sl=sl1, tp=tp1, size=self.mysize)
#            #self.sell(sl=sl1, tp=tp2, size=self.mysize)
#
#bt = Backtest(df, BreakOut, cash=1000, margin=1/50, commission=.000)
#stat = bt.run()
#stat
#bt.plot()
#}}}
