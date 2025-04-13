import json
import requests
import boto3
import os
import urllib.request
from datetime import datetime
s3 = boto3.client('s3')
def lambda_handler(event, context):
        access_token = os.environ['META_GRAPH_API_ACCESS_TOKEN']
        page_id = '9288922607872012'
        url = f"https://graph.facebook.com/v22.0/{page_id}/insights/page_engaged_users?access_token={access_token}"

        try:
            with urllib.request.urlopen(url) as response:
                data = json.loads(response.read().decode())
                print("Fetched data:", data)

                s3.put_object(
                Bucket=os.getenv('S3_BUCKET'),
                Key=f'engagement-data/{page_id}_engagement.json',
                Body=json.dumps(data),
                ContentType='application/json'
                )
            return {
                'statusCode': 200,
                'body': json.dumps('Success!')
            }
        except Exception as e:
            print("Error:", str(e))
            return {
                'statusCode': 500,
                'body': json.dumps('Failed')
                }
