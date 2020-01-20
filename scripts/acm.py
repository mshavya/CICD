import boto3


# Create ACM client
acm = boto3.client('acm')

# List certificates with the pagination interface
paginator = acm.get_paginator('list_certificates')
for response in paginator.paginate():
    for certificate in response['CertificateSummaryList']:
        print(certificate["CertificateArn"])



import boto3
acm_client = boto3.client("acm")
certificates_acm_client = acm_client.list_certificates()
for acm in certificates_acm_client['CertificateSummaryList']:
    print(acm['CertificateArn'])
    print(acm['DomainName'])