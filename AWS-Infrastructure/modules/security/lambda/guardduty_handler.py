import json
import os
import urllib3
import uuid

def handler(event, context):
    splunk_url = os.environ['SPLUNK_HEC_URL']
    splunk_token = os.environ['SPLUNK_HEC_TOKEN']
    
    http = urllib3.PoolManager()
    
    splunk_event = {
        "event": event['detail'],
        "sourcetype": "aws:guardduty",
        "channel": str(uuid.uuid4())
    }
    
    response = http.request(
        'POST',
        splunk_url,
        body=json.dumps(splunk_event),
        headers={
            'Authorization': f'Splunk {splunk_token}',
            'Content-Type': 'application/json'
        }
    )
    
    return {
        'statusCode': response.status,
        'body': response.data.decode('utf-8')
    }
