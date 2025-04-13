import json
import requests
import boto3
import datetime

def lambda_handler(event, context):
    access_token = "EAAoAZCze4rTMBOxSsloWjusVQ2SUdLCs9zQwEhYxUDRc8ZAWSV9maY319VkKlZAUiMXFcJmp4ttXlZBMMatSCPRUaqsmdO07wiRqnZCNyPMwd05bH0qfnOQj4hvAnuHE56pMoqyiq2wY1xWqkfTqZBQF1pMZAmEVjgow8P5dGsXoXlFgjCHxPcZCbRhcUIK1fOZAhmA3EGj2vwXpOmOIne9qbuKIlHV2n4Iom2KQZD"  
    ig_user_id = "9288922607872012" 
    s3_bucket = "insta-insights-hemanth"  

    metrics = "impressions,reach,profile_views,followers_count"
    period = "day"

    url = (
        f"https://graph.facebook.com/v22.0/{ig_user_id}/insights"
        f"?metric={metrics}&period={period}&access_token={access_token}"
    )

    try:
        response = requests.get(url)
        insights = response.json()

        s3 = boto3.client('s3')
        timestamp = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H-%M-%SZ")
        filename = f"ig-insights-{timestamp}.json"

        s3.put_object(
            Bucket=s3_bucket,
            Key=filename,
            Body=json.dumps(insights),
            ContentType='application/json'
        )

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Success!', 'filename': filename})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
