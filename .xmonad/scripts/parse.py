# pip3 install bs4
import requests
import urllib.request

from bs4 import BeautifulSoup

#URL = "https://www.banki.ru/products/currency/cash/sankt-peterburg/"


URL = "https://www.banki.ru/products/currency/cash/sankt-peterburg/#sort=sale&order=asc&currency_sort=840"
source = requests.get( URL ).text
soup = BeautifulSoup( source, "html.parser" )


exchange_list = soup.find_all( attrs={ "data-test": "exchange-row" } )
#exchange_list = soup.find_all( class_ = "exchange-calculator-rates table-flex__row-group" )

for item in exchange_list:
    bank_name = item.a.text
    usd  = item.find_all( attrs = { "data-currencies-code" : "USD" } )
    buy  = usd[0].get( "data-currencies-rate-buy" )
    sell = usd[1].get( "data-currencies-rate-sell" )
    print( f"{bank_name}|{sell}" )

    #with open( "out.txt", "w" ) as f:
    #    print( f"{bank_name}|{sell}", file = f )  # Python 3.x

    break
