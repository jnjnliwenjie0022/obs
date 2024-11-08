import scrapy


class BankSpider(scrapy.Spider):
    name = "bank"
    allowed_domains = ["concords.moneydj.com"]
    start_urls = ["https://concords.moneydj.com/z/zc/zco/zco_1101.djhtm"]

    def parse(self, response):
        pass
