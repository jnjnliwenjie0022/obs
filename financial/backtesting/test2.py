
from mtksdk.data.ai import securities
from mtksdk import sdk_status

req_item = securities.Request(stock_id='3008')
data, err = self.sdk.query(req_item)
if err == sdk_status.NONE:
    print(data)
