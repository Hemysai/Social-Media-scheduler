import json
import requests
import boto3
import os
import urllib.request
from datetime import datetime

# Initialize S3 client
s3 = boto3.client('s3')

def lambda_handler(event, context):
    # Fetch Meta Graph API Access Token from environment variable
    access_token = os.environ['META_GRAPH_API_ACCESS_TOKEN']
    page_id = '9288922607872012'

    # Meta Graph API URL to fetch page engagement data
    url = f"https://graph.facebook.com/v22.0/{page_id}/insights/page_engaged_users?access_token={access_token}"

    try:
        # Making the request to Meta Graph API
        with urllib.request.urlopen(url) as response:
            data = json.loads(response.read().decode())
            print("Fetched data:", data)

            # Upload fetched data to S3 bucket
            s3.put_object(
                Bucket=os.getenv('S3_BUCKET'),  # Ensure S3_BUCKET is set as an environment variable in Lambda
                Key=f'engagement-data/{page_id}_engagement.json',
                Body=json.dumps(data),
                ContentType='application/json'
            )

        # Return success message
        return {
            'statusCode': 200,
            'body': json.dumps('Success!')
        }
    except Exception as e:
        # Log error and return failure message
        print("Error:", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps('Failed')
        }
