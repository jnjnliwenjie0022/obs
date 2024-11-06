import requests
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
from fake_useragent import UserAgent

import psycopg2
from sqlalchemy import create_engine
from datetime import datetime

# 抓取股票資訊
url = "https://histock.tw/stock/rank.aspx?p=all"
user_agent = UserAgent()
headers = {'user-agent': user_agent.random}

# 獲取 html 資訊
res = requests.get(url, headers = headers)
tmp = BeautifulSoup(res.text, 'lxml').select_one('#CPHB1_gv')
df = pd.read_html(tmp.prettify())[0]
# 優化一下欄位名稱
df.columns = ['stock_no', 'stock_name', 'price', 'ud', 'udp', 'ud_w', 'amp','open', 'high', 'low', 'price_y', 'vol', 'vol_p']
# 新增欄位註記資料更新時間
df["etl_date"] = datetime.now()
