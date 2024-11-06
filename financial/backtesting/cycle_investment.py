#https://www.youtube.com/watch?v=58G-wrOx8Mk

import pandas as pd

#{{{ generic function
def printexit (data):
    print(data); print(data.dtypes); exit()
def printxlsx (data):
    print(data); print(data.dtypes); data.to_excel('data.xlsx', index=True); exit()
#}}}
#{{{ timeline
def timeline ():
    time = pd.date_range(start='1900-01-01', end=pd.Timestamp.today(), freq='D')
    time = pd.DataFrame(time, columns=['Date'])
    time.set_index('Date',inplace=True)
    df = time
    return df
#}}}
#{{{ up-to-date OECD CLI
def up_to_date_oecd_cli():
    import requests
    import json
    #https://www.oecd.org/en/data/insights/data-explainers/2024/09/api.html
    #https://github.com/bdecon/econ_data/blob/master/APIs/OECD_Updated.ipynb
    #https://www.oecd.org/en/data/datasets/oecd-composite-leading-indicators-clis.html
    base = 'https://sdmx.oecd.org/public/rest/data/OECD.SDD.STES,DSD_STES@DF_CLI,4.1/.M.LI...AA...H?startPeriod=1960-12&dimensionAtObservation=AllDimensions'
    fmt = '&format=csvfilewithlabels'
    url =  f'{base}{fmt}'
    res = pd.read_csv(url)
    data = res.set_index(['REF_AREA', 'TIME_PERIOD'])['OBS_VALUE'].unstack().T
    data = data.reset_index()
    data = data.rename(columns={'TIME_PERIOD': 'Date'})
    data['Date'] = data['Date'] + '27'
    data['Date'] = pd.to_datetime(data['Date'], format='%Y-%m%d')
    data['Date'] = data['Date'] + pd.DateOffset(months=1)
    data.set_index('Date',inplace=True)
    print(data)
    data.to_excel('./database/oecd_cli.xlsx', index=True)
#}}}
#{{{ up-to-date FRED DGS
def up_to_date_fred_gds():
    from fredapi import Fred
    #https://www.youtube.com/watch?v=M_jswxN3iwI
    api_key = 'c21deba1522ef0b870942e49a31112f7'

    series_id = 'DGS10'
    fred = Fred(api_key=api_key)
    res = fred.get_series(series_id).to_frame()
    res = res.rename(columns={0: series_id})
    data = res

    series_id = 'DGS2'
    res = fred.get_series(series_id).to_frame()
    res = res.rename(columns={0: series_id})
    data = pd.concat([data,res],axis=1)

    series_id = 'DGS3MO'
    res = fred.get_series(series_id).to_frame()
    res = res.rename(columns={0: series_id})
    data = pd.concat([data,res],axis=1)

    series_id = 'FEDFUNDS'
    res = fred.get_series(series_id).to_frame()
    res = res.rename(columns={0: series_id})
    data = pd.concat([data,res],axis=1)

    print(data)
    data.to_excel('./database/fred_gds.xlsx', index=True)
    #CPIAUCNS
#}}}
#{{{ up-to-date NDC BCI
def up_to_date_ndc_bci():
    import json
    import numpy as np
    from pprint import pprint
    #https://index.ndc.gov.tw/n/zh_tw/data/eco#/
    with open('./database/ndc_bci.json') as j:
        j = json.load(j)
    data = pd.json_normalize(j['line']['34']['data'])
    data = data[['x']]
    data = data.rename(columns={'x': 'Date'})
    data['Date'] = data['Date'] + '27'
    data['Date'] = pd.to_datetime(data['Date'], format='%Y%m%d')
    data['Date'] = data['Date'] + pd.DateOffset(months=1)
    data['FL'] = pd.json_normalize(j['line']['34']['data'])['y']
    data['FLD1'] = data['FL'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
    data['FLD2'] = data['FLD1'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
    data['FLD1PN'] = data['FLD1'].apply(lambda x: 1 if x >= 0 else (-1 if x < 0 else np.nan))
    data['FLD2PN'] = data['FLD2'].apply(lambda x: 1 if x >= 0 else (-1 if x < 0 else np.nan))
    data['FLState'] = data.apply(lambda x: 0.5 if (x['FLD1PN'] >= 0 and x['FLD2PN'] >=0) else (1.0 if (x['FLD1PN'] >= 0 and x['FLD2PN'] < 0) else (-0.5 if (x['FLD1PN'] < 0 and x['FLD2PN'] < 0) else (-1.0 if (x['FLD1PN'] < 0 and x['FLD2PN'] >= 0) else None))), axis=1)
    data['SL'] = pd.json_normalize(j['line']['33']['data'])['y']
    data['SLD1'] = data['SL'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
    data['SLD2'] = data['SLD1'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
    data['SLD1PN'] = data['SLD1'].apply(lambda x: 1 if x >= 0 else (-1 if x < 0 else np.nan))
    data['SLD2PN'] = data['SLD2'].apply(lambda x: 1 if x >= 0 else (-1 if x < 0 else np.nan))
    data['SLState'] = data.apply(lambda x: 0.5 if (x['SLD1PN'] >= 0 and x['SLD2PN'] >=0) else (1.0 if (x['SLD1PN'] >= 0 and x['SLD2PN'] < 0) else (-0.5 if (x['SLD1PN'] < 0 and x['SLD2PN'] < 0) else (-1.0 if (x['SLD1PN'] < 0 and x['SLD2PN'] >= 0) else None))), axis=1)
    data['Light'] = pd.json_normalize(j['line']['2']['data'])['y']
    data.set_index('Date',inplace=True)
    print(data)
    data.to_excel('./database/ndc_bci.xlsx', index=True)
#}}}
#{{{ up-to-date stock by TV
def up_to_date_stock_by_tv():
    from tvDatafeed import TvDatafeed, Interval
    username = 'jnjn0022'
    password = 'jasonliwenjie0022'
    tv = TvDatafeed(username, password)
    data = tv.get_hist(symbol='TWSE:IX0001', exchange='NSE', interval=Interval.in_daily,n_bars=100000)
    data = data.reset_index()
    data = data.drop(columns = ["symbol"])
    data = data.rename(columns={'datetime': 'Date', 'open': 'Open', 'high': 'High', 'low': 'Low', 'close': 'Close', 'volume': 'Volume'})
    data['Date'] = pd.to_datetime(data['Date']).dt.date
    data['Date'] = pd.to_datetime(data['Date'])
    data.set_index('Date',inplace=True)
    #data = data[data.index > '1993-01-01']
    print(data)
    data.to_excel('./database/stock.xlsx', index=True)
#}}}
##{{{ up-to-date stock by YF
#import yfinance as yf
##df = yf.download('2882.TW')
##df = yf.download('2882.TW', start = '2001-01-01')
##df = yf.download('1736.TW', start = '2001-01-01')
#df = yf.download('8299.TWO', start = '2001-01-01')
##df = yf.download('1301.TW')
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
#{{{ load OECD CLI
def load_oecd_cli (df):
    import numpy as np

    csv = pd.read_excel('./database/oecd_cli.xlsx')
    csv.set_index('Date',inplace=True)
    data = csv[['USA']]
    data = data.rename(columns={'USA': 'CLI'})
    data['CLID1'] = data['CLI'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
    data['CLID2'] = data['CLID1'].rolling(window=2).apply(lambda row: row.iloc[1] - row.iloc[0], raw=False)
    data['CLID1PN'] = data['CLID1'].apply(lambda x: 1 if x >= 0 else (-1 if x < 0 else np.nan))
    data['CLID2PN'] = data['CLID2'].apply(lambda x: 1 if x >= 0 else (-1 if x < 0 else np.nan))
    data['CLIState'] = data.apply(lambda x: 0.5 if (x['CLID1PN'] >= 0 and x['CLID2PN'] >=0) else (1.0 if (x['CLID1PN'] >= 0 and x['CLID2PN'] < 0) else (-0.5 if (x['CLID1PN'] < 0 and x['CLID2PN'] < 0) else (-1.0 if (x['CLID1PN'] < 0 and x['CLID2PN'] >= 0) else None))), axis=1)
    df = pd.concat([df,data],axis=1)
    df = df.dropna(how='all')
#}}}
#{{{ load NDC BCI
def load_ndc_bci(df):
    csv = pd.read_excel('./database/ndc_bci.xlsx')
    csv.set_index('Date',inplace=True)
    df = pd.concat([df,csv],axis=1)
    df = df.dropna(how='all')
#}}}
#{{{ dfill
def dfill (time, df):
    df = pd.concat([time,df],axis=1)
    df = df.ffill()
#}}}
#{{{ load stock
def load_stock(df):
    csv = pd.read_excel('./database/stock.xlsx')
    csv.set_index('Date',inplace=True)
    df = pd.concat([df,csv],axis=1)
    df = df[df['Volume'].notna()]
#}}}
##{{{ EMA
#import pandas_ta as ta
#df['EMA_35d'] = ta.ema(df['Close'], length=35*1)
#df['EMA_13w'] = ta.ema(df['Close'], length=13*5)
#df['EMA_34w'] = ta.ema(df['Close'], length=34*5)
#df['EMA_10y'] = ta.ema(df['Close'], length=10*240)
#df['EMA_20y'] = ta.ema(df['Close'], length=20*240)
##}}} EMA
##{{{ RSI
#df['RSI_6d'] = ta.rsi(df['Close'], length=6)
#
#def rsi_6d_pos(x):
#    if x['RSI_6d'] > 90:
#        return 101
#    elif x['RSI_6d'] < 10:
#        return -1
#    else:
#        return np.nan
#df['RSI_6dPos'] = df.apply(lambda row: rsi_6d_pos(row), axis=1)
#
#def rsi_6d_eff_pos(x):
#    if (x['RSI_6dPos'] == 101) and (x['LCycle'] > 0):
#        return 101
#    elif (x['RSI_6dPos'] == -1) and (x['LCycle'] == -1):
#        return -1
#    else:
#        return np.nan
#df['RSI_6dEffPos'] = df.apply(lambda row: rsi_6d_eff_pos(row), axis=1)
#}}} RSI
def main():
    #up_to_date_oecd_cli()
    #up_to_date_fred_gds()
    #up_to_date_ndc_bci()
    #up_to_date_stock_by_tv()
    #up_to_date_stock_by_yf()
    time = timeline()
    df = time
    print(df)
    df = load_oecd_cli(df)
    df = load_ndc_bci(df)
    df = dfill(time, df)
    df = load_stock(df)
    exit()

if __name__ == '__main__':
    main()

#{{{ figure
import plotly.graph_objs as go
from plotly.subplots import make_subplots
fig = make_subplots(rows=3, cols=1, shared_xaxes=True, row_heights=[1,1,1], vertical_spacing=0)
#fig.append_trace(go.Candlestick(x = df.index, open = df['Open'], high = df['High'], low = df['Low'], close = df['Close']), row=1, col=1)
fig.add_scatter(x = df.index, y = df['Close'], name = 'Close', mode = "lines", line_color= "Black", row=1 ,col=1)
fig.add_scatter(x = df.index, y = df['FLD1'], name = 'FLD1', mode = "lines", line_color= "Red", row=2 ,col=1)
fig.add_scatter(x = df.index, y = df['SLD1'], name = 'SLD1', mode = "lines", line_color= "Blue", row=2 ,col=1)
fig.add_scatter(x = df.index, y = df['Light'], name = 'SLD1', mode = "lines", line_color= "Blue", row=3 ,col=1)
fig.update_layout(xaxis_rangeslider_visible=False)
fig.update_layout(hovermode="x unified")
fig.update_layout(hoversubplots="axis")
fig.update_traces(xaxis='x1')
fig.update_layout(margin=dict(l=0.01,r=0.01,t=30,b=0.01))
fig.update_yaxes({'zerolinecolor': 'Black'},row =2, col =1)
fig.show()
#}}} figure
#{{{ signal
import numpy as np
df['Signal'] = df['FLD1'].rolling(window=2).apply(lambda x: 1 if (x.iloc[1] >= 0 and x.iloc[0] < 0) else (-1 if (x.iloc[1] < 0 and x.iloc[0] >= 0) else 0))
#}}}
#{{{ backtesting
from backtesting import Strategy
from backtesting import Backtest
import backtesting

def SIGNAL():
    return df['Signal']

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


###########################
###{{{ manufacturing indicator
#with open('m.json') as j:
#    j = json.load(j)
#
#data = pd.json_normalize(j['line']['55']['data']) # save indicator
#data = data[['x']]
#data = data.rename(columns={'x': 'Date'})
#data['Date'] = data['Date'] + '01'
#data['Date'] = pd.to_datetime(data['Date'], format='%Y%m%d')
#data['Date'] = data['Date'] + pd.DateOffset(months=1)
#data['PMI'] = pd.json_normalize(j['line']['55']['data'])['y']
#data['Future'] = pd.json_normalize(j['line']['66']['data'])['y']
#
#data.set_index('Date',inplace=True)
#data = pd.concat([time,data],axis=1)
#data = data.ffill()
#df = pd.concat([df,data],axis=1)
#df = df.dropna()
##}}}


