#https://medium.com/%E5%B7%A5%E7%A8%8B%E9%9A%A8%E5%AF%AB%E7%AD%86%E8%A8%98/%E7%88%AC%E5%8F%96%E5%8F%B0%E8%82%A1%E6%B8%85%E5%96%AE%E4%B8%A6%E4%B8%94%E5%AF%AB%E5%85%A5-datebase-87c6d3f1348b
#https://www.pttweb.cc/bbs/Python/M.1593614461.A.060
#https://github.com/Benny0624/HiStock_Crawler/blob/main/HiStock_Crawler_v2.py
import requests
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
from fake_useragent import UserAgent

url = "https://histock.tw/stock/branch.aspx?no=2317&day=180"
user_agent = UserAgent()
headers = {'user-agent': user_agent.random}

res = requests.get(url, headers = headers)
soup = BeautifulSoup(res.content, "html.parser")
table = soup.find("table", class_="tb-stock tbChip tbHide")
for row in table.find_all("tr")[1:]:
    print([cell.get_text(strip=True) for cell in row.find_all("td")])
