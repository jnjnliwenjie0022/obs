#https://medium.com/%E5%B7%A5%E7%A8%8B%E9%9A%A8%E5%AF%AB%E7%AD%86%E8%A8%98/%E7%88%AC%E5%8F%96%E5%8F%B0%E8%82%A1%E6%B8%85%E5%96%AE%E4%B8%A6%E4%B8%94%E5%AF%AB%E5%85%A5-datebase-87c6d3f1348b
#https://www.pttweb.cc/bbs/Python/M.1593614461.A.060
import requests
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
from fake_useragent import UserAgent

from datetime import datetime

# 抓取股票資訊
url = "https://histock.tw/stock/branch.aspx?no=2317&day=180"
user_agent = UserAgent()
headers = {'user-agent': user_agent.random}

# 獲取 html 資訊
res = requests.get(url, headers = headers)
tmp = BeautifulSoup(res.text, 'lxml').select_one('tb-stock tbChip tbHide')

table = soup.find("table", class_="tb-stock tbChip tbHide")
data = table.find_all("tr")
print(data)
exit()

df = pd.read_html(tmp.prettify())[0]
# 優化一下欄位名稱
df.columns = ['stock_no', 'stock_name', 'price', 'ud', 'udp', 'ud_w', 'amp','open', 'high', 'low', 'price_y', 'vol', 'vol_p']
# 新增欄位註記資料更新時間
df["etl_date"] = datetime.now()
print(df)
