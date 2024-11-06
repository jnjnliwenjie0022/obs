from selenium import webdriver
from bs4 import BeautifulSoup
import requests

driver = webdriver.Chrome('chromedriver')
driver.implicitly_wait(10)
driver.get('https://histock.tw/stock/branch.aspx?no=1301')
print(driver.title)
html = driver.page_source
print(html)

soup = BeautifulSoup(driver.page_source, 'lxml')
print(soup.prettify())

with open('index.html', 'w', encoding='utf-8',) as file:
    file.write(soup.prettify())

driver.quit()
