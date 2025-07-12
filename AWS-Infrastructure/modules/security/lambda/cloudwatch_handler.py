import base64
import gzip
import json
import os
import urllib3
import uuid

def handler(event, context):
    splunk_url = os.environ['SPLUNK_HEC_URL']
    splunk_token = os.environ['SPLUNK_HEC_TOKEN']
    
    http = urllib3.PoolManager()
    
    # Decode CloudWatch Logs data
    log_data = json.loads(gzip.decompress(base64.b64decode(event['awslogs']['data'])))
    
    for log_event in log_data['logEvents']:
        splunk_event = {
            "event": {
                "message": log_event['message'],
                "logGroup": log_data['logGroup'],
                "logStream": log_data['logStream'],
                "timestamp": log_event['timestamp']
            },
            "sourcetype": "aws:cloudwatch",
            "channel": str(uuid.uuid4())
        }
        
        http.request(
            'POST',
            splunk_url,
            body=json.dumps(splunk_event),
            headers={
                'Authorization': f'Splunk {splunk_token}',
                'Content-Type': 'application/json'
            }
        )
    
    return {'statusCode': 200}
