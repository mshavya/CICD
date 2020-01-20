import boto3
import requests
from requests_aws4auth import AWS4Auth
import json
import itertools
from operator import itemgetter
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib

credentials = boto3.Session().get_credentials()

def get_account_number():
    client = boto3.client("sts", aws_access_key_id=credentials.access_key,
                          aws_secret_access_key=credentials.secret_key, aws_session_token=credentials.token)
    account_number = client.get_caller_identity()["Account"]
    return account_number

def get_auth_token_mycloud():
    awsauth = AWS4Auth(
        credentials.access_key,
        credentials.secret_key,
        'us-east-1',
        'execute-api',
        session_token=credentials.token
    )
    return awsauth

def get_component_tags_name(resource_id):
    if "loadbalancer" in resource_id:
        elb_tags = boto3.client('elbv2')
    try:
        _tags= elb_tags.describe_tags(ResourceArns=[resource_id,])
    for value in _tags["TagDescriptions"]:
        component_tag = [tags["Value"] for tags in value["Tags"] if tags["Key"]=="component"][0]
    email = get_owner_email_address(component_tag)
    return email
    except Exception as e:
    _tags= "Not found "+str(e)
    email = get_owner_email_address(_tags)
    return email
    elif "cloudfront" in resource_id:
    cloud_front_tags = boto3.client('cloudfront')
    try:
        _tags= cloud_front_tags.list_tags_for_resource(Resource=resource_id)
    values=_tags["Tags"]["Items"]
    for value in values:
        if value["Key"] == "component":
        component_tag = value["Value"]
    email = get_owner_email_address(component_tag)
    return email
    except Exception as e :
    _tags= "error" + str(e)
    return "ISGAWSTeam@JohnDeere.com"

def get_owner_email_address(component):
    try:
        endpoint = "https://ulaja23xda.execute-api.us-east-1.amazonaws.com/v1"+"/accounts/" + get_account_number()+ "/components/" +component
    response = requests.get(endpoint, auth=get_auth_token_mycloud())
    response_data = response.text
    json_data = json.loads(response_data)
    if response.status_code == 200:
        return json_data['component']['contactEmail']
    elif response.status_code == 404:
    return "ISGAWSTeam@JohnDeere.com"
    except Exception as e :
    return "ISGAWSTeam@JohnDeere.com"

def get_certificate_description(arn):
    acm_client = boto3.client("acm", region_name='us-east-1', aws_access_key_id=credentials.access_key,
                              aws_secret_access_key=credentials.secret_key, aws_session_token=credentials.token)
    response = acm_client.describe_certificate(CertificateArn=arn)
    return response

def send_email_to_owners(**kwargs):
    """ Sends an email with the given contents to the given email address"""
    msg = MIMEText(kwargs["body"])
    msg['Subject'] = kwargs["subject"]
    msg['From'] = kwargs["mail_from"]
    msg['To'] = kwargs["mail_to"]

    s = smtplib.SMTP('mail.dx.deere.com')
    s.sendmail(kwargs["mail_from"], [kwargs["mail_to"]], msg.as_string())
    s.quit()
    return ['Email Send']

def email_pre_sorting(dict_email_list):
    """
    Add the body_string to add the content to the email
    :param dict_email_list:
    :return:
    """
    try:
        body_string = "The Following resources are email validated \n"
    resource=''
    for email in dict_email_list:
        print(email)
    if email == "ISGAWSTeam@JohnDeere.com":
        subject="Resources That can't be found"
    else:
    subject="SSL Cert migrate validation"
    for resources in dict_email_list[email]:
        resource = resource+"\n" +str(resources) + "\n"
    send_email_to_owners(subject=subject,mail_to=email,body=body_string+resource)
    return "Success"
    except Exception as e:
    return (str(e))


def lambda_handler(event, context):
    email_needs_to_send = dict()
    acm_client = boto3.client("acm", region_name='us-east-1', aws_access_key_id=credentials.access_key,
                              aws_secret_access_key=credentials.secret_key, aws_session_token=credentials.token)

    certificates_acm_client = acm_client.list_certificates()
    for acm in certificates_acm_client['CertificateSummaryList']:
        describe_certificate = get_certificate_description(acm['CertificateArn'])
    if "ValidationMethod" in describe_certificate['Certificate']["DomainValidationOptions"][0]:
        if describe_certificate['Certificate']["DomainValidationOptions"][0]["ValidationMethod"] == 'EMAIL' :
        associated_resources = describe_certificate["Certificate"]["InUseBy"]
    for i_value in associated_resources:
        email = get_component_tags_name(i_value)
        email = get_component_tags_name(describe_certificate)
    try:
        email_needs_to_send[email].append(i_value)
        email = get_component_tags_name(describe_certificate)
    except Exception as e:
    email_needs_to_send[email]=[]
    email_needs_to_send[email].append(i_value)
    email = get_component_tags_name(describe_certificate)
    ###
    # Uncomment the email_pre_sorting() to send the email
    ###
    # email_pre_sorting(email_needs_to_send)
    return email_needs_to_send