import logging
from mtksdk.sdk import SDK
from mtksdk.sdk_status import TACO_CONNECTED

sdk = SDK(True, 'YOUR_ACCOUNT', 'YOUR_PASSWORD', log_level=logging.CRITICAL)
status = sdk.login()

if status == TACO_CONNECTED :
    print('connected')
else:
    print('connect failed')
